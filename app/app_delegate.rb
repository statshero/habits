class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @main = MainViewController.alloc.init
    @window.rootViewController =  @main
    @window.backgroundColor = "#ffffff".to_color

    @window.makeKeyAndVisible
    true
  end
  
  def applicationDidBecomeActive application

    Habit.reschedule_all_notifications
  end

end
