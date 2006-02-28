Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 11:34:18 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:22288 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133541AbWB1LeJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 11:34:09 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 667B164D3D; Tue, 28 Feb 2006 11:41:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7945781F5; Tue, 28 Feb 2006 12:41:37 +0100 (CET)
Date:	Tue, 28 Feb 2006 11:41:37 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Non-fatal oops on SGI IP22 when doing: md5sum /dev/mem
Message-ID: <20060228114137.GA3087@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following non-fatal oops on SGI IP22 (2.6.16-rc5) when
running "md5sum /dev/mem".  I know it's not very smart to run this
command but nevertheless we shouldn't oops.  FWIW, i386 reports
"md5sum: /dev/mem: Bad address".


sgi:/# md5sum /dev/mem
Segmentation fault

MC Bus Error
GIO error 0x400:<TIME > @ 0x00090000
Data bus error, epc == ffffffff881b0cf0, ra == ffffffff881c9ab4
Oops[#8]:
Cpu 0
$ 0   : 0000000000000000 0000000000000004 ffffffff80090000 0000000000000000
$ 4   : 00000000100023a8 ffffffff80090000 0000000000001000 ffffffff8a6dfe88
$ 8   : 0000000000000040 0000000000000000 0000000000000000 0000000000008000
$12   : 0000000000000008 0000000000008000 0000000000001000 ffffffffb0000000
$16   : 0000000000000000 00000000100033a8 ffffffff80000000 ffffffff8a6dfe88
$20   : 0000000000008000 ffffffffffffffff 000000007fcf29a8 00000000100022e8
$24   : 0000000000000000 0000000000090000                                  
$28   : ffffffff8a6dc000 ffffffff8a6dfe30 0000000000008000 ffffffff881c9ab4
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff881b0cf0 both_aligned+0x10/0x64     Not tainted
ra    : ffffffff881c9ab4 read_mem+0xec/0x138
Status: 3004cce3    KX SX UX KERNEL EXL IE 
Cause : 1000401c
PrId  : 00000460
Modules linked in: md5 ipv6
Process md5sum (pid: 1211, threadinfo=ffffffff8a6dc000, task=ffffffff8c0e0128)
Stack : ffffffff8c1c5aa0 0000000000000000 00000000100023a8 ffffffff880902bc
        fffffffffffffff7 00000000100023a8 ffffffff8c1c5aa0 00000000100022e8
        ffffffffffffffff ffffffff88091014 0000000000000000 0000000000090000
        0000000000000000 0000000000008000 000000007fcf2998 ffffffff8801de8c
        0000000000000000 0000000000000004 0000000000000fa3 0000000000008000
        0000000000000003 00000000100023a8 0000000000008000 0000000000000000
        0000000000000000 ffffffffb0000000 0000000000000000 ffffffffffffff0f
        0000000000000000 0000000000000000 0000000000000000 ffffffffff000000
        0000000000000000 0000000000000000 0000000000000000 ffffffffb0000000
        0000000000000000 0000000000000000 000000006f857da9 ffffffffa9c7a710
        ...
Call Trace:
 [<ffffffff880902bc>] vfs_read+0xfc/0x1b8
 [<ffffffff88091014>] sys_read+0x4c/0x90
 [<ffffffff8801de8c>] handle_sys+0x12c/0x148


Code: 11000017  30d8003f  00000000 <dca80000> dca90008  dcaa0010  dcab0018  64c6ffc0  dcac0020 

-- 
Martin Michlmayr
http://www.cyrius.com/
