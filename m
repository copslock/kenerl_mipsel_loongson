Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2003 10:28:31 +0100 (BST)
Received: from [IPv6:::ffff:218.1.66.83] ([IPv6:::ffff:218.1.66.83]:46986 "HELO
	mail.citiz.net") by linux-mips.org with SMTP id <S8225217AbTH2J23> convert rfc822-to-8bit;
	Fri, 29 Aug 2003 10:28:29 +0100
Received: (umta 26746 invoked by uid 1820); 29 Aug 2003 09:28:02 -0000
X-Lasthop: 202.120.8.28
Received: from unknown (HELO hdtv) (unknown@202.120.8.28)
  by localhost with SMTP; 29 Aug 2003 09:28:02 -0000
From: "embedlf" <embedlf@citiz.net>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: how I mount the root fs from ramdisk??
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Fri, 29 Aug 2003 17:35:5 +0800
Message-Id: <20030829092829Z8225217-1272+4649@linux-mips.org>
Return-Path: <embedlf@citiz.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: embedlf@citiz.net
Precedence: bulk
X-list: linux-mips

linux-mips:
	I use mips cpu board to design my product. I want run linux embeded in this board.
But in this process,there is not harddisk on the board.
	So I should mount the root fs on ramdisk. Do you think so? I should make a ramdisk.

dd if=/dev/zero of=/dev/ram bs=1k count=2048
mke2fs -vm0 /dev/ram 2048
mount -t ext2 /dev/ram /mnt/ram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
After I mount it, I should copy some files to this folder.I used cross_compiler,
compiling linux on X86 PC.How do I make the file /sbin/init??where is the source??

dd if=/dev/ram bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz

	

　　　　　　　　embedlf
　　　　　　　　embedlf@citiz.net
　　　　　　　　　　2003-08-29
