Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 19:14:18 +0100 (BST)
Received: from web8202.mail.in.yahoo.com ([IPv6:::ffff:203.199.70.115]:15937
	"HELO web8202.mail.in.yahoo.com") by linux-mips.org with SMTP
	id <S8225201AbUHQSON>; Tue, 17 Aug 2004 19:14:13 +0100
Message-ID: <20040817181402.73079.qmail@web8202.mail.in.yahoo.com>
Received: from [202.63.115.3] by web8202.mail.in.yahoo.com via HTTP; Tue, 17 Aug 2004 19:14:02 BST
Date: Tue, 17 Aug 2004 19:14:02 +0100 (BST)
From: =?iso-8859-1?q?Arravind=20babu?= <aravindforl@yahoo.co.in>
Subject: Doubt on rootfs
To: linux-mips@linux-mips.org
Cc: binutils@sources.redhat.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1285638652-1092766442=:71801"
Content-Transfer-Encoding: 8bit
Return-Path: <aravindforl@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aravindforl@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1285638652-1092766442=:71801
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
 
         I am cross-compiling linux 2.4.20 onto MIPS .I compiled and i booted the system.When i gave the command mount at the prompt it gave the following things.
 
$mount
 
rootfs on / type rootfs (rw)
/dev/rom0 on / type romfs (ro)
/dev/ram0 on /var type ext2 (rw)
/proc on /proc type proc (rw)
/dev/mtdblock6 on /flash type jffs2 (rw)
/dev/ram1 on /upgrade type sramfs (rw)
/dev/mtdblock5 on /apps type cramfs (ro)
devpts on /dev/pts type devpts (rw)

 
When i gave the same command on a normal linux 2.4.20 machine i got the following.
 
$mount
 
/dev/sda1 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda5 on /home type ext3 (rw)
/dev/sdb1 on /home1 type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

 
 
Why rootfs is not showing any device like in linux machine( /dev/sda1 on / type ext3)  ?
 I checked the files 
 
usr/src/linux/init/main.c
usr/src/linux/fs/ramfs/inode.c
usr/src/linux/fs/namespace.c
 
But i didnot got the point.Any idea is highly appreciated.My project is stopped due to this.Pls help me regarding this.
 
Thanks in advance,
Aravind.

Yahoo! India Matrimony: Find your life partneronline.
--0-1285638652-1092766442=:71801
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi all,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am cross-compiling linux 2.4.20 onto MIPS .I compiled and i booted the system.When i gave the command <STRONG>mount</STRONG> at the prompt it gave the following things.</DIV>
<DIV>&nbsp;</DIV>
<DIV>$mount</DIV>
<DIV><STRONG></STRONG>&nbsp;</DIV>
<DIV><STRONG>rootfs</STRONG> on / type <STRONG>rootfs</STRONG> (rw)<BR>/dev/rom0 on / type romfs (ro)<BR>/dev/ram0 on /var type ext2 (rw)<BR>/proc on /proc type proc (rw)<BR>/dev/mtdblock6 on /flash type jffs2 (rw)<BR>/dev/ram1 on /upgrade type sramfs (rw)<BR>/dev/mtdblock5 on /apps type cramfs (ro)<BR>devpts on /dev/pts type devpts (rw)<BR></DIV>
<DIV>&nbsp;</DIV>
<DIV>When i gave the same command on a <STRONG>normal linux</STRONG> 2.4.20 machine i got the following.</DIV>
<DIV>&nbsp;</DIV>
<DIV>$mount</DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG>/dev/sda1</STRONG> on / type <STRONG>ext3</STRONG> (rw)<BR>none on /proc type proc (rw)<BR>usbdevfs on /proc/bus/usb type usbdevfs (rw)<BR>none on /dev/pts type devpts (rw,gid=5,mode=620)<BR>/dev/sda5 on /home type ext3 (rw)<BR>/dev/sdb1 on /home1 type ext3 (rw)<BR>none on /dev/shm type tmpfs (rw)<BR>none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)<BR></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Why rootfs is not showing any device like in linux machine( <STRONG>/dev/sda1</STRONG> on / type <STRONG>ext3)</STRONG>&nbsp; ?</DIV>
<DIV>&nbsp;I checked the files </DIV>
<DIV>&nbsp;</DIV>
<DIV>usr/src/linux/init/main.c</DIV>
<DIV>usr/src/linux/fs/ramfs/inode.c</DIV>
<DIV>usr/src/linux/fs/namespace.c</DIV>
<DIV>&nbsp;</DIV>
<DIV>But i didnot got the point.Any idea is highly appreciated.My project is stopped due to this.Pls help me regarding this.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in advance,</DIV>
<DIV>Aravind.</DIV><p><font face=arial size=-1>
<a href="http://in.rd.yahoo.com/specials/mailtg/*http://yahoo.shaadi.com/india-matrimony/" target="_blank">
<b>Yahoo! India Matrimony</a>:</b> Find your life partner
<a href="http://in.rd.yahoo.com/specials/mailtg2/*http://yahoo.shaadi.com/india-matrimony/" target="_blank">online</a>.</font>
--0-1285638652-1092766442=:71801--
