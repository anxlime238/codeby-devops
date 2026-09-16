#/bin/bash
set -e

current_date=$(date +%s)
mysqldump "lesson9" > "/opt/mysql_backup/lesson9_${current_date}.sql"

rsync -av "/opt/mysql_backup/lesson9_${current_date}.sql" 10.0.3.4::mysql/
