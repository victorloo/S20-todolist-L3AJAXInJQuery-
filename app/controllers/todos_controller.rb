class TodosController < ApplicationController
  def index
    # 限制 index action 載入的 todos 數量讓第一次載入時資料量能降低，
    # 並透過後續的捲動來載入更多資料。
    
    @todos = Todo.order("id DESC").limit(10)
    # 使用 order 方法，代入 id DESC 從 todo model 裡拿出反向排序的所有 todo 資料，
    # 接著用 limit 方法從中抽出 10 筆資料放入 @todos 裡。
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save

    # 設定 Server 回傳資料為 JSON
    render :json => { :id => @todo.id, :title => @todo.title }
  end

  def edit
    @todo = Todo.find(params[:id])

    # 設定 edit action 回傳資料為 JSON
    # 這裡不需要回傳 done，因為透過 edit action 更動的只有 title 屬性。
    render :json => { :id => @todo.id, :title => @todo.title }
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(todo_params)

    # 設定 update action 回傳資料為 JSON
    # 這裡不需要回傳 done，因為透過 update action 更動的只有 title 屬性。
    render :json => { :id => @todo.id, :title => @todo.title }
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    # 設定 Server 回傳資料為 JSON
    render :json => { :id => @todo.id }
  end

  def toggle_check
    @todo = Todo.find(params[:id])
    # 當值是 boolean 的時候，可以使用 toggle 方法來切換 true/false
    # 加上驚歎號表示會直接存入資料庫（否則要另外 save)
    # ref: http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-toggle
    @todo.toggle!(:done)

    # 設定 Server 回傳資料為 JSON
    render :json => { :id => @todo.id, :done => @todo.done }
  end

  # 撰寫 load action 載入接續的 todos
  def load
    # 判斷 params 裡是否有名為 current_id 的資料
    if params[:current_id]

      # 使用 Todo.where 方法取得小於 current_id 的 todos 資料，
      # 並使用 order 方法帶入 id DESC 取出反向排序的資料，
      # 接著用 limit 方法拿出 10 筆 todos，放入變數 @todos 裡
      @todos = Todo.where( "id < ?", params[:current_id]).order("id Desc").limit(10)
      
      # 透過 render 方法回傳該 JSON 格式的資料
      render json: {

        # 打算將 todo 的 id、title、done 傳遞給前端，
        # 因此在 @todos 上使用 map 方法重新映射出新陣列，
        # 將這個新陣列包在一個 data 裡
        data: @todos.map do |todo|
          {
            id: todo.id,
            title: todo.title,
            done: todo.done
          }
        end
      }
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end
end
