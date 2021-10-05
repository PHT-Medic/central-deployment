if [ -f .env ]
then
  # shellcheck disable=SC2046
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
