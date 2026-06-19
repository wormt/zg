# zg

grep or something

## USAGE

```bash
# check if echo outputs any numbers
echo "foo" | zg -e "\d"

# check if lines of a file have any alphanumeric characters
cat file.txt | zg -e "\w"
```
