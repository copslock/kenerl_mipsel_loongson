Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA56296 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Feb 1999 08:20:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA84836
	for linux-list;
	Mon, 15 Feb 1999 08:20:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA89862
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 15 Feb 1999 08:20:03 -0800 (PST)
	mail_from (mkomiya@crossnet.co.jp)
Received: from cirrus.crossnet.co.jp ([210.159.46.17]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06005
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 Feb 1999 08:20:01 -0800 (PST)
	mail_from (mkomiya@crossnet.co.jp)
From: mkomiya@crossnet.co.jp
Received: from cirrus.komnet (localhost [127.0.0.1]) by cirrus.crossnet.co.jp (8.7.5+2.6Wbeta6/3.3Wb) with ESMTP id BAA06063 for <linux@cthulhu.engr.sgi.com>; Tue, 16 Feb 1999 01:15:14 +0900
Message-Id: <199902151615.BAA06063@cirrus.crossnet.co.jp>
To: linux@cthulhu.engr.sgi.com
Subject: cross-compile glibc2
X-Mailer: Mew version 1.70 on Emacs 19.28.1 / Mule 2.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Feb 1999 01:15:13 +0900
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm trying to compile glibc2.0.6 from SGI's ftp site
with egcs-1.0.2 as cross-compiler on Linux/Intel.

But I got following error messages on making shared lib stage.

Does any one suggest to me ?

Thank for your help.

M.Komiya

make[2]: Entering directory `/home/mkomiya/src/GNU/glibc-sgi-2.0.6/db'
mipsel-linux-gcc -g  -shared -o /home/mkomiya/src/GNU/glibc/mipsel-linux/db/libdb.so
-Wl,-dynamic-linker=/lib/mipsel-linuxld -B/home/mkomiya/src/GNU/glibc/mipsel-linux/csu/
-Wl,-soname=libdb.so.2   -L/home/mkomiya/src/GNU/glibc/mipsel-linux
-L/home/mkomiya/src/GNU/glibc/mipsel-linux/elf
-L/home/mkomiya/src/GNU/glibc/mipsel-linux/nss
-Wl,-rpath-link=/home/mkomiya/src/GNU/glibc/mipsel-linux:
/home/mkomiya/src/GNU/glibc/mipsel-linux/elf:
/home/mkomiya/src/GNU/glibc/mipsel-linux/nss
-Wl,--whole-archive /home/mkomiya/src/GNU/glibc/mipsel-linux/db/libdb_pic.a
/home/mkomiya/src/GNU/glibc/mipsel-linux/interp.so
/home/mkomiya/src/GNU/glibc/mipsel-linux/libc.so -Wl,--no-whole-archive 
collect2: ld terminated with signal 6 [Aborted]
