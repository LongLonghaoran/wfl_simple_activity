# WflSimpleActivity

一个用以记录用户数据操作日志的Gem

## 安装

Add this line to your application's Gemfile:

```ruby
gem 'wfl_simple_activity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wfl_simple_activity

## 用法

    $ rails g wfl_simple_activity:install
    $ rake db:migrate

## 开发

#### 单表记录
* 执行上面两步之后,在需要记录数据变更的Model中 `include WflActivity` ,这样便会记录该Model的数据变更日志,在
    数据发生变化,将会创建 `activity`, 在项目中可以通过 `model_name.activities` 或者 `PublicActivity::Activity.where(condition)`来获取活动日志

#### 关联表记录 或者 其余特殊情况

* 如果需要在关联模型数据发生变更时记录当前模型的`activity`,需要自行在关联的模型中通过`model_name.create_activity key: 'article.commented_on', owner: current_user, recipient: recipientm`来创建`activity`,create_activity方法参数可参考 [PublicActivity::Common#create_activity](https://rubydoc.info/gems/public_activity/PublicActivity/Common:create_activity)

#### 注意事项

* 生成的migration文件中需自行migration版本指定对应的版本

* 例如: 
    ```ruby
        class CreateWflActivities < ActiveRecord::Migration[5.1]
        end
    ```

* 如果需要记录current_user 或者 调用其他在controller中的方法,需要在 `application_controller.rb`中 `include PublicActivity::StoreController`

* 自行获取 controller 上下文: 
    ```ruby 
    PublicActivity.get_controller 
    ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wfl_simple_activity.
