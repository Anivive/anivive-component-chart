cp -r /home/jhager/containers/nxf-gcc/.github .
echo "# nxf-bowtie2-samtools" > README.md
echo "Generated with" >> README.md
echo "\`eb --containerize --container-type=docker --experimental --container-config=ubuntu:20.04 Bowtie2-2.4.1-GCC-9.3.0.eb SAMtools-1.10-GCC-9.3.0.eb --container-image-name=Bowtie2-SAMtools --containerpath=\"$PWD\"\`" >> README.md
git init
git add .
git commit -m "feat: add nxf-bowtie2-samtools container"
git branch -M develop
git remote add origin git@github.com:Anivive/nxf-bowtie2-samtools.git
git push -u origin develop