from PyPDF2 import PdfWriter

merger = PdfWriter()

pdfs = ['lab'+str(i)+'.pdf' for i in range(1,7)]
lab_names = [
    'Measuring kB from resistors',
    'Four-Point-Probe Conductivity Measurement',
    'Circular Diffraction',
    'Lock-In Amplification',
    'Long-time data collecting using LabVIEW',
    'Density Functional Theory (DFT) calculation'
]

for i,pdf in enumerate(pdfs):
    merger.append(pdf, outline_item = 'Lab '+str(i+1)+': '+lab_names[i])

merger.write("lab-reports.pdf")
merger.close()
