Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 09:11:28 +0100 (BST)
Received: from host238-171-dynamic.0-79-r.retail.telecomitalia.it ([79.0.171.238]:29597
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20029124AbXJQILT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 09:11:19 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ii3wi-0001at-DR
	for linux-mips@linux-mips.org; Wed, 17 Oct 2007 10:08:06 +0200
Date:	Wed, 17 Oct 2007 10:08:03 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: Problems writing to USB devices
Message-Id: <20071017100803.7794bb87.giuseppe@eppesuigoccas.homedns.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
I am still testing new kernels on the ip32 platform (and learning kernel structure :-)). Currently I found problems in writing to USB block devices. I may read from a pendrive without problem, but when I try to write the process stop.
This is the last part of a transcript of strace output for "pvcreate /dev/sdc" command:

[...]
open("/dev/sdc", O_RDWR|O_EXCL|O_LARGEFILE|O_NOATIME) = 4
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 32), ...}) = 0
ioctl(4, BLKFLSBUF, 0)                  = 0
close(4)                                = 0
open("/dev/sdc", O_RDONLY|O_LARGEFILE)  = 4
ioctl(4, BLKGETSIZE64, 0x7fbe2260)      = 0
close(4)                                = 0
stat64(0x4e6f00, 0x7fbe2090)            = 0
stat64(0x4e6f00, 0x7fbe2178)            = 0
open("/dev/sdc", O_RDWR|O_LARGEFILE|O_NOATIME) = 4
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 32), ...}) = 0
ioctl(4, BLKFLSBUF, 0)                  = 0
ioctl(4, BLKBSZGET, 0x4e6d18)           = 0
_llseek(4, 524222464, [524222464], SEEK_SET) = 0
read(4, "\307^\277\322\244R\36L\252\362G\\\366\3674\310@`K\374\373"..., 4096) = 4096
close(4)                                = 0
stat64(0x7fbe3edd, 0x7fbe21c8)          = 0
open("/dev/urandom", O_RDONLY|O_LARGEFILE) = 4
read(4, "m\v\205x\374S\374\6\347\222MJGPJ|\"\300\207\376\323r\270"..., 32) = 32
close(4)                                = 0
open("/dev/sdc", O_RDONLY|O_LARGEFILE)  = 4
ioctl(4, BLKGETSIZE64, 0x4efbb8)        = 0
close(4)                                = 0
stat64(0x4e6f00, 0x7fbe0fb0)            = 0
stat64(0x4e6f00, 0x7fbe1098)            = 0
open("/dev/sdc", O_RDWR|O_LARGEFILE|O_NOATIME) = 4
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 32), ...}) = 0
ioctl(4, BLKFLSBUF, 0)                  = 0
ioctl(4, BLKBSZGET, 0x4e6d18)           = 0
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\1\7\2\7\3\7\4\7\5\7\6\7\7\7\10\7\t\7\n\7\v\7\f\7\r\7\16"..., 4096) = 4096
_llseek(4, 4096, [4096], SEEK_SET)      = 0
write(4, "\0\7\2\7\3\7\4\7\5\7\6\7\7\7\10\7\t\7\n\7\v\7\f\7\r\7\16"..., 4096) = 4096
ioctl(4, BLKFLSBUF

The process hung during ioctl(4,BLKFLSBUF,0), but this very ioctl is issued successfully many times during the process. This time the iocl is done just after the first "write()", so I think the problem is in the write() command.

I have the same problem writing a new mbr (with fdisk or cfdisk) on this device: the device will not be changed at all.

Any ideas on what to check?

Thanks (again),
Giuseppe
