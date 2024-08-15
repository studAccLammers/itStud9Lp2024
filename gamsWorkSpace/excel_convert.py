import pandas as pd
import os

input_file = 'aerzte.xlsx'
output_file = 'inputData.xlsx'

data = pd.read_excel(input_file)

columns_sheet1 = ['P', 'PAP', 'PSP', 'PCP', 'PHP']
output_data_sheet1 = pd.DataFrame(columns=columns_sheet1)

output_data_sheet1['P'] = data['Ärzte']

for _, row in data.iterrows():
    Arzt = row['Ärzte']
    Qualifikation = row['Qualifikation']
    output_data_sheet1.loc[output_data_sheet1['P'] == Arzt, Qualifikation] = 1

output_data_sheet1.fillna("", inplace=True)

if os.path.exists(output_file):
    os.remove(output_file)

with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
    output_data_sheet1.to_excel(writer, index=False, sheet_name='Sheet1')
    data[['Ärzte','Contract']].to_excel(writer, index=False, sheet_name='Sheet2')