Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 23:23:49 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:54949 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225236AbUCHXXs>; Mon, 8 Mar 2004 23:23:48 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20040308232255014006sma0e>
          (Authid: kumba12345);
          Mon, 8 Mar 2004 23:22:55 +0000
Message-ID: <404D0132.3020202@gentoo.org>
Date: Mon, 08 Mar 2004 18:26:42 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: 2.4 kernels + >=binutils-2.14.90.0.8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


Having an odd issue with booting 2.4 kernels built with 
binutils-2.14.90.0.8 and newer on an Indy R5000:

System Maintenance Menu

1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 5
Command Monitor.  Type "exit" to return to the menu.
 >> ls
scsi(0)disk(4)rdisk(0)partition(8)/:
2422x0  2425p6x1  2603x0  arcboot  2425x0  2423x0  2422x1
/dev/sda3/: no such device
 >> boot -f 2425x0

Cannot load scsi(0)disk(4)rdisk(0)partition(8)/2425x0.
Text start 0x8000000, size 0x194400 doesn't fit in a FreeMemory area.
Unable to load 2425x0: ``2425x0'' is not a valid file to boot.
 >>

This issue started appearing with binutils-2.14.90.0.8, and still exists 
in binutils-2.15.90.0.1.1.  If I downgrade to binutils-2.14.90.0.7, the 
issue goes away (This is a cross-compiled kernel, btw).  So this seems 
to be a binutils-specific issue.  I'm not sure what the change was that 
led to this.  Any binutils people have an idea or need more test data run?

For reference, the compiler used was gcc-3.3.3, and has been tried on 
2.4.22, 2.4.23, and 2.4.25 kernels.  I haven't tried it with 2.6.x 
kernels yet.  Other binaries built with these binutils don't seem to 
show any outward signs of problems, just seems to be kernels.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
