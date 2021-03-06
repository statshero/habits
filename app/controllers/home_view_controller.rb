class HomeViewController < UIViewController
  attr_reader :list
  def init
    if super
      build
    end
    self
  end
  def build
    
    @list = HabitListViewController.alloc.init
    @list.view.frame = [[0, 44],[self.view.bounds.size.width, self.view.bounds.size.height - 44]]
    view.addSubview(@list.view)
    
    @navbar = UIImageView.alloc.initWithImage UIImage.imageNamed("nav")
    self.view.addSubview(@navbar)

    add_title
    @info_button = BarImageButton.normalButtonWithImageNamed('info')
    @info_button.accessibilityLabel = "Information"
    @info_button.when(UIControlEventTouchUpInside) do
      self.showInfo
    end
    @info_button.frame = [[0,0], [44,44]]
    self.view.addSubview @info_button
    
    @info_count_badge = InfoCountBadge.alloc.initWithFrame [[28,8],[16,16]]
    self.view.addSubview @info_count_badge

    @add_button = BarImageButton.normalButtonWithImageNamed('add')
    @add_button.accessibilityLabel = "Add new habit"
    @add_button.when(UIControlEventTouchUpInside) do
      self.addItem
    end
    # navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView @add_button
    @add_button.frame = [[self.view.frame.size.width - 44, 0], [44,44]]
    self.view.addSubview @add_button
    
    if Habit.all.count == 0 and !@get_started_button
      @get_started_button = TooltipView.alloc.initWithText "TAP HERE TO GET STARTED", fromRect: @add_button.frame
      view.addSubview @get_started_button
    end

  end
  def add_title
    @title_label = Labels.navbarLabelWithFrame [[0,0],[320,44]]
    @title_label.text = "GOOD HABITS"
    view.addSubview @title_label
  end
  def showInfo
    presentViewController InfoOverviewScreen.alloc.init, animated: true, completion: ->(){}
  end
  def addItem
    @list.addItem
    if @get_started_button
      UIView.animateWithDuration 0.2, animations: ->{
        @get_started_button.alpha = 0
      }
    end
  end
  def reload
    @list.tableView.reloadData
  end
  def viewWillAppear animated
    super
    refresh()
  end
  def refresh
    @list.refresh()
    @info_count_badge.refresh()
  end
end