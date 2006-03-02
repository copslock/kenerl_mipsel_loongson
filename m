Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 02:44:33 +0000 (GMT)
Received: from maillog.itri.org.tw ([61.61.254.20]:44971 "EHLO
	maillog.itri.org.tw") by ftp.linux-mips.org with ESMTP
	id S8133727AbWCBCoO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 02:44:14 +0000
Received: from mail.itri.org.tw (mail [140.96.157.2])
	by maillog.itri.org.tw (8.11.6+Sun/8.11.6) with ESMTP id k222kpg16124
	for <linux-mips@linux-mips.org>; Thu, 2 Mar 2006 10:46:56 +0800 (CST)
Received: from mail.itri.org.tw (localhost [127.0.0.1])
	by mail.itri.org.tw (8.13.4/8.13.4) with ESMTP id k222u05P020946
	for <linux-mips@linux-mips.org>; Thu, 2 Mar 2006 10:56:10 +0800 (CST)
Received: from ms4.itri.org.tw ([140.96.151.44])
	by mail.itri.org.tw (8.13.4/8.13.4) with ESMTP id k222taHn020771
	for <linux-mips@linux-mips.org>; Thu, 2 Mar 2006 10:56:00 +0800 (CST)
Received: from 11088002601 ([140.96.151.160])
          by ms4.itri.org.tw (Lotus Domino Release 5.0.13a)
          with ESMTP id 2006030210511299:40494 ;
          Thu, 2 Mar 2006 10:51:12 +0800 
Message-ID: <03a101c63da4$2b119020$8873608c@11088002601>
Reply-To: "Charles C.K.Lai" <cklai@itri.org.tw>
From:	"Charles C.K.Lai" <cklai@itri.org.tw>
To:	<linux-mips@linux-mips.org>
Subject: Initramfs on AMD DB1550 Board
Date:	Thu, 2 Mar 2006 10:51:02 +0800
Organization: N300 ICL/ITRI
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-MIMETrack: Itemize by SMTP Server on MS4/ITRI(Release 5.0.13a  |April 8, 2004) at 2006-03-02
 10:51:13 AM,
	Serialize by Router on MS4/ITRI(Release 5.0.13a  |April 8, 2004) at 2006-03-02
 10:51:38 AM,
	Serialize complete at 2006-03-02 10:51:38 AM
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0399_01C63DE7.329F2CB0"
Return-Path: <cklai@itri.org.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cklai@itri.org.tw
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0399_01C63DE7.329F2CB0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"

I downloaded kernel 2.6.14 from Linux-MIPS,
and compiled with gcc-3.4.4 and mipssde-6.02.03 toolchain.

I put the target directory at /init,
run gen_initramfs_list.sh with /init to a text file,
and assigned this text file to the initrd for cpio.

After compiled, loaded, and ran,
I got the message below,
Would someone tell me how to set the root parameter?
Thanks a lot!

=========================================================================================================

Linux version 2.6.14 (gcc version 3.4.4 mipssde-6.02.03-20050626CPU revision 
is: 03030200
AMD Alchemy Au1550/Db1550 Board
(PRId 03030200) @ 396MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: ln -s /linuxrc /init console=ttyS0,115200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
calculating r4koff... 00060ae0(396000)
CPU frequency 396.00 MHz
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 187268k/196608k available (1952k kernel code, 9056k reserved, 323k 
data)Mount-cache hash table entries: 512
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
Serial: Au1x00 driver
ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART
ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART
ttyS2 at I/O 0xb1400000 (irq = 9) is a AU1X00_UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth version 1.5 Pete Popov <ppopov@embeddedalley.com>
eth0: Au1x Ethernet found at 0xb0500000, irq 27
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Cannot open root device "<NULL>" or unknown-block(1,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(1,0) 

------=_NextPart_000_0399_01C63DE7.329F2CB0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="big5"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>I downloaded kernel 2.6.14 from Linux-MIPS, </DIV>
<DIV>and&nbsp;compiled with&nbsp;gcc-3.4.4 and mipssde-6.02.03 =
toolchain. </DIV>
<DIV>&nbsp;</DIV>
<DIV>I put the target directory at /init, </DIV>
<DIV>run gen_initramfs_list.sh with /init to a text file, </DIV>
<DIV>and assigned this text file to the initrd for cpio. </DIV>
<DIV>&nbsp;</DIV>
<DIV>After compiled, loaded, and ran, </DIV>
<DIV>I got the message below, </DIV>
<DIV>Would someone tell me how to set the root parameter? </DIV>
<DIV>Thanks a lot! </DIV>
<DIV>&nbsp;</DIV>
<DIV>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</DIV>
<DIV>&nbsp;</DIV>
<DIV>Linux version 2.6.14 (gcc version 3.4.4 mipssde-6.02.03-20050626CPU =

revision is: 03030200<BR>AMD Alchemy Au1550/Db1550 Board<BR>(PRId =
03030200) @=20
396MHZ<BR>BCLK switching enabled!<BR>Determined physical RAM=20
map:<BR>&nbsp;memory: 0c000000 @ 00000000 (usable)<BR>Built 1=20
zonelists<BR>Kernel command line: ln -s /linuxrc /init=20
console=3DttyS0,115200<BR>Primary instruction cache 16kB, physically =
tagged,=20
4-way, linesize 32 bytes.<BR>Primary data cache 16kB, 4-way, linesize 32 =

bytes.<BR>Synthesized TLB refill handler (17 =
instructions).<BR>Synthesized TLB=20
load handler fastpath (34 instructions).<BR>Synthesized TLB store =
handler=20
fastpath (34 instructions).<BR>Synthesized TLB modify handler fastpath =
(33=20
instructions).<BR>PID hash table entries: 1024 (order: 10, 16384=20
bytes)<BR>calculating r4koff... 00060ae0(396000)<BR>CPU frequency 396.00 =

MHz<BR>Dentry cache hash table entries: 32768 (order: 5, 131072=20
bytes)<BR>Inode-cache hash table entries: 16384 (order: 4, 65536=20
bytes)<BR>Memory: 187268k/196608k available (1952k kernel code, 9056k =
reserved,=20
323k data)Mount-cache hash table entries: 512<BR>Checking for 'wait'=20
instruction...&nbsp; unavailable.<BR>NET: Registered protocol family=20
16<BR>Serial: Au1x00 driver<BR>ttyS0 at I/O 0xb1100000 (irq =3D 0) is a=20
AU1X00_UART<BR>ttyS1 at I/O 0xb1200000 (irq =3D 8) is a =
AU1X00_UART<BR>ttyS2 at=20
I/O 0xb1400000 (irq =3D 9) is a AU1X00_UART<BR>io scheduler noop =
registered<BR>io=20
scheduler anticipatory registered<BR>io scheduler deadline =
registered<BR>io=20
scheduler cfq registered<BR>RAMDISK driver initialized: 16 RAM disks of =
8192K=20
size 1024 blocksize<BR>loop: loaded (max 8 devices)<BR>au1000eth version =
1.5=20
Pete Popov &lt;<A=20
href=3D"mailto:ppopov@embeddedalley.com">ppopov@embeddedalley.com</A>&gt;=
<BR>eth0:=20
Au1x Ethernet found at 0xb0500000, irq 27<BR>eth0: AMD 79C874 10/100 =
BaseT PHY=20
at phy address 31<BR>eth0: Using AMD 79C874 10/100 BaseT PHY as =
default<BR>eth1:=20
Au1x Ethernet found at 0xb0510000, irq 28<BR>eth1: AMD 79C874 10/100 =
BaseT PHY=20
at phy address 31<BR>eth1: Using AMD 79C874 10/100 BaseT PHY as =
default<BR>mice:=20
PS/2 mouse device common for all mice<BR>NET: Registered protocol family =
2<BR>IP=20
route cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>TCP =
established=20
hash table entries: 8192 (order: 3, 32768 bytes)<BR>TCP bind hash table =
entries:=20
8192 (order: 3, 32768 bytes)<BR>TCP: Hash tables configured (established =
8192=20
bind 8192)<BR>TCP reno registered<BR>TCP bic registered<BR>NET: =
Registered=20
protocol family 1<BR>NET: Registered protocol family 17<BR>NET: =
Registered=20
protocol family 15<BR>VFS: Cannot open root device "&lt;NULL&gt;" or=20
unknown-block(1,0)<BR>Please append a correct "root=3D" boot =
option<BR>Kernel=20
panic - not syncing: VFS: Unable to mount root fs on=20
unknown-block(1,0)</DIV></BODY></HTML>

------=_NextPart_000_0399_01C63DE7.329F2CB0--
