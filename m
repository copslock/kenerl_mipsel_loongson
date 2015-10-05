Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 03:35:48 +0200 (CEST)
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:54104 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009480AbbJEBfqBFZY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 03:35:46 +0200
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-08v.sys.comcast.net with comcast
        id RDbc1r0085E3ZMc01DbcWb; Mon, 05 Oct 2015 01:35:36 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-18v.sys.comcast.net with comcast
        id RDbZ1r00E0w5D3801DbaDY; Mon, 05 Oct 2015 01:35:36 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: IP27: BUG() in __mm_populate+0x58
X-Enigmail-Draft-Status: N1110
To:     Linux/MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>
Message-ID: <5611D3E5.8080402@gentoo.org>
Date:   Sun, 4 Oct 2015 21:35:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1444008936;
        bh=ebLpYO60zUpv64TALhEYBkWpkPwvbFfV9o+RxE3TxAo=;
        h=Received:Received:From:Subject:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=AA82Zyy4ReVkRsRapCp4+VSi3NWp9QDRgO+cbfiQ+H9IAPNcQ2yMF3UGA+rF/wAgm
         +xoGMPuLziwvRHqrIndvOJ1p9FkdYELguRTIMmMWPcxC3JKUZ/Mti1b5tpAgfy5Xgf
         8eDEeetEbiN6Cz5G1g82yyv6fzERhNhjrOLXSq5BGUOHch8p4s7WcQ8v4tqNmrlKcL
         zJ7LsgJ3/5K0GxeWL9w3/VDFr/Tjo9vh6urvHvnVxcj8ircZi2XO8l+2Y00TYmqVN8
         UVd00iKGH+xT1G6cAXFOs4d89brrjneaTMUCszgfJPq/A4+fZZcIZeB73t6iTOGApE
         88Lk5hbTQw4cA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49418
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


Finally found a configuration that gets me some kind of crash output on IP27.
I have no idea if it's the source of the lockup bug I've described in the past,
but I've reproduced it twice in the exact same fashion (starting ntpd up on
boot) and same Oops message:

 * Starting ntpd ...
 [ ok ]
[   81.301036] Kernel bug detected[#1]:
[   81.344205] CPU: 1 PID: 1288 Comm: ntpd Not tainted
4.3.0-rc4-mipsgit-20151004 #5
[   81.434469] task: a8000000e675d0b8 ti: a8000000e7180000 task.ti:
a8000000e7180000
[   81.524637] $ 0   : 0000000000000000 ffffffff94001ce0 0000000000000001
ffffffffffff0000
[   81.621616] $ 4   : 0000000000000000 000000007fff8000 0000000000000001
0000000000024b80
[   81.718600] $ 8   : 0000000000000015 000fffffffffffff 00000000007c0000
0000000000fffffc
[   81.815583] $12   : 000000007fb00000 0000000000000000 0000000000000004
000000007fac0000
[   81.912566] $16   : 0000000000000000 0000000000001000 00000000100a0000
a8000000e6b16a80
[   82.009549] $20   : 00000000100970d0 00000000100a0000 0000000000000004
000000001007bf50
[   82.106533] $24   : 00000000fa83b2da a80000000008e740
[   82.203516] $28   : a8000000e7180000 a8000000e718fe20 0000000000000000
a80000000013a5f0
[   82.300501] Hi    : 0000000000000000
[   82.343549] Lo    : 025dbd0b00000000
[   82.386628] epc   : a8000000001306c0 __mm_populate+0x58/0x1b0
[   82.455944] ra    : a80000000013a5f0 SyS_mlockall+0x168/0x1d0
[   82.525154] Status: 94001ce3 KX SX UX KERNEL EXL IE
[   82.585695] Cause : 00008034 (ExcCode 0d)
[   82.633976] PrId  : 00000f14 (R14000)
[   82.678076] Process ntpd (pid: 1288, threadinfo=a8000000e7180000,
task=a8000000e675d0b8, tls=00000000775dde50)
[   82.798615] Stack : 00000000e6b16b18 a8000000000a3c9c ffffffff94001ce1
0000000000000000
          0000000000000000 0000000000000000 0000000000001000 00000000100a0000
          0000000000000000 00000000100970d0 00000000100a0000 0000000000000004
          000000001007bf50 a80000000013a5f0 00000000100e7180 0000000010090000
          0000000010010000 a800000000036754 0000000000000000 ffffffffb4001ce0
          0000000000001804 0000000000d7a592 0000000000000003 ffffffffffffffff
          fffffffffffffffe 0000000000000000 00000000107765a0 0000000000000000
          0000000000000001 a8000000e718fe50 0000000000000000 a8000000e6c5e9e0
          0000000000000080 0000000076860000 00000000107765c8 00000000775d69b0
          0000000000000000 00000000100e7180 00000000100a0000 0000000000000000
          ...
[   83.587576] Call Trace:
[   83.617016] [<a8000000001306c0>] __mm_populate+0x58/0x1b0
[   83.682062] [<a80000000013a5f0>] SyS_mlockall+0x168/0x1d0
[   83.747110] [<a800000000036754>] syscall_common+0x8/0x34
[   83.811182]
[   83.829091]
Code: 00431024  00451026  0002102b <00020336> 0085902d  0092102b  1040004f
0080b82d  0000102d
[   83.949931] ---[ end trace c0520c07116dba81 ]---
[   84.005644] Fatal exception: panic in 5 seconds * Starting sshd ...
[   89.060320] Kernel panic - not syncing: Fatal exception
[   89.125510] ---[ end Kernel panic - not syncing: Fatal exception

GDB traces it into the actual __BUG_ON() definition in
arch/mips/include/asm/bug.h, line 29, but looking at __mm_populate itself,
there's these two VM_BUG_ON() calls:

VM_BUG_ON(start & ~PAGE_MASK);
VM_BUG_ON(len != PAGE_ALIGN(len));

I'm not sure which one is triggering here.  Kinda suspecting the second one,
because that seems to  go with what I've seen in the past.  There's something
off about IP27's memory management in recent kernels, though.

Seems to only happen with PAGE_SIZE_64K is set.  16K and 4K boot normally, but
will eventually lock up later on.

Thoughts?

--J
