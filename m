Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 11:35:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:24080 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133541AbWB1LfO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 11:35:14 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id EDD1464D3D; Tue, 28 Feb 2006 11:42:56 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 691C281F5; Tue, 28 Feb 2006 12:42:49 +0100 (CET)
Date:	Tue, 28 Feb 2006 11:42:49 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Non-fatal oops on SGI IP22 when doing: md5sum /dev/core
Message-ID: <20060228114249.GA2587@deprecation.cyrius.com>
References: <20060228114137.GA3087@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228114137.GA3087@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the (different) non-fatal oopses on SGI IP22 (2.6.16-rc5) when
running "md5sum /dev/core".  Two exampls are attached below.  FWIW,
this works on i386.


sgi:/# md5sum /dev/core
Segmentation fault

MC Bus Error
GIO error 0x400:<TIME > @ 0x00090000
Data bus error, epc == ffffffff881b0cf0, ra == ffffffff880e06c0
Oops[#10]:
Cpu 0
$ 0   : 0000000000000000 0000000000000004 0000000000001000 0000000000000000
$ 4   : 00000000100033a8 ffffffff80090000 0000000000001000 0000000000091000
$ 8   : 0000000000000040 0000000000000000 0000000000000000 00000000000000b0
$12   : 00000000000000b0 00000000100043a8 ffffffff88090fc8 00000000000000b0
$16   : 0000000000001000 ffffffff80090000 0000000000001000 ffffffff8a6dfe88
$20   : 0000000000007000 0000000000001000 ffffffff8a6dfe88 00000000100033a8
$24   : 0000000000000000 000000002abd5ca0                                  
$28   : ffffffff8a6dc000 ffffffff8a6dfb20 ffffffff88430000 ffffffff880e06c0
Hi    : 0000000000000000
Lo    : 0000000000000150
epc   : ffffffff881b0cf0 both_aligned+0x10/0x64     Not tainted
ra    : ffffffff880e06c0 read_kcore+0x220/0x7a0
Status: 3004cce3    KX SX UX KERNEL EXL IE 
Cause : 1000401c
PrId  : 00000460
Modules linked in: md5 ipv6
Process md5sum (pid: 1213, threadinfo=ffffffff8a6dc000, task=ffffffff8c0e0d58)
Stack : ffffffff8831a898 00000001000001e0 ffffffff8a6dfbf0 ffffffff8831a898
        0000000300000088 ffffffff8a6dfb68 ffffffff8831a898 0000000400000618
        ffffffff8c0e0d58 0052000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 766d6c696e757800 0000000000000000
        726f6f743d2f6465 762f736461310000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        ...
Call Trace:
 [<ffffffff88183c90>] avc_has_perm+0x68/0x98
 [<ffffffff88183f70>] inode_has_perm+0x50/0xb8
 [<ffffffff88041138>] getnstimeofday+0x18/0x50
 [<ffffffff88058cf8>] ktime_get_ts+0x60/0xb8
 [<ffffffff881840b8>] file_has_perm+0xe0/0x108
 [<ffffffff881ea24c>] i8042_interrupt+0x64/0x4e8
 [<ffffffff880902bc>] vfs_read+0xfc/0x1b8
 [<ffffffff88091014>] sys_read+0x4c/0x90
 [<ffffffff8801de8c>] handle_sys+0x12c/0x148


sgi:/# md5sum /dev/core
Segmentation fault

Code: 11000017  30d8003f  00000000 <dca80000> dca90008  dcaa0010  dcab0018  64c6ffc0  dcac0020 
MC Bus Error
GIO error 0x400:<TIME > @ 0x00090000
Data bus error, epc == ffffffff881b0cf0, ra == ffffffff880e06c0
Oops[#11]:
Cpu 0
$ 0   : 0000000000000000 0000000000000004 0000000000001000 0000000000000000
$ 4   : 00000000100033a8 ffffffff80090000 0000000000001000 0000000000091000
$ 8   : 0000000000000040 0000000000000000 0000000000000000 00000000000000b0
$12   : 00000000000000b0 00000000100043a8 ffffffff88090fc8 00000000000000b0
$16   : 0000000000001000 ffffffff80090000 0000000000001000 ffffffff8a6dfe88
$20   : 0000000000007000 0000000000001000 ffffffff8a6dfe88 00000000100033a8
$24   : 0000000000000000 000000002abd5ca0                                  
$28   : ffffffff8a6dc000 ffffffff8a6dfb20 ffffffff88430000 ffffffff880e06c0
Hi    : 0000000000000000
Lo    : 0000000000000150
epc   : ffffffff881b0cf0 both_aligned+0x10/0x64     Not tainted
ra    : ffffffff880e06c0 read_kcore+0x220/0x7a0
Status: 1004cce3    KX SX UX KERNEL EXL IE 
Cause : 1000401c
PrId  : 00000460
Modules linked in: md5 ipv6
Process md5sum (pid: 1214, threadinfo=ffffffff8a6dc000, task=ffffffff8c0e0d58)
Stack : ffffffff88041ccc ffffffff88420000 0000000000000000 ffffffff884250b8
        000000000000000a ffffffff88420000 ffffffff88041e0c 0000000000000000
        000000003004cce0 0000000000000000 0000000000000001 0000000000000003
        0000000000000002 ffffffff8a6dfdc0 0000000000000002 ffffffff88041f88
        0000000000008000 ffffffff88005ab8 0000000000000000 0000000000000004
        0000000000000000 ffffffff884344f0 0000000000000001 0000000000000003
        0000000000000006 0000000000000002 0000000000000000 0000000000000000
        0000000000000000 0000000000008000 0000000000000008 ffffffff881b1848
        ffffffff88090fc8 000000000000b0df 0000000000000006 0000000000000000
        0000000000000001 0000000000000003 0000000000000002 ffffffff8a6dfdc0
        ...
Call Trace:
 [<ffffffff88041ccc>] tasklet_action+0xc4/0x140
 [<ffffffff88041e0c>] __do_softirq+0xc4/0x1a0
 [<ffffffff88041f88>] do_softirq+0xa0/0xd0
 [<ffffffff88005ab8>] indyIRQ+0x118/0x180
 [<ffffffff881b1848>] memset_partial+0x44/0x60
 [<ffffffff88090fc8>] sys_read+0x0/0x90
 [<ffffffff88183c90>] avc_has_perm+0x68/0x98
 [<ffffffff88183f70>] inode_has_perm+0x50/0xb8
 [<ffffffff88041138>] getnstimeofday+0x18/0x50
 [<ffffffff88058cf8>] ktime_get_ts+0x60/0xb8
 [<ffffffff881840b8>] file_has_perm+0xe0/0x108
 [<ffffffff881ea24c>] i8042_interrupt+0x64/0x4e8
 [<ffffffff880902bc>] vfs_read+0xfc/0x1b8
 [<ffffffff88091014>] sys_read+0x4c/0x90
 [<ffffffff8801de8c>] handle_sys+0x12c/0x148


Code: 11000017  30d8003f  00000000 <dca80000> dca90008  dcaa0010  dcab0018  64c6ffc0  dcac0020 

-- 
Martin Michlmayr
http://www.cyrius.com/
