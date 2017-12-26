DIR="/data/www/kingdom/src/DB_sql/kingdoms/*"
LOG="/var/tmp/migrate.log"
DB_NAME="kingdoms"
SQL_FILE_BASE_PATH=/data/www/kingdom/src/DB_sql

fileary=()
for filepath in ${DIR}; do
  #sql file配列に保存
  fileary+=("`basename $filepath`")
done

mysql -u root ${DB_NAME} -e "select name from tmp_migration order by id;" | sed '1d' > ${LOG}
logary=()
for line in `cat ${LOG} | grep -v ^#`
do
  #実行済みmigrationを配列に保存
  logary+=("`basename $line`")
done


for name in ${fileary[@]}; do
  flg=false

  for line in ${logary[@]}; do
    #差分比較
    if [ $name = $line ]; then
      flg=true
    fi
  done

  if [ $flg = false ];then
    #file実行
    mysql -u root ${DB_NAME} < ${SQL_FILE_BASE_PATH}/${DB_NAME}/${name}
    #db保存
    mysql -u root ${DB_NAME} -e "INSERT INTO tmp_migration (name, ins_date, up_date) values ('${name}', now(), '0000-00-00 00:00:00');"
  fi
done

