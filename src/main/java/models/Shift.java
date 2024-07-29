package models;

public class Shift {

    private final boolean isOff;
    private final boolean isAbsence;
    private final boolean isFridayAfter8PM;
    private final boolean containsStandbyTime;
    private final boolean triggersFollowingDayOff;
    private final boolean isCompensatedHolidayOrWeekend;

    public Shift(boolean isOff, boolean isAbsence, boolean isFridayAfter8PM,
                 boolean containsStandbyTime, boolean triggersFollowingDayOff, boolean isHolidayOrWeekend) {
        if (isOff && (isAbsence
                || isFridayAfter8PM
                || containsStandbyTime
                || triggersFollowingDayOff
                || isHolidayOrWeekend)) {
            throw new IllegalArgumentException("A shift off represents leisure time and may not fulfil any other characteristics");
        }

        if (isAbsence && (isFridayAfter8PM
                || containsStandbyTime
                || triggersFollowingDayOff
                || isHolidayOrWeekend)) {
            throw new IllegalArgumentException("A shift in absence cannot fulfil any other characteristics");
        }

        this.isOff = isOff;
        this.isAbsence = isAbsence;
        this.isFridayAfter8PM = isFridayAfter8PM;
        this.containsStandbyTime = containsStandbyTime;
        this.triggersFollowingDayOff = triggersFollowingDayOff;
        this.isCompensatedHolidayOrWeekend = isHolidayOrWeekend;
    }

    public boolean isOff() {
        return isOff;
    }

    public boolean isAbsence() {
        return isAbsence;
    }

    public boolean isFridayAfter8PM() {
        return isFridayAfter8PM;
    }

    public boolean isContainsStandbyTime() {
        return containsStandbyTime;
    }

    public boolean isTriggersFollowingDayOff() {
        return triggersFollowingDayOff;
    }

    public boolean isCompensatedHolidayOrWeekend() {
        return isCompensatedHolidayOrWeekend;
    }
}
