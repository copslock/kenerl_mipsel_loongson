Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 10:54:50 +0100 (BST)
Received: from smtp.netsity.com ([IPv6:::ffff:61.246.47.138]:36357 "EHLO
	mail.netsity.com") by linux-mips.org with ESMTP id <S8225507AbVHEJyc>;
	Fri, 5 Aug 2005 10:54:32 +0100
Received: from INPREET ([192.168.103.60]) by mail.netsity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id QJTZH2K2; Fri, 5 Aug 2005 15:28:10 +0530
Message-ID: <01a901c599a4$2f855280$3c67a8c0@netsity.com>
From:	"inpreet" <singh.inpreet@netsity.com>
To:	<linux-mips@linux-mips.org>
Subject: Ramdisk issue please help!!!
Date:	Fri, 5 Aug 2005 15:28:10 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01A6_01C599D2.493418A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Return-Path: <singh.inpreet@netsity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: singh.inpreet@netsity.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_01A6_01C599D2.493418A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to build ramdisk image and launch bootsplash image at boot =
time.=20
Steps I followed:
1. get splash image initrd.splash using splash binary.
2. dd if=3D/dev/zero of=3Dinitrd bs=3D1k count=3D4096
        /sbin/mke2fs -F -m0 -b 1024 initrd
        /sbin/tune2fs -c 0 -i 0 initrd
        mount -t ext2 initrd /mnt/user -o loop=20
3. cd /mnt/user
4. mkdir /boot
5. cp /home/user/initrd.splash /boot
6. umount /mnt/user
7. gzip -v9 initrd
8. results in initrd.gz

Now while compiling kernel image I am embedding initrd.gz into it. Here =
is what I am doing
***************System.map**************
=20
802f9000 D _binary__tmp_initrd_gz_start
802f9000 D __rd_start
803d250c D _binary__tmp_initrd_gz_end
803d3000 A __bss_start
803d3000 A _edata
=20
***********RAM DISK MAKE FILE************
=20
O_FORMAT =3D $(shell $(OBJDUMP) -i | head -2 | grep elf32)
img =3D $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
ramdisk.o: $(subst ",,$(img)) ld.script
        echo "O_FORMAT:  " $(O_FORMAT)
        $(LD) -T ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)

include $(TOPDIR)/Rules.make
=20
***********RAM DISK ld.script file********************
=20
OUTPUT_ARCH(mips)
SECTIONS
{
  .initrd :
  {
       *(.data)
  }
}
**********************************************
I am using YAMON bootloader. While booting I am passing following =
parameters to kernel:
start        (R/W)  go be000000 initrd=3D/boot/initrd.splash rw =
init=3D/linuxrc console=3Dtty1 video=3Dau1100fb:panel:640x480_crt =
splash=3Dsilent

************************dmesg result***************
CPU revision is: 02030204
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 =
bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.21 (@node) (gcc version 3.2) #1 Fri Aug 5 13:08:44 IST =
2005
DSP Design Aurora AA1100
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Initial ramdisk at: 0x802f9000 (892928 bytes)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: initrd=3D/boot/initrd.splash rw init=3D/linuxrc =
console=3Dtty1 video=3Dau1100fb:panel:640x480_crt splash=3Dsilent =
usb_ohci=3Dbase:0x10100000,len:0x100000,irq:26
fb: calling au1100fb setup<6>au110fb: setup called
au1100fb: Panel 0 640x480_CRT
bootsplash: silent mode.
calculating r4koff... 003c6ef5(3960565)
CPU frequency 396.06 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 59824k/65536k available (1788k kernel code, 5712k reserved, 988k =
data, 96k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
bootsplash 3.0.9-2003/09/08: looking for picture... no good signature =
found.
Console: switching to colour frame buffer device 80x30
fb0: Au1100 LCD frame buffer device
pty: 256 Unix98 ptys configured
aa1100_ad: registered
aa1100_ad: baudrate =3D 1523307 Hz
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq =3D 0) is a 16550
ttyS01 at 0xb1200000 (irq =3D 1) is a 16550
ttyS02 at 0xb1400000 (irq =3D 3) is a 16550
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb0500000, irq 28
eth0: LSI 80227 10/100 BaseT PHY at phy address 0
eth0: Using LSI 80227 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ide0: ports already in use, skipping probe
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
au1100 flash: probing 32-bit flash bus
 Amd/Fujitsu Extended Query Table v1.3 at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Creating 3 MTD partitions on "AU1100 flash":
0x00000000-0x01c00000 : "Operating System"
0x01c00000-0x01fc0000 : "YAMON"
0x01fc0000-0x02000000 : "Yamon env variables"
usb.c: registered new driver hub
host/usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
host/usb-ohci.c: usb-builtin, non-PCI OHCI
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 872k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 96k freed
Algorithmics/MIPS FPU Emulator v1.5
Linux Kernel Card Services 3.1.22
  options:  [pci]

Au1x00 PCMCIA (CS release 3.1.22)
hub.c: new USB device builtin-2, assigned address 2
input0: USB HID v1.10 Keyboard [SEJIN SEJIN USB Mini Keyboard] on =
usb1:2.0
Trying to free nonexistent resource <c0010000-c001000f>
hda: SanDisk SDCFB-32, CFA DISK drive
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
ide0 at 0xc0010000-0xc0010007,0xc001000e on irq 39
hda: attached ide-disk driver.
hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
hda: 62720 sectors (32 MB) w/1KiB Cache, CHS=3D490/4/32
Partition check:
 hda: hda1
ide_cs: hda: Vcc =3D 3.3, Vpp =3D 0.0
 hda: hda1
 hda: hda1
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
eth0: link up
eth0: going to full duplex
*********************************************************
while booting it still complaining that haven't found the initrd.splash =
file. which actually loads splash screen.
=20
=20
Please help where is the problem, Which step I am doing wrong?

------=_NextPart_000_01A6_01C599D2.493418A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3700.6699" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DVerdana size=3D2>Hello,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>I am trying to build ramdisk image =
and launch=20
bootsplash image at boot time. </FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>Steps I followed:</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>1. get splash image initrd.splash =
using splash=20
binary.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>2. dd if=3D/dev/zero of=3Dinitrd =
bs=3D1k=20
count=3D4096<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/mke2fs =
-F -m0 -b=20
1024 initrd</FONT></DIV>
<DIV><FONT face=3DVerdana =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/sbin/tune2fs -c 0 -i 0 initrd</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
mount -t=20
ext2&nbsp;initrd&nbsp;/mnt/user -o loop </FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>3. cd /mnt/user</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>4. mkdir /boot</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>5. cp /home/user/initrd.splash =
/boot</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>6. umount /mnt/user</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>7. gzip -v9 initrd</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>8. results in initrd.gz</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Now&nbsp;while compiling kernel image =
I am=20
embedding initrd.gz into it. Here is what I am doing</FONT></DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>***************System.map**************</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>802f9000 D=20
_binary__tmp_initrd_gz_start<BR>802f9000 D __rd_start<BR>803d250c D=20
_binary__tmp_initrd_gz_end<BR>803d3000 A __bss_start<BR>803d3000 A=20
_edata</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>***********RAM DISK MAKE=20
FILE************</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>O_FORMAT =3D $(shell $(OBJDUMP) -i | =
head -2 | grep=20
elf32)<BR>img =3D $(CONFIG_EMBEDDED_RAMDISK_IMAGE)<BR>ramdisk.o: $(subst =

",,$(img)) ld.script<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo=20
"O_FORMAT:&nbsp; " =
$(O_FORMAT)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
$(LD) -T ld.script -b binary --oformat $(O_FORMAT) -o $@ =
$(img)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>include =
$(TOPDIR)/Rules.make</FONT></DIV>
<DIV></FONT><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>***********RAM DISK ld.script=20
file********************</FONT></DIV></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana =
size=3D2>OUTPUT_ARCH(mips)<BR>SECTIONS<BR>{<BR>&nbsp;=20
.initrd :<BR>&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*(.data)<BR>&nbsp;=20
}<BR>}</FONT></DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>**********************************************</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>I am using YAMON =
bootloader.&nbsp;While booting I=20
am passing following parameters to kernel:</FONT></DIV>
<DIV><FONT face=3DVerdana =
size=3D2>start&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(R/W)&nbsp; go be000000 initrd=3D/boot/initrd.splash rw init=3D/linuxrc =
console=3Dtty1=20
video=3Dau1100fb:panel:640x480_crt splash=3Dsilent<BR></DIV></FONT>
<DIV><FONT face=3DVerdana size=3D2>************************dmesg=20
result***************</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>CPU revision is: 02030204<BR>Primary =
instruction=20
cache 16kB, physically tagged, 4-way, linesize 32 bytes.<BR>Primary data =
cache=20
16kB 4-way, linesize 32 bytes.<BR>Linux version 2.4.21 (@node) (gcc =
version 3.2)=20
#1 Fri Aug 5 13:08:44 IST 2005<BR>DSP Design Aurora AA1100<BR>Determined =

physical RAM map:<BR>&nbsp;memory: 04000000 @ 00000000 =
(usable)<BR>Initial=20
ramdisk at: 0x802f9000 (892928 bytes)<BR>On node 0 totalpages: =
16384<BR>zone(0):=20
16384 pages.<BR>zone(1): 0 pages.<BR>zone(2): 0 pages.<BR>Kernel command =
line:=20
initrd=3D/boot/initrd.splash rw init=3D/linuxrc console=3Dtty1=20
video=3Dau1100fb:panel:640x480_crt splash=3Dsilent=20
usb_ohci=3Dbase:0x10100000,len:0x100000,irq:26<BR>fb: calling au1100fb=20
setup&lt;6&gt;au110fb: setup called<BR>au1100fb: Panel 0=20
640x480_CRT<BR>bootsplash: silent mode.<BR>calculating r4koff...=20
003c6ef5(3960565)<BR>CPU frequency 396.06 MHz<BR>Console: colour dummy =
device=20
80x25<BR>Calibrating delay loop... 395.67 BogoMIPS<BR>Memory: =
59824k/65536k=20
available (1788k kernel code, 5712k reserved, 988k data, 96k init, 0k=20
highmem)<BR>Dentry cache hash table entries: 8192 (order: 4, 65536=20
bytes)<BR>Inode cache hash table entries: 4096 (order: 3, 32768 =
bytes)<BR>Mount=20
cache hash table entries: 512 (order: 0, 4096 bytes)<BR>Buffer-cache =
hash table=20
entries: 4096 (order: 2, 16384 bytes)<BR>Page-cache hash table entries: =
16384=20
(order: 4, 65536 bytes)<BR>Checking for 'wait' instruction...&nbsp;=20
available.<BR>POSIX conformance testing by UNIFIX<BR>Linux NET4.0 for =
Linux=20
2.4<BR>Based upon Swansea University Computer Society =
NET3.039<BR>Initializing=20
RT netlink socket<BR>Starting kswapd<BR>Journalled Block Device driver=20
loaded<BR>bootsplash 3.0.9-2003/09/08: looking for picture... no good =
signature=20
found.<BR>Console: switching to colour frame buffer device 80x30<BR>fb0: =
Au1100=20
LCD frame buffer device<BR>pty: 256 Unix98 ptys configured<BR>aa1100_ad: =

registered<BR>aa1100_ad: baudrate =3D 1523307 Hz<BR>Serial driver =
version 1.01=20
(2001-02-08) with no serial options enabled<BR>ttyS00 at 0xb1100000 (irq =
=3D 0) is=20
a 16550<BR>ttyS01 at 0xb1200000 (irq =3D 1) is a 16550<BR>ttyS02 at =
0xb1400000=20
(irq =3D 3) is a 16550<BR>RAMDISK driver initialized: 16 RAM disks of =
4096K size=20
1024 blocksize<BR>loop: loaded (max 8 devices)<BR>au1000eth.c:1.4 <A=20
href=3D"mailto:ppopov@mvista.com">ppopov@mvista.com</A><BR>eth0: Au1x =
Ethernet=20
found at 0xb0500000, irq 28<BR>eth0: LSI 80227 10/100 BaseT PHY at phy =
address=20
0<BR>eth0: Using LSI 80227 10/100 BaseT PHY as default<BR>Uniform =
Multi-Platform=20
E-IDE driver Revision: 7.00beta4-2.4<BR>ide: Assuming 50MHz system bus =
speed for=20
PIO modes; override with idebus=3Dxx<BR>ide0: ports already in use, =
skipping=20
probe<BR>ide1: ports already in use, skipping probe<BR>ide2: ports =
already in=20
use, skipping probe<BR>ide3: ports already in use, skipping =
probe<BR>ide4: ports=20
already in use, skipping probe<BR>ide5: ports already in use, skipping=20
probe<BR>au1100 flash: probing 32-bit flash bus<BR>&nbsp;Amd/Fujitsu =
Extended=20
Query Table v1.3 at 0x0040<BR>number of CFI chips: 1<BR>cfi_cmdset_0002: =

Disabling fast programming due to code brokenness.<BR>Creating 3 MTD =
partitions=20
on "AU1100 flash":<BR>0x00000000-0x01c00000 : "Operating=20
System"<BR>0x01c00000-0x01fc0000 : "YAMON"<BR>0x01fc0000-0x02000000 : =
"Yamon env=20
variables"<BR>usb.c: registered new driver hub<BR>host/usb-ohci.c: USB =
OHCI at=20
membase 0xb0100000, IRQ 26<BR>host/usb-ohci.c: usb-builtin, non-PCI=20
OHCI<BR>usb.c: new USB bus registered, assigned bus number 1<BR>hub.c: =
USB hub=20
found<BR>hub.c: 2 ports detected<BR>usb.c: registered new driver=20
hid<BR>hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik &lt;<A=20
href=3D"mailto:vojtech@suse.cz">vojtech@suse.cz</A>&gt;<BR>hid-core.c: =
USB HID=20
support drivers<BR>mice: PS/2 mouse device common for all mice<BR>NET4: =
Linux=20
TCP/IP 1.0 for NET4.0<BR>IP Protocols: ICMP, UDP, TCP, IGMP<BR>IP: =
routing cache=20
hash table of 512 buckets, 4Kbytes<BR>TCP: Hash tables configured =
(established=20
4096 bind 8192)<BR>NET4: Unix domain sockets 1.0/SMP for Linux=20
NET4.0.<BR>RAMDISK: Compressed image found at block 0<BR>Freeing initrd =
memory:=20
872k freed<BR>VFS: Mounted root (ext2 filesystem).<BR>Freeing unused =
kernel=20
memory: 96k freed<BR>Algorithmics/MIPS FPU Emulator v1.5<BR>Linux Kernel =
Card=20
Services 3.1.22<BR>&nbsp; options:&nbsp; [pci]</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Au1x00 PCMCIA (CS release =
3.1.22)<BR>hub.c: new=20
USB device builtin-2, assigned address 2<BR>input0: USB HID v1.10 =
Keyboard=20
[SEJIN SEJIN USB Mini Keyboard] on usb1:2.0<BR>Trying to free =
nonexistent=20
resource &lt;c0010000-c001000f&gt;<BR>hda: SanDisk SDCFB-32, CFA DISK=20
drive<BR>ide1: ports already in use, skipping probe<BR>ide2: ports =
already in=20
use, skipping probe<BR>ide3: ports already in use, skipping =
probe<BR>ide4: ports=20
already in use, skipping probe<BR>ide5: ports already in use, skipping=20
probe<BR>ide0 at 0xc0010000-0xc0010007,0xc001000e on irq 39<BR>hda: =
attached=20
ide-disk driver.<BR>hda: task_no_data_intr: status=3D0x51 { DriveReady=20
SeekComplete Error }<BR>hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError=20
}<BR>hda: 62720 sectors (32 MB) w/1KiB Cache, =
CHS=3D490/4/32<BR>Partition=20
check:<BR>&nbsp;hda: hda1<BR>ide_cs: hda: Vcc =3D 3.3, Vpp =3D =
0.0<BR>&nbsp;hda:=20
hda1<BR>&nbsp;hda: hda1<BR>EXT2-fs warning: mounting unchecked fs, =
running=20
e2fsck is recommended<BR>eth0: link up<BR>eth0: going to full=20
duplex</FONT></DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>*********************************************************</FONT>=
</DIV>
<DIV><FONT face=3DVerdana size=3D2>while booting it still complaining =
that haven't=20
found the initrd.splash file. which actually loads splash =
screen.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Please help where is the problem, =
Which step I am=20
doing wrong?</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_01A6_01C599D2.493418A0--
