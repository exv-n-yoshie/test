BRANCH_NAME=master
REMOTE_NAME=origin
# リモートの更新を取得
git fetch "$REMOTE_NAME"

LOCAL_COMMIT=$(git rev-parse "$BRANCH_NAME")
REMOTE_COMMIT=$(git rev-parse "$REMOTE_NAME/$BRANCH_NAME")

if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
  echo "ソース更新"

  echo "マイグレーションファイルの確認"
  # 追加されたマイグレーションファイルを検出
  ADDED_MIGRATIONS=$(git diff --name-status "$LOCAL_COMMIT" "$REMOTE_COMMIT" | grep '^A' | grep 'database/migrations/.*\.php')

  if [ -n "$ADDED_MIGRATIONS" ]; then
    echo "新しいマイグレーションファイルが見つかりました。マイグレーションを実行します。"
    # cd mfc-app
    # php composer.phar install
    # sudo /bin/bash -c "source /etc/awsenv/expenvparams.sh && /usr/bin/php -q ${REPO_DIR}/mfc-app/artisan migrate"
  else
    echo "新しいマイグレーションファイルはありません。"
  fi
fi