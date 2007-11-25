Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 12:53:27 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:28430 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20032706AbXKYMxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 12:53:19 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 848A0D8E3; Sun, 25 Nov 2007 12:52:41 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 72EF5544F2; Sun, 25 Nov 2007 13:52:29 +0100 (CET)
Date:	Sun, 25 Nov 2007 13:52:29 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: BigSur: oops loading ramdisk
Message-ID: <20071125125229.GJ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

With a 32 bit kernel (current git) on BigSur, I get an oops while
trying to load the ramdisk:

Linux version 2.6.24-rc3-g2ffbb837-dirty (tbm@em64t) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #4 Sun Nov 25 12:44:26 UTC 2007
...
RPC: Registered tcp transport module.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 802931b8, ra == 802965f4
Oops[#1]:
Cpu 0
$ 0   : 00000000 10001f00 00000000 00000000
$ 4   : 8ed01000 00000000 8f421df8 00000000
$ 8   : 80430000 8f472a6c 00000000 0000000e
$12   : 8f00603c ffffffff 00000000 00000084
$16   : 8f4a22c0 80440000 00500001 8ed01000
$20   : 00000002 8f0147a0 00000000 00000000
$24   : 00000003 000000cd
$28   : 8f420000 8f421da8 00000000 802965f4
Hi    : 00000002
Lo    : 82828285
epc   : 802931b8 init_dev+0x8c/0x56c     Not tainted
ra    : 802965f4 tty_open+0x148/0x330
Status: 10001f03    KERNEL EXL IE
Cause : 00808008
BadVA : 00000000
PrId  : 01041100 (SiByte SB1A)
Modules linked in:
Process swapper (pid: 1, threadinfo=8f420000, task=8f41f928)
Stack : 80178a60 00000003 804487e4 8ed01000 8f421dfc 00000000 8f4a22c0 80440000
        00500001 00000001 00000002 8f0147a0 00000000 00000000 00000000 802965f4
        8f006d28 00000000 8f421df8 00000000 8f006d28 00000000 00000000 8048ff20
        8f006d28 8f4a22c0 8f4032a0 80173018 00000000 8f413000 ffffff9c 8017bb74
        00000000 80435ba0 8f4a22c0 8f006d28 00000000 80172ef8 8016df8c 80430000
        ...
Call Trace:
[<802931b8>] init_dev+0x8c/0x56c
[<802965f4>] tty_open+0x148/0x330
[<80173018>] chrdev_open+0x120/0x178
[<8016df8c>] __dentry_open+0x104/0x210
[<8016e144>] nameidata_to_filp+0x30/0x54
[<8016e1a8>] do_filp_open+0x40/0x54
[<8016e220>] do_sys_open+0x64/0x114
[<80100448>] init_post+0x30/0xe8
[<80450874>] kernel_init+0x2e4/0x314


Code: 8c8200a0  00051880  00431021 <8c510000> 162000e2  00000000  8e64003c  10800009  24020002
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 5 seconds..Passing control back to CFE...

-- 
Martin Michlmayr
http://www.cyrius.com/
