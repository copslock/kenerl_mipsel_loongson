Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2003 21:27:58 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:54216 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225352AbTH2U10> convert rfc822-to-8bit;
	Fri, 29 Aug 2003 21:27:26 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h7TKPsEY018410;
	Fri, 29 Aug 2003 13:25:54 -0700 (PDT)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA16346;
	Fri, 29 Aug 2003 13:27:27 -0700 (PDT)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <Q30X1Q2G>; Fri, 29 Aug 2003 13:24:48 -0700
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A02264D07@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: "'jeff'" <jeff_lee@coventive.com>, embedlf <embedlf@citiz.net>,
	linux-mips@linux-mips.org
Subject: RE: how I mount the root fs from ramdisk??
Date: Fri, 29 Aug 2003 13:24:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips

This page is better for ramdisk howto ...

http://www.linux-vr.org/ramdisk.html

-earlm

>-----Original Message-----
>From: jeff [mailto:jeff_lee@coventive.com]
>Sent: Friday, August 29, 2003 3:40 AM
>To: embedlf; linux-mips@linux-mips.org
>Subject: RE: how I mount the root fs from ramdisk??
>
>Please download the busybox and make it to be mips binary.
>Or you can find some usable information from http://linux.junsun.net
>
>Regards,
>
>Jeff
>
>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
>mips.org]On Behalf Of embedlf
>Sent: Friday, August 29, 2003 5:00 PM
>To: linux-mips@linux-mips.org
>Subject: how I mount the root fs from ramdisk??
>
>
>linux-mips:
>	I use mips cpu board to design my product. I want run linux embeded
>in this board.
>But in this process,there is not harddisk on the board.
>	So I should mount the root fs on ramdisk. Do you think so? I should
>make a ramdisk.
>
>dd if=/dev/zero of=/dev/ram bs=1k count=2048
>mke2fs -vm0 /dev/ram 2048
>mount -t ext2 /dev/ram /mnt/ram
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>After I mount it, I should copy some files to this folder.I used
>cross_compiler,
>compiling linux on X86 PC.How do I make the file /sbin/init??where is the
>source??
>
>dd if=/dev/ram bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
>
>
>
>　　　　　　　　embedlf
>　　　　　　　　embedlf@citiz.net
>　　　　　　　　　　2003-08-29
