Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2003 21:51:25 +0100 (BST)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:37361 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225517AbTJGUux>;
	Tue, 7 Oct 2003 21:50:53 +0100
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.8) with ESMTP id h97KojiL018652
	for <linux-mips@linux-mips.org>; Tue, 7 Oct 2003 13:50:45 -0700 (PDT)
Received: from glghspc ([192.168.114.2])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id h97KoiIo027795
	for <linux-mips@linux-mips.org>; Tue, 7 Oct 2003 13:50:44 -0700 (PDT)
Reply-To: <gil.lauer@ghs.com>
From: "Gil Lauer" <gil.lauer@ghs.com>
To: <linux-mips@linux-mips.org>
Subject: Can't boot RedHat 7.3 Linux on Mips Malta
Date: Tue, 7 Oct 2003 13:51:02 -0700
Organization: Green Hills Software
Message-ID: <002501c38d14$b8611ba0$0272a8c0@glghspc>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0026_01C38CDA.0C0243A0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Return-Path: <gil.lauer@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gil.lauer@ghs.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C38CDA.0C0243A0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0027_01C38CDA.0C0243A0"


------=_NextPart_001_0027_01C38CDA.0C0243A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am new to Linux and a new subscriber to linux-mips.

 

I downloaded the RedHat Linux distribution that MIPS Technology posts at
ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.3/01.00/ and I
cannot get through the installation process.  I can load and run the
pre-built installation kernel, but when it tries to load the prebuilt
Linux image via NFS I get the following error:

 

Welcome to the MIPS installation of RedHat RPMS.

 

Install method (CD-ROM, NFS) [CD-ROM] NFS

 

IP-address of target system: [192.168.201.68] 192.168.114.150

SIOCSIFADDR: No such device

eth0: unknown interface: No such device

 

Since I have successfully loaded and run the prebuilt Linux installation
image via Yamon, I know that the network connection is working.  Since
this image is built to run on the Malta board, it is odd that it can't
find the built-in ethernet connection.

 

I have attached a complete log of the console output.  Any pointers on
where I am going wrong would be welcome.

 

Gil Lauer

 


------=_NextPart_001_0027_01C38CDA.0C0243A0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am new to Linux and a new subscriber to =
linux-mips.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I downloaded the RedHat Linux distribution that MIPS =
Technology
posts at <a
href=3D"ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.3/01.00/">=
ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.3/01.00/</a>
and I cannot get through the installation process.&nbsp; I can load and =
run the
pre-built installation kernel, but when it tries to load the prebuilt =
Linux
image via NFS I get the following error:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Welcome to the MIPS
installation of RedHat RPMS.</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DSV style=3D'font-size:10.0pt;font-family:"Courier New"'>Install =
method
(CD-ROM, NFS) [CD-ROM] NFS</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DSV style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>IP-address of =
target system:
[192.168.201.68] 192.168.114.150</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SIOCSIFADDR: No =
such device</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: unknown =
interface: No
such device</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Since I have successfully loaded and run the prebuilt =
Linux
installation image via Yamon, I know that the network connection is
working.&nbsp; Since this image is built to run on the =
</span></font><font
  size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Malta</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> board, it
is odd that it can&#8217;t find the built-in ethernet =
connection.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have attached a complete log of the console =
output.&nbsp;
Any pointers on where I am going wrong would be =
welcome.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Gil Lauer</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0027_01C38CDA.0C0243A0--

------=_NextPart_000_0026_01C38CDA.0C0243A0
Content-Type: text/plain;
	name="malta_linux_errlog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malta_linux_errlog.txt"

