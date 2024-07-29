package models;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

import static org.joda.time.DateTimeConstants.TUESDAY;

public class ScheduleTime {
    private final List<DateTime> hospitalDays;

    public ScheduleTime(int month, int year) {
        if (month > 12) {
            throw new IllegalArgumentException("Month couldn't be index 13");
        }

        if (year < DateTime.now().getYear() || month < DateTime.now().getMonthOfYear()) {
            throw new IllegalArgumentException("Unable to generate schedule for the past");
        }

        hospitalDays = fillScheduleTimeList(month, year);
    }

    /**
     * The days of the one-month planning horizon, plus some days before and after, as explained next, are grouped
     * into numerous subsets. First of all, weekdays and weekend days need to be denoted so that rules regarding
     * limits on worked weekends, among others, can be enforced. The last week of the previous month is added to
     * the model, as well as the days of the following month until a Tuesday is reached (but at least two days).
     **/
    private List<DateTime> fillScheduleTimeList(int month, int year) {
        final List<DateTime> hospitalDays;
        DateTime firstOfMonth = new DateTime(year, month, 1, 0, 0, 1);

        hospitalDays = new ArrayList<>();

        //Add seven days of last month and add every day until first of next month
        DateTime currentlyAddedDay = firstOfMonth.minusDays(7);
        while (currentlyAddedDay.getMonthOfYear() != month + 1) {
            hospitalDays.add(currentlyAddedDay);
            currentlyAddedDay = currentlyAddedDay.plusDays(1);
        }

        //Add first of next month
        hospitalDays.add(currentlyAddedDay);

        //Add days until next tuesday (last tuesday also added)
        while (currentlyAddedDay.getDayOfWeek() != TUESDAY || currentlyAddedDay.getDayOfMonth() == 1) {
            currentlyAddedDay = currentlyAddedDay.plusDays(1);
            hospitalDays.add(currentlyAddedDay);
        }
        return hospitalDays;
    }

    public List<DateTime> getHospitalDays() {
        return hospitalDays;
    }
}
