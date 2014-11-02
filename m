Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 11:53:57 +0100 (CET)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:53088 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010609AbaKBKx4NP3is (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 11:53:56 +0100
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id Aatp1p0022Bo0NV01atpem; Sun, 02 Nov 2014 10:53:49 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-ch2-05v.sys.comcast.net with comcast
        id Aato1p0023aNLgd01atooy; Sun, 02 Nov 2014 10:53:49 +0000
Message-ID: <54560D3B.8060602@gentoo.org>
Date:   Sun, 02 Nov 2014 05:53:47 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1414925629;
        bh=2WqrMtwdJ33fD6V3SyeSWzhv4vfRunZCOW9AK/2Ar1s=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=mxzELVKtGXHOrbpNi7FNCDctJfCMnqL2QTq+5P4kPAQocR4gC2nCB/EE0/PLpqBjP
         11iq7K4Mlkhr93QZkVmalhpGQVsBu10KpFsrlrM/MWKWld8GLkj9XmUqOvaX4Q4Liu
         TGqC6DXMjtgwGBhw3Xik1LObIx36l75f7N6rkog1bEDvqGzaqQ7JCdfNLHl3MRGE7P
         1LUP/VSegDfByQkvTlJ/oPsDwfVbmAVVBMreSxMh45n4sX2GqxbdwN+8/0gdcK5X6h
         Jf5LWwkh+j5wSkeRJKqN0YqxihLk+eqfpWLCYa4V+c1enwvQHPtQkP/2emPH0FBuvH
         RFh1SeJL59t1g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


So I have been testing the Onyx2 I have out the last few days with the IOC3
metadriver used on Octane, and I can get it to boot, but if
CONFIG_TRANSPARENT_HUGEPAGE is enabled in the kernel, bus errors can happen.

If I use CONFIG_PAGE_SIZE_4KB, I get bus errors rather frequently -- running
Gentoo's 'emerge' command  can produce one.  Switch to CONFIG_PAGE_SIZE_16KB,
and the bus errors are far less frequent.  I suspect CONFIG_PAGE_SIZE_64KB will
be even less.

Disable CONFIG_TRANSPARENT_HUGEPAGE, and the machine works pretty good.  It's
been up for almost 8 hours compiling, and not a single bus error yet.  It's got
2x node board with dual R12K/400MHz CPUs per node.

I'm not really sure what CONFIG_TRANSPARENT_HUGEPAGE is enabling that's causing
R12K CPUs on the IP27 such a headache (and on Octane, really screws up R14K
CPUs).  I tried getting a core dump on one of the bus errors, but that produces a
truncated or corrupted core file that actually crashed GDB, plus I get a nice
oops message in dmesg:

[ 1302.260000] CPU: 0 PID: 1179 Comm: emerge Not tainted 3.17.1-mipsgit-20141006 #57
[ 1302.260000] task: a8000000ffbbf288 ti: a8000000fa6f0000 task.ti: a8000000fa6f0000
[ 1302.260000] $ 0   : 0000000000000000 0000000000000001 0000000000000000 a8000000ff5ad800
[ 1302.260000] $ 4   : a8000000006d5480 00000000000f9c00 00000001f380173f a800000001000000
[ 1302.260000] $ 8   : 00000001f380173f 0000000000100077 a8000000fe77a000 0000000000000000
[ 1302.260000] $12   : 0000000000660000 0000000000000000 0000000000000000 776bc40c00000004
[ 1302.260000] $16   : 0000000000e00000 0000000000000000 00000000018ee000 6db6db6db6db6db7
[ 1302.260000] $20   : 00000000000000ca a8000000006d5480 a8000000ff65fa68 0000000000001000
[ 1302.260000] $24   : 0000000000000000 a8000000000469c0
[ 1302.260000] $28   : a8000000fa6f0000 a8000000fa6f3a00 0000000000e00000 a800000000046720
[ 1302.260000] Hi    : 00000000002ed400
[ 1302.260000] Lo    : 00000000000f9c00
[ 1302.260000] epc   : a8000000000467e4 r4k_flush_cache_page+0x104/0x2e0
[ 1302.260000]     Not tainted
[ 1302.260000] ra    : a800000000046720 r4k_flush_cache_page+0x40/0x2e0
[ 1302.260000] Status: 90001ce3 KX SX UX KERNEL EXL IE
[ 1302.260000] Cause : 0000c010
[ 1302.260000] BadVA : 00000001f380173f
[ 1302.260000] PrId  : 00000e35 (R12000)
[ 1302.260000] Process emerge (pid: 1179, threadinfo=a8000000fa6f0000, task=a8000000ffbbf288, tls=00000000778d2490)
[ 1302.260000] Stack : a8000000ff65fa68 0000000000e00000 00000000000f9c00 a8000000006d5480
          a8000000ff65fa68 0000000000001000 0000000000e00000 a80000000010cb00
          a8000000046a2000 a8000000ff65fa68 00000000018ee000 6db6db6db6db6db7
          a8000000fe7fdce0 a8000000000375ec a8000000ff4e5800 a8000000005fbd90
          0000000300000080 a8000000ff668580 a8000000005fbd90 5349474900000080
          a8000000fa6f3ad8 a8000000005fbd90 0000000600000088 a8000000ff5ad928
          a8000000005fbd90 46494c4500002bf9 c000000000101000 0000000a00000080
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          ...
[ 1302.260000] Call Trace:
[ 1302.260000] [<a8000000000467e4>] r4k_flush_cache_page+0x104/0x2e0
[ 1302.260000] [<a80000000010cb00>] get_dump_page+0xc8/0xe8
[ 1302.260000] [<a8000000000375ec>] elf_core_dump+0x1294/0x14d8
[ 1302.260000] [<a8000000001b41e4>] do_coredump+0x5e4/0x1048
[ 1302.260000] [<a80000000005c0b8>] get_signal+0x1b8/0x710
[ 1302.260000] [<a8000000000299c0>] do_signal+0x18/0x240
[ 1302.260000] [<a80000000002a4c8>] do_notify_resume+0x70/0x88
[ 1302.260000] [<a8000000000255ac>] work_notifysig+0x10/0x18
[ 1302.260000]
[ 1302.260000]
Code: 0010327a  30c60ff8  00c8302d <dcc60000> 30c80001  1100003e  00000000  bfb40000  df880000
[ 1305.340000] ---[ end trace c7649a6433db8d18 ]---

Thoughts?


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