YAMON ROM Monitor, Revision 02.00.=0A=
Copyright (c) 1999-2000 MIPS Technologies, Inc. - All Rights Reserved.=0A=
=0A=
For a list of available commands, type 'help'.=0A=
=0A=
Compilation time =3D            Sep 11 2000  13:07:34=0A=
Board type/revision =3D         0x02 (Malta) / 0x00=0A=
Core board type/revision =3D    0x01 (CoreLV) / 0x01=0A=
FPGA revision =3D               0x0001=0A=
MAC address =3D                 00.d0.a0.00.02.6b=0A=
Board S/N =3D                   0000000371=0A=
PCI bus frequency =3D           33.33 MHz=0A=
Processor Company ID =3D        0x01 (MIPS Technologies, Inc.)=0A=
Processor ID/revision =3D       0x80 (MIPS 4Kc) / 0x01=0A=
Endianness =3D                  Big=0A=
CPU/Bus frequency =3D           80 MHz / 40 MHz=0A=
Flash memory size =3D           4 MByte=0A=
SDRAM size =3D                  64 MByte=0A=
First free SDRAM address =3D    0x80094530=0A=
=0A=
YAMON> load =
tftp://192.168.114.105/vmlinux-2.4.18.malta.install.eb-01.01.srec=0A=
About to load =
tftp://192.168.114.105/vmlinux-2.4.18.malta.install.eb-01.01.srec=0A=
Press Ctrl-C to break=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
........................................=0A=
..............................=0A=
Start =3D 0x8029e040, range =3D (0x80100000,0x8077bfff), format =3D SREC=0A=
YAMON> go=0A=
=0A=
LINUX started...=0A=
CPU revision is: 00018001=0A=
Primary instruction cache 16kb, linesize 16 bytes (4 ways)=0A=
Primary data cache 16kb, linesize 16 bytes (4 ways)=0A=
Linux version 2.4.18-MIPS-01.01 (carstenl@coplin20.mips.com) (gcc =
version 2.96-2Determined physical RAM map:=0A=
 memory: 00001000 @ 00000000 (reserved)=0A=
 memory: 000ef000 @ 00001000 (ROM data)=0A=
 memory: 00010000 @ 000f0000 (reserved)=0A=
 memory: 006ac000 @ 00100000 (reserved)=0A=
 memory: 03854000 @ 007ac000 (usable)=0A=
Initial ramdisk at: 0x802dc000 (4846464 bytes)=0A=
On node 0 totalpages: 16384=0A=
zone(0): 16384 pages.=0A=
zone(1): 0 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line:  console=3DttyS0,38400=0A=
calculating r4koff... 00061a8f(400015)=0A=
CPU frequency 80.00 MHz=0A=
Console: colour dummy device 80x25=0A=
Calibrating delay loop... 53.24 BogoMIPS=0A=
Memory: 56640k/57680k available (1647k kernel code, 1040k reserved, =
4860k data,)Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)=0A=
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
Checking for 'wait' instruction...  available.=0A=
POSIX conformance testing by UNIFIX=0A=
PCI: Probing PCI hardware on host bus 0.=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
Starting kswapd=0A=
initialize_kbd: Keyboard reset failed, no ACK=0A=
Detected PS/2 Mouse Port.=0A=
pty: 256 Unix98 ptys configured=0A=
keyboard: Timeout - AT keyboard not present?(ed)=0A=
keyboard: Timeout - AT keyboard not present?(f4)=0A=
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI edttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
rtc: SRM (post-2000) epoch (2000) detected=0A=
Real Time Clock Driver v1.10e=0A=
block: 128 slots per queue, batch=3D32=0A=
RAMDISK driver initialized: 16 RAM disks of 18432K size 1024 blocksize=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
PIIX4: IDE controller on PCI bus 00 dev 51=0A=
PIIX4: chipset revision 1=0A=
PIIX4: not 100% native mode: will probe irqs later=0A=
    ide0: BM-DMA at 0x1240-0x1247, BIOS settings: hda:pio, hdb:pio=0A=
    ide1: BM-DMA at 0x1248-0x124f, BIOS settings: hdc:pio, hdd:pio=0A=
hda: Maxtor 6E040L0, ATA DISK drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=3D79656/16/63, =
UDMA(33)=0A=
Partition check:=0A=
 hda: unknown partition table=0A=
loop: loaded (max 8 devices)=0A=
pcnet32_probe_pci: found device 0x001022.0x002000=0A=
    ioaddr=3D0x001200  resource_flags=3D0x000101=0A=
Linux video capture interface: v1.00=0A=
es1371: version v0.30 time 11:57:12 Nov 21 2002=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP=0A=
IP: routing cache hash table of 512 buckets, 4Kbytes=0A=
TCP: Hash tables configured (established 4096 bind 4096)=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
RAMDISK: Compressed image found at block 0=0A=
Freeing initrd memory: 4732k freed=0A=
EXT2-fs warning: checktime reached, running e2fsck is recommended=0A=
VFS: Mounted root (ext2 filesystem).=0A=
Freeing prom memory: 956kb freed=0A=
Freeing unused kernel memory: 120k freed=0A=
Algorithmics/MIPS FPU Emulator v1.5=0A=
Setting network parameters:  [  OK  ]=0A=
Bringing up interface lo:  [  OK  ]=0A=
Starting portmapper: [  OK  ]=0A=
=0A=
Welcome to the MIPS installation of RedHat RPMS.=0A=
=0A=
Install method (CD-ROM, NFS) [CD-ROM] NFS=0A=
=0A=
IP-address of target system: [192.168.201.68] 192.168.114.150=0A=
SIOCSIFADDR: No such device=0A=
eth0: unknown interface: No such device=0A=
=0A=
IP-address of target system is wrong, please try again=0A=
=0A=
IP-address of target system: [192.168.201.68]=0A=
SIOCSIFADDR: No such device=0A=
eth0: unknown interface: No such device=0A=
=0A=
IP-address of target system is wrong, please try again=0A=
=0A=
IP-address of target system: [192.168.201.68]=0A=

------=_NextPart_000_0026_01C38CDA.0C0243A0--
