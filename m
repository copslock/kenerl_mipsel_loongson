Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 22:49:55 +0000 (GMT)
Received: from xes-inc.com ([IPv6:::ffff:24.196.136.110]:51330 "EHLO
	xes-inc.com") by linux-mips.org with ESMTP id <S8225308AbULIWts>;
	Thu, 9 Dec 2004 22:49:48 +0000
Received: from matts ([10.52.0.13])
	by xes-inc.com (8.11.6/8.11.6) with SMTP id iB9MnjN11321;
	Thu, 9 Dec 2004 16:49:45 -0600
Message-ID: <062301c4de41$5bf43cb0$0d00340a@matts>
From: "Matthew Starzewski" <mstarzewski@xes-inc.com>
To: <linux-mips@linux-mips.org>
Cc: <Steve.Finney@SpirentCom.COM>
Subject: Using more than 256 MB of memory on SB1250 in 32-bit mode, revisited
Date: Thu, 9 Dec 2004 16:49:35 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0620_01C4DE0F.10321590"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <mstarzewski@xes-inc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mstarzewski@xes-inc.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0620_01C4DE0F.10321590
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've tried to enable HIGHMEM to access all 512MB of
SDRAM on a BCM1125 based board as per this previous
thread:

Using more than 256 MB of memory on SB1250 in 32-bit mode :
http://www.spinics.net/lists/mips/msg14396.html
BCM1125 Board: XPedite3000 PrPMC
http://www.xes-inc.com/Products/XPedite/XPedite3000/XPedite3000.html

In MIPS32 mode, the memory map comes out to the following:

Physical Memory Map:
0x00000000 - 0x0FFFFFFF   256MB
0x80000000 - 0x8FFFFFFF   256MB
Virtual Memory Map:
0x80000000 - 0x8FFFFFFF   256MB
<<<< INACCESSIBLE >>>> 256MB

My goal in enabling HIGHMEM was to get at the upper 256MB
much as described here.  Access to the upper 256MB through
HIGHMEM may incur a performance hit, but it's certainly better
going without.

http://home.earthlink.net/~jknapka/linux-mm/vminit.html#PAGING_INIT

However, what I get is a stall as per the log pasted below.  Enabling
CONFIG_64BIT_PHYS_ADDR does not make a difference.  Results
were cross-verified between CFE and another bootloader.

When I hand the physical memory described above off to =
add_memory_region,
I noticed a few odd things. One thing that looks suspicious is that the =
variable
void *high_memory ends up being set to 0xa0000000, or right at KSEG1,
in mm/init.c.

Also, num_physpages became huge, 0x90000, because the init code in
kernel/setup.c and mm/init.c want a page for every memory location, even
highmem.  Is this appropriate when the memory is not directly accessible
via __va and virt_to_phys? =20

This may be an ancillary effect of what's mentioned above, but when =
num_physpages
grows in size, nr_free_pages doesn't track with it, so in void =
vfs_caches_init(unsigned long
mempages) and the like, you get a horrible underflow condition:

/* code */
        printk("MJS - nr_free_pages():0x%X\n", nr_free_pages());
        printk("MJS - OLD mempages:0x%X\n", mempages);
        reserve =3D (mempages - nr_free_pages()) * 3/2;
        mempages -=3D reserve;
        printk("MJS - NEW reserve:0x%X mempages:0x%X\n",
               reserve, mempages);

/* printout */
MJS - nr_free_pages():0x1E9A0
MJS - OLD mempages:0x90000
MJS - NEW reserve:0xAA190 mempages:0xFFFE5E70


Let me know what you think of this issue.  In anticipation of the
"Why not use MIPS64 build?" question, we'd prefer to and will, but the=20
MIPS64 build has underperformed or had bugs (SATA seek time,
networking signals, etc) that MIPS32 doesn't.  For these issues
or any case where the MIPS64 build isn't there yet, it makes
sense to have the MIPS32 path open.

Regards,
Matt


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Kernel Boot Log =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

CFE version 1.0.37 for BCM91125E (64bit,SP,BE)
Build Date: Mon Jun 28 18:33:29 CDT 2004 (mstarzewski@lsys1)
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.

Initializing Arena.
Initializing Devices.
BCM91125E board revision 1
Config switch: 0
CPU: 1125H A2
L2 Cache: 256KB
SysCfg: 00800000004A0600 [PLL_DIV: 12, IOB0_DIV: CPUCLK/4, IOB1_DIV: =
CPUCLK/3]
CPU type 0x40103: 600MHz
Total memory: 0x20000000 bytes (512MB)

Total memory used by CFE:  0x8FE8AFC0 - 0x90000000 (1527872)
Initialized Data:          0x8FE8AFC0 - 0x8FE94D40 (40320)
BSS Area:                  0x8FE94D40 - 0x8FE95430 (1776)
Local Heap:                0x8FE95430 - 0x8FF95430 (1048576)
Stack Area:                0x8FF95430 - 0x8FF97430 (8192)
Text (code) segment:       0x8FF97440 - 0x8FFFFFB8 (428920)
Boot area (physical):      0x0FE49000 - 0x0FE89000
Relocation Factor:         I:F0397440 - D:0DF8AFC0

CFE> ifconfig eth0 -addr=3D10.52.33.67 -mask=3D255.255.0.0;boot -elf =
10.52.0.4:/home/mstarzewski/li
nux/kernels/mips26_works_cfe/vmlinux
eth0: Link speed: 100BaseT FDX
Device eth0:  hwaddr 40-00-10-06-40-00, ipaddr 10.52.33.67, mask =
255.255.0.0
        gateway not set, nameserver not set
Loader:elf Filesys:tftp Dev:eth0 =
File:10.52.0.4:/home/mstarzewski/linux/kernels/mips26_works_cf
e/vmlinux Options:(null)
Loading: 0xffffffff80100000/2558312 0xffffffff80370968/146032 Entry at =
0xffffffff8032f018
Variable Name        Value
-------------------- --------------------------------------------------
BOOT_CONSOLE         uart0
CPU_TYPE             1125H
CPU_REVISION         A2
CPU_NUM_CORES        1
CPU_SPEED            600
CFE_VERSION          1.0.37
CFE_BOARDNAME        BCM91125E
CFE_MEMORYSIZE       512
NET_DEVICE           eth0
NET_IPADDR           10.52.33.67
NET_NETMASK          255.255.0.0
NET_GATEWAY          0.0.0.0
NET_NAMESERVER       0.0.0.0
BOOT_DEVICE          eth0
BOOT_FILE            =
10.52.0.4:/home/mstarzewski/linux/kernels/mips26_works_cfe/vmlinux
DELETING BOOT_CONSOLE
DELETING CPU_REVISION
DELETING CPU_SPEED
DELETING CFE_BOARDNAME
DELETING NET_DEVICE
DELETING NET_NETMASK
DELETING NET_NAMESERVER
DELETING BOOT_FILE
Variable Name        Value
-------------------- --------------------------------------------------
Closing network.
Starting program at 0xffffffff8032f018
CFE addr:0x000000000FE8A000 size:0x0000000000000000, type:0
CFE addr:0x0000000010000000 size:0x0000000000000000, type:-2147483648
Broadcom SiByte BCM1125H A2 @ 600 MHz (SB1 rev 3)
Board type: SiByte BCM91250A (SWARM)
Linux version 2.6.6-rc3 (mstarzewski@lsys1) (gcc version 3.2.3 with =
SiByte modifications) #17 S
MP Thu Dec 9 11:08:23 CST 2004
CPU revision is: 00040103
FPU revision is: 000f0103
This kernel optimized for board runs with CFE
Determined physical RAM map:
 memory: 0fe89e00 @ 00000000 (usable)
 memory: 0ffffe00 @ 80000000 (usable)
1791MB HIGHMEM available.
On node 0 totalpages: 589823
  DMA zone: 131072 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 458751 pages, LIFO batch:16
Built 1 zonelists
Kernel command line: root=3D/dev/nfs ip=3Dauto rw
PID hash table entries: 4096 (order 12: 32768 bytes)
Memory: 495040k/260644k available (1850k kernel code, 27020k reserved, =
382k data, 264k init, 26
2140k highmem)
Calibrating delay loop... 399.36 BogoMIPS

<< STALL >>

------=_NextPart_000_0620_01C4DE0F.10321590
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2722.900" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I've tried to enable HIGHMEM to access =
all 512MB=20
of</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>SDRAM on a BCM1125 based </FONT><FONT =
face=3DArial=20
size=3D2>board as per this previous</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>thread:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>Using more than=20
256 MB of memory on SB1250 in 32-bit mode :</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.spinics.net/lists/mips/msg14396.html">http://www.spini=
cs.net/lists/mips/msg14396.html</A></FONT></DIV>
<DIV>BCM1125 Board<FONT face=3DArial size=3D2>: XPedite3000 PrPMC</FONT>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.xes-inc.com/Products/XPedite/XPedite3000/XPedite3000.h=
tml">http://www.xes-inc.com/Products/XPedite/XPedite3000/XPedite3000.html=
</A></FONT></DIV></DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>In MIPS32 mode, the memory map comes =
out to the=20
following:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Physical Memory Map:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>0x00000000 - 0x0FFFFFFF&nbsp;&nbsp;=20
256MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>0x80000000 - 0x8FFFFFFF&nbsp;&nbsp;=20
256MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Virtual Memory Map:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>0x80000000 - 0x8FFFFFFF&nbsp;&nbsp;=20
256MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&lt;&lt;&lt;&lt; INACCESSIBLE =
&gt;&gt;&gt;&gt;=20
256MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My goal in enabling HIGHMEM was to get =
at the upper=20
256MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>much as described here.&nbsp; Access to =
the upper=20
256MB through</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>HIGHMEM may incur a performance hit, =
but it's=20
certainly better</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>going without.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://home.earthlink.net/~jknapka/linux-mm/vminit.html#PAGING_IN=
IT">http://home.earthlink.net/~jknapka/linux-mm/vminit.html#PAGING_INIT</=
A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>However, what I get is a stall as per =
the log=20
pasted below.&nbsp; Enabling</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>CONFIG_64BIT_PHYS_ADDR does not make a=20
difference.&nbsp; </FONT><FONT face=3DArial =
size=3D2>Results</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>were cross-verified between CFE and =
another=20
bootloader.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When I hand </FONT><FONT face=3DArial =
size=3D2>the=20
physical memory described above off to add_memory_region,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I noticed a few odd things. One thing =
that looks=20
suspicious is that the <FONT face=3DArial =
size=3D2>variable</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial size=3D2>void =
*high_memory ends up=20
being set to 0xa0000000, or right at KSEG1,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>in mm/init.c.</FONT></DIV></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Also, num_physpages became huge, =
0x90000, because=20
the </FONT><FONT face=3DArial size=3D2>init code in</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel/setup.c and mm/init.c want a =
page for every=20
memory location, </FONT><FONT face=3DArial size=3D2>even</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>highmem.&nbsp; Is this appropriate when =
the memory=20
is not directly accessible</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>via __va and virt_to_phys?&nbsp; =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This may be an ancillary effect of =
what's mentioned=20
above, but when num_physpages</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>grows in size, nr_free_pages doesn't =
track with it,=20
so in void vfs_caches_init(unsigned long</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mempages) and the like, you get a =
horrible=20
underflow condition:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>/* code */</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("MJS - nr_free_pages():0x%X\n",=20
nr_free_pages());<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printk("MJS -=20
OLD mempages:0x%X\n", mempages);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;=20
reserve =3D (mempages - nr_free_pages()) *=20
3/2;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mempages -=3D=20
reserve;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("MJS - NEW =

reserve:0x%X=20
mempages:0x%X\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
reserve, mempages);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><BR>/* printout */</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>MJS - nr_free_pages():0x1E9A0<BR>MJS - =
OLD=20
mempages:0x90000<BR>MJS - NEW reserve:0xAA190=20
mempages:0xFFFE5E70<BR></FONT><FONT face=3DArial size=3D2></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>Let me know what you think of this =
issue.&nbsp; In=20
anticipation of the</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>"Why not use MIPS64 build?" question, =
we'd prefer=20
to and will, but the </FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT>MIPS64 build has =
underperformed or had=20
bugs (SATA seek time,</FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT>networking signals, etc) =
that MIPS32=20
doesn't</FONT></FONT></FONT><FONT face=3DArial size=3D2>.&nbsp; For =
these=20
issues</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>or any case where the MIPS64 build =
isn't there yet,=20
it makes</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>sense to have the MIPS32 path =
open.</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Matt</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
Kernel Boot Log=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>CFE version 1.0.37 for BCM91125E=20
(64bit,SP,BE)<BR>Build Date: Mon Jun 28 18:33:29 CDT 2004 (</FONT><A=20
href=3D"mailto:mstarzewski@lsys1"><FONT face=3DArial=20
size=3D2>mstarzewski@lsys1</FONT></A><FONT face=3DArial =
size=3D2>)<BR>Copyright (C)=20
2000,2001,2002,2003 Broadcom Corporation.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Initializing Arena.<BR>Initializing=20
Devices.<BR>BCM91125E board revision 1<BR>Config switch: 0<BR>CPU: 1125H =

A2<BR>L2 Cache: 256KB<BR>SysCfg: 00800000004A0600 [PLL_DIV: 12, =
IOB0_DIV:=20
CPUCLK/4, IOB1_DIV: CPUCLK/3]<BR>CPU type 0x40103: 600MHz<BR>Total =
memory:=20
0x20000000 bytes (512MB)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Total memory used by CFE:&nbsp; =
0x8FE8AFC0 -=20
0x90000000 (1527872)<BR>Initialized=20
Data:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8FE8AFC0 - =

0x8FE94D40 (40320)<BR>BSS=20
Area:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x8FE94D40 - 0x8FE95430 (1776)<BR>Local=20
Heap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
0x8FE95430 - 0x8FF95430 (1048576)<BR>Stack=20
Area:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
0x8FF95430 - 0x8FF97430 (8192)<BR>Text (code)=20
segment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8FF97440 - 0x8FFFFFB8=20
(428920)<BR>Boot area (physical):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0FE49000 -=20
0x0FE89000<BR>Relocation =
Factor:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
I:F0397440 - D:0DF8AFC0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>CFE&gt; ifconfig eth0 =
-addr=3D10.52.33.67=20
-mask=3D255.255.0.0;boot -elf=20
10.52.0.4:/home/mstarzewski/li<BR>nux/kernels/mips26_works_cfe/vmlinux<BR=
>eth0:=20
Link speed: 100BaseT FDX<BR>Device eth0:&nbsp; hwaddr 40-00-10-06-40-00, =
ipaddr=20
10.52.33.67, mask =
255.255.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
gateway not set, nameserver not set<BR>Loader:elf Filesys:tftp Dev:eth0=20
File:10.52.0.4:/home/mstarzewski/linux/kernels/mips26_works_cf<BR>e/vmlin=
ux=20
Options:(null)<BR>Loading: 0xffffffff80100000/2558312 =
0xffffffff80370968/146032=20
Entry at 0xffffffff8032f018<BR>Variable=20
Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Value<BR>--------------------=20
--------------------------------------------------<BR>BOOT_CONSOLE&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
uart0<BR>CPU_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
1125H<BR>CPU_REVISION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
A2<BR>CPU_NUM_CORES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1<BR>CPU_SPEED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
600<BR>CFE_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

1.0.37<BR>CFE_BOARDNAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
BCM91125E<BR>CFE_MEMORYSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
512<BR>NET_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
eth0<BR>NET_IPADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
10.52.33.67<BR>NET_NETMASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
255.255.0.0<BR>NET_GATEWAY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
0.0.0.0<BR>NET_NAMESERVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0.0.0.0<BR>BOOT_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
eth0<BR>BOOT_FILE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
10.52.0.4:/home/mstarzewski/linux/kernels/mips26_works_cfe/vmlinux<BR>DEL=
ETING=20
BOOT_CONSOLE<BR>DELETING CPU_REVISION<BR>DELETING CPU_SPEED<BR>DELETING=20
CFE_BOARDNAME<BR>DELETING NET_DEVICE<BR>DELETING NET_NETMASK<BR>DELETING =

NET_NAMESERVER<BR>DELETING BOOT_FILE<BR>Variable=20
Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Value<BR>--------------------=20
--------------------------------------------------<BR>Closing=20
network.<BR>Starting program at 0xffffffff8032f018<BR>CFE=20
addr:0x000000000FE8A000 size:0x0000000000000000, type:0<BR>CFE=20
addr:0x0000000010000000 size:0x0000000000000000, =
type:-2147483648<BR>Broadcom=20
SiByte BCM1125H A2 @ 600 MHz (SB1 rev 3)<BR>Board type: SiByte BCM91250A =

(SWARM)<BR>Linux version 2.6.6-rc3 (</FONT><A=20
href=3D"mailto:mstarzewski@lsys1"><FONT face=3DArial=20
size=3D2>mstarzewski@lsys1</FONT></A><FONT face=3DArial size=3D2>) (gcc =
version 3.2.3=20
with SiByte modifications) #17 S<BR>MP Thu Dec 9 11:08:23 CST =
2004<BR>CPU=20
revision is: 00040103<BR>FPU revision is: 000f0103<BR>This kernel =
optimized for=20
board runs with CFE<BR>Determined physical RAM map:<BR>&nbsp;memory: =
0fe89e00 @=20
00000000 (usable)<BR>&nbsp;memory: 0ffffe00 @ 80000000 =
(usable)<BR>1791MB=20
HIGHMEM available.<BR>On node 0 totalpages: 589823<BR>&nbsp; DMA zone: =
131072=20
pages, LIFO batch:16<BR>&nbsp; Normal zone: 0 pages, LIFO =
batch:1<BR>&nbsp;=20
HighMem zone: 458751 pages, LIFO batch:16<BR>Built 1 zonelists<BR>Kernel =
command=20
line: root=3D/dev/nfs ip=3Dauto rw<BR>PID hash table entries: 4096 =
(order 12: 32768=20
bytes)<BR>Memory: 495040k/260644k available (1850k kernel code, 27020k =
reserved,=20
382k data, 264k init, 26<BR>2140k highmem)<BR>Calibrating delay loop... =
399.36=20
BogoMIPS</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&lt;&lt; STALL=20
&gt;&gt;</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0620_01C4DE0F.10321590--
