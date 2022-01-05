import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SimpleFaceView extends WatchUi.WatchFace {

    var myBitmap;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        setClock();
        setHeartRate();
        setBatteryLife();
        setDate();
        setCalories();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    private function setClock() {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);
    }

    private function setHeartRate() {
        var hr = Activity.Info.currentHeartRate;
        if (hr == null) {
            hr = "--";
        }
        var hrText = View.findDrawableById("HeartRate");
        hrText.setText(hr);
    }

    private function setBatteryLife() {
        var batLife = System.getSystemStats().battery;
        batLife = Lang.format("$1$%", [batLife.format( "%2d" )]);
        var batText = View.findDrawableById("BatteryLife");
        batText.setText(batLife);
    }

    private function setDate() {
        var yeet = Time.now();
        var date = Time.Gregorian.info(yeet, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$ $2$ $3$", [date.day_of_week, date.month, date.day]);
        var dateText = View.findDrawableById("Date");
        dateText.setText(dateString);

    }

    private function setCalories() {
        var cals = Activity.Info.calories;
        if (cals == null) {
            cals = "--";
        }
        var calText = View.findDrawableById("Calories");
        calText.setText(cals);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
