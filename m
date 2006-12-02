Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 01:47:33 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:5348 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038471AbWLBBr2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2006 01:47:28 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 7306915D4006
	for <linux-mips@linux-mips.org>; Fri,  1 Dec 2006 19:16:53 -0800 (PST)
Subject: initramfs -- boot args?
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 01 Dec 2006 17:59:51 -0800
Message-Id: <1165024791.6535.43.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

hi,
i m working on porting the 2.6.14.6 linux kernel to the encore m3 board
with the au1500 processor --

nfs is giving me errors (Kernel not syncing -- Attempted to kill init)
so i m trying to build an initrd image -- 

according to this document:
http://www.timesys.com/timesource/initramfs.htm

I built my own initramfs_data.cpio.gz file that contains the object file
for the hello world code below-

printkf("Hello World\n");
sleep(99999999);
return(0)

As part of make menuconfig, I pointed the CONFIG_INITRAMFS_SOURCE to the
loaction of this cpio.gz archive (which was abt 24MB) -- however, this
resulted in a Huge kernel image (174MB! -- i only have 64MB available on
this board) making it impossible to load the image onto the board.

then, I copied this initramfs_data.cpio.gz file into the linux/usr/
directory and build the kernel, leaving the CONFIG_INITRAMFS_SOURCE path
blank -- the size of the kernel build was back to normal 

what boot args should I now supply to the board? i tried giving
root=/dev/ram0 rw ip=the usual and init=hello, but this does not
work..(as expected) 

as i understand it, when the kernel is built with a non empty
initramfs_data.cpio.gz archive, it extracts the filesystem (in this case
init/hello) and mounts it as part of the rootfs...

Also, I m not sure how to enable support for initrd into my kernel, cus
there doesnt seem to be an option in the make menuconfig to that
effect?! -- but i m guessing it must be configured as i see the
CONFIG_INITRAMFS_SOURCE --

Could someone please point me to the right direction and also tell me if
what I m thinking is on the right/wrong track?

Thank you!
Ashlesha.
