Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 11:11:28 +0100 (BST)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:37903
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225421AbTIRKL0>; Thu, 18 Sep 2003 11:11:26 +0100
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <SK19GYC3>; Thu, 18 Sep 2003 18:07:10 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F68019BF846@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: embedlf <embedlf@citiz.net>
Cc: linux-mips@linux-mips.org
Subject: RE: the problem about open file on ramdisk
Date: Thu, 18 Sep 2003 18:06:59 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C37DCC.996F1460"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C37DCC.996F1460
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable


you cpu: 00001800

	RC32334 ??? I dont know it.

epc  : 80105088    Not tainted
	It is the exception VICTIM.Could you offer the instruction at
0x80105088?

Status: 10018003
	you can analysis this register for information,I dont know the cpu
type,so Status...
=09
Cause : 0000000c
	in my cpu(r3000 similar) means ExcCode 3,TLB miss

It seems to me that NULL pointer has been refered in kernel,at =
0x80105088.
you could change the kernel,or try to find out where the NULL pointer =
is
generated.

Just FYI.

-----Original Message-----
From: embedlf [mailto:embedlf@citiz.net]
Sent: Thursday, September 18, 2003 9:22 AM
To: linux-mips@linux-mips.org
Subject: the problem about open file on ramdisk


linux-mips:
	 I use initrd ramdisk as rootfs on my mips cpu board.But after
compiling kernel and download it to the board,that print the error
message.Following is the message.

CPU revision is: 00001800

Primary instruction cache 64kb, linesize 16 bytes.

Primary data cache 16kb, linesize 16 bytes.

Linux version 2.4.18-MIPS-01.01 (l@l) (gcc version 2.96) #147 =C8=FD =
9=D4=C2 17
15:21:28 CST 2003

Determined physical RAM map:

 memory: 04000000 @ 00000000 (usable)

Initial ramdisk at: 0x80270000 (1917091 bytes)

On node 0 totalpages: 16384

zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:=20
Calibrating delay loop... 299.00 BogoMIPS
Memory: 59992k/65536k available (1281k kernel code, 5544k reserved, =
1976k
data, 72k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Dummy keyboard driver installed.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
block: 128 slots per queue, batch=3D32
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1872k freed

VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k freed
kernel BUG at traps.c:627!

Unable to handle kernel paging request at virtual address 00000000, epc =
=3D=3D
80105088, ra =3D=3D 80105088

Oops in fault.c:do_page_fault, line 205:

$0 : 00000000 10018000 0000001b 00000000 80262d10 00000001 00000001 =
00000000

$8 : 00001289 00001289 80450000 80448139 00000000 00000000 fffffff9 =
0000000a

$16: 80251000 8113bca8 00000440 8110e320 8116f660 00000000 00000000 =
00000000

$24: ffffffff 8113bb4a                   8113a000 8113bc88 80458538 =
80105088

Hi : 00000000

Lo : 00000200

epc  : 80105088    Not tainted

Status: 10018003

Cause : 0000000c

Process swapper (pid: 1, stackpage=3D8113a000)

Stack: 80229740 80229738 00000273 10018001 80251000 8116d000 00000440
80103f4c

       83a202a0 8013147c 83a20660 00000000 83a20660 80263dec 00000000
80252000

       80440000 8010a480 80251000 00000000 00000250 10018001 00000000
80225ad8

       00ff0000 000003e8 00000001 80232700 80254000 8116f260 80251000
8116d000

       00000440 8110e320 8116f660 00000000 00000000 00000000 00000400
81169000

       8046a8c0 ...

Call Trace:

Code: 24a59738  0c045adb  24060273 <ac000000> 8e2200ac  04410002  =
8e2400a0
24840004  24820004=20

Kernel panic: Attempted to kill init!

 <0>Rebooting in 180 seconds..


At the address 80105088, there is the function do_ri() in traps.c. I =
found
that this fault
was caused by "if (open("/dev/console", O_RDWR, 0) < 0)".Why?
	please help me to analyse this fault.How to conquer it?


=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1embedlf
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1embedlf@citiz.net
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12003-09-18



------_=_NextPart_001_01C37DCC.996F1460
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DGB2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: the problem about open file on ramdisk</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=3D2>you cpu: 00001800</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>RC32334 =
??? I dont know it.</FONT>
</P>

<P><FONT SIZE=3D2>epc&nbsp; : 80105088&nbsp;&nbsp;&nbsp; Not =
tainted</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>It is the =
exception VICTIM.Could you offer the instruction at 0x80105088?</FONT>
</P>

<P><FONT SIZE=3D2>Status: 10018003</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>you can =
analysis this register for information,I dont know the cpu type,so =
Status...</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2>Cause : 0000000c</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>in my =
cpu(r3000 similar) means ExcCode 3,TLB miss</FONT>
</P>

<P><FONT SIZE=3D2>It seems to me that NULL pointer has been refered in =
kernel,at 0x80105088.</FONT>
<BR><FONT SIZE=3D2>you could change the kernel,or try to find out where =
the NULL pointer is generated.</FONT>
</P>

<P><FONT SIZE=3D2>Just FYI.</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: embedlf [<A =
HREF=3D"mailto:embedlf@citiz.net">mailto:embedlf@citiz.net</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Thursday, September 18, 2003 9:22 AM</FONT>
<BR><FONT SIZE=3D2>To: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2>Subject: the problem about open file on =
ramdisk</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>linux-mips:</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE=3D2> I =
use initrd ramdisk as rootfs on my mips cpu board.But after compiling =
kernel and download it to the board,that print the error =
message.Following is the message.</FONT></P>

<P><FONT SIZE=3D2>CPU revision is: 00001800</FONT>
</P>

<P><FONT SIZE=3D2>Primary instruction cache 64kb, linesize 16 =
bytes.</FONT>
</P>

<P><FONT SIZE=3D2>Primary data cache 16kb, linesize 16 bytes.</FONT>
</P>

<P><FONT SIZE=3D2>Linux version 2.4.18-MIPS-01.01 (l@l) (gcc version =
2.96) #147 =C8=FD 9=D4=C2 17 15:21:28 CST 2003</FONT>
</P>

<P><FONT SIZE=3D2>Determined physical RAM map:</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;memory: 04000000 @ 00000000 (usable)</FONT>
</P>

<P><FONT SIZE=3D2>Initial ramdisk at: 0x80270000 (1917091 bytes)</FONT>
</P>

<P><FONT SIZE=3D2>On node 0 totalpages: 16384</FONT>
</P>

<P><FONT SIZE=3D2>zone(0): 16384 pages.</FONT>
<BR><FONT SIZE=3D2>zone(1): 0 pages.</FONT>
<BR><FONT SIZE=3D2>zone(2): 0 pages.</FONT>
<BR><FONT SIZE=3D2>Kernel command line: </FONT>
<BR><FONT SIZE=3D2>Calibrating delay loop... 299.00 BogoMIPS</FONT>
<BR><FONT SIZE=3D2>Memory: 59992k/65536k available (1281k kernel code, =
5544k reserved, 1976k data, 72k init, 0k highmem)</FONT>
<BR><FONT SIZE=3D2>Dentry-cache hash table entries: 8192 (order: 4, =
65536 bytes)</FONT>
<BR><FONT SIZE=3D2>Inode-cache hash table entries: 4096 (order: 3, =
32768 bytes)</FONT>
<BR><FONT SIZE=3D2>Mount-cache hash table entries: 1024 (order: 1, 8192 =
bytes)</FONT>
<BR><FONT SIZE=3D2>Buffer-cache hash table entries: 4096 (order: 2, =
16384 bytes)</FONT>
<BR><FONT SIZE=3D2>Page-cache hash table entries: 16384 (order: 4, =
65536 bytes)</FONT>
<BR><FONT SIZE=3D2>Checking for 'wait' instruction...&nbsp; =
available.</FONT>
<BR><FONT SIZE=3D2>POSIX conformance testing by UNIFIX</FONT>
<BR><FONT SIZE=3D2>Linux NET4.0 for Linux 2.4</FONT>
<BR><FONT SIZE=3D2>Based upon Swansea University Computer Society =
NET3.039</FONT>
<BR><FONT SIZE=3D2>Initializing RT netlink socket</FONT>
<BR><FONT SIZE=3D2>Starting kswapd</FONT>
<BR><FONT SIZE=3D2>Journalled Block Device driver loaded</FONT>
<BR><FONT SIZE=3D2>Dummy keyboard driver installed.</FONT>
<BR><FONT SIZE=3D2>Serial driver version 5.05c (2001-07-08) with =
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled</FONT>
<BR><FONT SIZE=3D2>block: 128 slots per queue, batch=3D32</FONT>
<BR><FONT SIZE=3D2>RAMDISK driver initialized: 16 RAM disks of 16384K =
size 1024 blocksize</FONT>
<BR><FONT SIZE=3D2>NET4: Linux TCP/IP 1.0 for NET4.0</FONT>
<BR><FONT SIZE=3D2>IP Protocols: ICMP, UDP, TCP, IGMP</FONT>
<BR><FONT SIZE=3D2>IP: routing cache hash table of 512 buckets, =
4Kbytes</FONT>
<BR><FONT SIZE=3D2>TCP: Hash tables configured (established 4096 bind =
4096)</FONT>
<BR><FONT SIZE=3D2>NET4: Unix domain sockets 1.0/SMP for Linux =
NET4.0.</FONT>
</P>

<P><FONT SIZE=3D2>RAMDISK: Compressed image found at block 0</FONT>
</P>

<P><FONT SIZE=3D2>Freeing initrd memory: 1872k freed</FONT>
</P>

<P><FONT SIZE=3D2>VFS: Mounted root (ext2 filesystem).</FONT>
<BR><FONT SIZE=3D2>Freeing unused kernel memory: 72k freed</FONT>
<BR><FONT SIZE=3D2>kernel BUG at traps.c:627!</FONT>
</P>

<P><FONT SIZE=3D2>Unable to handle kernel paging request at virtual =
address 00000000, epc =3D=3D 80105088, ra =3D=3D 80105088</FONT>
</P>

<P><FONT SIZE=3D2>Oops in fault.c:do_page_fault, line 205:</FONT>
</P>

<P><FONT SIZE=3D2>$0 : 00000000 10018000 0000001b 00000000 80262d10 =
00000001 00000001 00000000</FONT>
</P>

<P><FONT SIZE=3D2>$8 : 00001289 00001289 80450000 80448139 00000000 =
00000000 fffffff9 0000000a</FONT>
</P>

<P><FONT SIZE=3D2>$16: 80251000 8113bca8 00000440 8110e320 8116f660 =
00000000 00000000 00000000</FONT>
</P>

<P><FONT SIZE=3D2>$24: ffffffff =
8113bb4a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8113a000 8113bc88 80458538 =
80105088</FONT>
</P>

<P><FONT SIZE=3D2>Hi : 00000000</FONT>
</P>

<P><FONT SIZE=3D2>Lo : 00000200</FONT>
</P>

<P><FONT SIZE=3D2>epc&nbsp; : 80105088&nbsp;&nbsp;&nbsp; Not =
tainted</FONT>
</P>

<P><FONT SIZE=3D2>Status: 10018003</FONT>
</P>

<P><FONT SIZE=3D2>Cause : 0000000c</FONT>
</P>

<P><FONT SIZE=3D2>Process swapper (pid: 1, stackpage=3D8113a000)</FONT>
</P>

<P><FONT SIZE=3D2>Stack: 80229740 80229738 00000273 10018001 80251000 =
8116d000 00000440 80103f4c</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83a202a0 =
8013147c 83a20660 00000000 83a20660 80263dec 00000000 80252000</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80440000 =
8010a480 80251000 00000000 00000250 10018001 00000000 80225ad8</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00ff0000 =
000003e8 00000001 80232700 80254000 8116f260 80251000 8116d000</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000440 =
8110e320 8116f660 00000000 00000000 00000000 00000400 81169000</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8046a8c0 =
...</FONT>
</P>

<P><FONT SIZE=3D2>Call Trace:</FONT>
</P>

<P><FONT SIZE=3D2>Code: 24a59738&nbsp; 0c045adb&nbsp; 24060273 =
&lt;ac000000&gt; 8e2200ac&nbsp; 04410002&nbsp; 8e2400a0&nbsp; =
24840004&nbsp; 24820004 </FONT>
</P>

<P><FONT SIZE=3D2>Kernel panic: Attempted to kill init!</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&lt;0&gt;Rebooting in 180 seconds..</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>At the address 80105088, there is the function =
do_ri() in traps.c. I found that this fault</FONT>
<BR><FONT SIZE=3D2>was caused by &quot;if =
(open(&quot;/dev/console&quot;, O_RDWR, 0) &lt; 0)&quot;.Why?</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>please =
help me to analyse this fault.How to conquer it?</FONT>
</P>
<BR>

<P><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1embedlf</FONT>
<BR><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1embedlf@citiz.n=
et</FONT>
<BR><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1200=
3-09-18</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C37DCC.996F1460--
