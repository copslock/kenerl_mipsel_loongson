Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 07:03:09 +0100 (BST)
Received: from mail.sjtu.edu.cn ([IPv6:::ffff:202.112.26.55]:61879 "EHLO
	mx1.sjtu.edu.cn") by linux-mips.org with ESMTP id <S8224771AbUDNGDH>;
	Wed, 14 Apr 2004 07:03:07 +0100
Received: from localhost (mx1.sjtu.edu.cn [127.0.0.1])
	by mx1.sjtu.edu.cn (Postfix) with ESMTP id 714B57B0222
	for <linux-mips@linux-mips.org>; Wed, 14 Apr 2004 14:03:02 +0800 (CST)
Received: from mx1.sjtu.edu.cn ([127.0.0.1])
 by localhost (mx1.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22302-03 for <linux-mips@linux-mips.org>;
 Wed, 14 Apr 2004 14:03:02 +0800 (CST)
Received: from caoxiang (unknown [218.193.188.71])
	by mx1.sjtu.edu.cn (Postfix) with ESMTP id F2F297B01A5
	for <linux-mips@linux-mips.org>; Wed, 14 Apr 2004 14:03:01 +0800 (CST)
Date: Wed, 14 Apr 2004 14:05:23 +0800
From: "caoxiang" <remex_cao@sjtu.edu.cn>
Reply-To: remex_cao@sjtu.edu.cn
To: "Linux MIPS" <linux-mips@linux-mips.org>
Subject: 
Organization: sjtu
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon652456816835_====="
Message-Id: <20040414060301.F2F297B01A5@mx1.sjtu.edu.cn>
X-Virus-Scanned: by amavisd-new at mx1.sjtu.edu.cn
Return-Path: <remex_cao@sjtu.edu.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: remex_cao@sjtu.edu.cn
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.

--=====003_Dragon652456816835_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Greetings

I've encountered a problem when I am porting linux 2.4.3 to the SEAD-2 board.

The tool-chain I used include:
gcc-mipsel-linux-2.95.4
gcc-mips-linux-2.95.4
binutils-mipsel-linux-2.13.1
An error occured like that When I make the kernel:
mipsel-linux-ld -static -G 0 -T arch/mips/ld.script arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \        --start-group \        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o drivers/usb/usbdrv.o \        net/network.o \        arch/mips/lib/lib.a /usr/local/0_mips/linux-2.4.3/lib/lib.a arch/mips/mips-boards/sead/sead.o arch/mips/mips-boards/generic/mipsboards.o \        --end-group \        -o vmlinuxmipsel-linux-ld: target elf32-littlemips not foundmake: *** [vmlinux] Error 1
As I change to big endian the problem still exists. Shall I apply some patch?
Thanks for help.
remex

--=====003_Dragon652456816835_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2719.2200" name=GENERATOR></HEAD>
<BODY bgColor=#e7e7e7><PRE>Greetings

I've encountered a problem when I am porting linux 2.4.3 to the SEAD-2 board.

The tool-chain I used include:</PRE><PRE>gcc-mipsel-linux-2.95.4</PRE><PRE>gcc-mips-linux-2.95.4</PRE><PRE>binutils-mipsel-linux-2.13.1</PRE><PRE>An error occured like that When I make the kernel:</PRE><PRE>mipsel-linux-ld -static -G 0 -T arch/mips/ld.script arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --start-group \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o&nbsp; drivers/parport/driver.o drivers/usb/usbdrv.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; net/network.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/lib/lib.a /usr/local/0_mips/linux-2.4.3/lib/lib.a arch/mips/mips-boards/sead/sead.o arch/mips/mips-
 boards/generic/mipsboards.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --end-group \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o vmlinux<BR>mipsel-linux-ld: target elf32-littlemips not found<BR>make: *** [vmlinux] Error 1</PRE><PRE>As I change to big endian the problem still exists. Shall I apply some patch?</PRE><PRE>Thanks for help.</PRE><PRE>remex</PRE><!--X-Body-of-Message-End--><!--X-MsgBody-End--><!--X-Follow-Ups--></BODY></HTML>

--=====003_Dragon652456816835_=====--
