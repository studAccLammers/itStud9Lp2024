import pandas as pd
import os

input_p_file = 'aerzte.xlsx'
input_t_file = 'timeRange.xlsx'
output_file = 'inputData.xlsx'

dataP = pd.read_excel(input_p_file)
dataT = pd.read_excel(input_t_file)

w_columns = [col for col in dataT.columns if col.startswith('w')]

columns_sheet1 = ['P', 'PAP', 'PSP', 'PCP', 'PHP']
output_data_sheet1 = pd.DataFrame(columns=columns_sheet1)
output_data_sheet1['P'] = dataP['Ärzte']

for _, row in dataP.iterrows():
    arzt = row['Ärzte']
    qualifikation = row['Qualifikation']
    output_data_sheet1.loc[output_data_sheet1['P'] == arzt, qualifikation] = 1

output_data_sheet1.fillna("", inplace=True)

if os.path.exists(output_file):
    os.remove(output_file)

with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
    output_data_sheet1.to_excel(writer, index=False, sheet_name='Sheet1')
    dataP[['Ärzte','Contract']].to_excel(writer, index=False, sheet_name='Sheet2')
    dataT[['t','Mon','Tue','Wed','Thu','Fri','Sat','Sun']].to_excel(writer, index=False, sheet_name='Sheet3')
    dataT[['t'] + w_columns].to_excel(writer, index=False, sheet_name='Sheet4')