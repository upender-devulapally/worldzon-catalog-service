# README

### Tech versions
| Software      |  version      |       |
| ------------- |:-------------:| -----:|
| Ruby          | 2.6.3         |       |
| Rails         | 6.0.0         |       |
| Postgres      | 11.5          |       |

####install ruby(using rbnev)

```ruby
 rbenv install 2.6.3
 gem install bundler
 rbenv rehash
 gem install rails
 rbenv rehash
 rbenv local 2.6.3
OR
 rbenv global 2.6.3
```

#### Rails app generated with api only mode by skipping active-storage
```ruby
rails new worldzon-catalog-service --api -T --database=postgresql --skip-active-storage
```