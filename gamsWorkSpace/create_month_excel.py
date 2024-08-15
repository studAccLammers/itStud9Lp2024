import pandas as pd
from datetime import datetime, timedelta

def get_days_for_excel(month, year):
    coded_days = []
    days_info = []
    first_day_of_month = datetime(year, month, 1)
    
    for i in range(7, 0, -1):
        day = first_day_of_month - timedelta(days=i)
        coded_days.append(f't{day:%m%d}')
        days_info.append((day, day.strftime('%a')))
    
    current_month_days = (datetime(year, month % 12 + 1, 1) - timedelta(days=1)).day
    for day in range(1, current_month_days + 1):
        cur_date = datetime(year, month, day)
        coded_days.append(f't{cur_date:%m%d}')
        days_info.append((cur_date, cur_date.strftime('%a')))
    
    next_month_start = datetime(year, month % 12 + 1, 1)
    tuesday_count = 0
    days_added_from_next_month = 0

    while True:
        is_tuesday = next_month_start.weekday() == 1
        coded_days.append(f't{next_month_start:%m%d}')
        days_info.append((next_month_start, next_month_start.strftime('%a')))
        days_added_from_next_month += 1
        if is_tuesday:
            tuesday_count += 1
            if (tuesday_count == 1 and days_added_from_next_month > 2) or tuesday_count == 2:
                break
        next_month_start += timedelta(days=1)

    return coded_days, days_info

def create_excel(month, year, thd_list):
    coded_days, days_info = get_days_for_excel(month, year)
    rows = []

    start_week_date = days_info[0][0] - timedelta(days=days_info[0][0].weekday())
    current_week = 0

    for i, (date, weekday) in enumerate(days_info):
        if date >= start_week_date + timedelta(weeks=current_week + 1):
            current_week += 1
        
        row = [coded_days[i]]
        
        tvm = 1 if date.month == (month - 1 or (month == 1 and 12)) else None
        tam = 1 if date.month == month else None
        tfm = 1 if date.month == (month + 1 or (month == 12 and 1)) else None
        
        row.extend([tvm, tam, tfm])
        
        for day in ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']:
            row.append(1 if weekday == day else None)
        
        for week in range(8):
            row.append(1 if week == current_week else None if week <= current_week else "")
        
        first = 1 if i == 0 else None
        row.append(first)
        
        thd = 1 if coded_days[i] in thd_list else None
        row.append(thd)

        rows.append(row)
    
    columns = ['t', 'TVM', 'TAM', 'TFM', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'] + [f'w{week}' for week in range(8)] + ['first', 'THD']
    
    df = pd.DataFrame(rows, columns=columns)
    file_name = 'timeRange.xlsx'
    df.to_excel(file_name, index=False)
    print(f'Excel-Datei {file_name} wurde erstellt.')

if __name__ == "__main__":
    month = int(input("Bitte geben Sie den Monat (1-12) ein: "))
    year = int(input("Bitte geben Sie das Jahr ein: "))
    
    thd_input = input("Bitte geben Sie die THD-Werte ein (Komma getrennt): ")
    thd_list = thd_input.split(',')
    thd_list = [value.strip() for value in thd_list]

    create_excel(month, year, thd_list)