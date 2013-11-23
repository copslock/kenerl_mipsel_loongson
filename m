Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Nov 2013 20:53:49 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48389 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816671Ab3KWTxrDhOjg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Nov 2013 20:53:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4899856FDC6;
        Sat, 23 Nov 2013 21:53:45 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id QuaYfBKqhiwg; Sat, 23 Nov 2013 21:53:40 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with SMTP id BBDA75BC008;
        Sat, 23 Nov 2013 21:53:39 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sat, 23 Nov 2013 21:53:39 +0200
Date:   Sat, 23 Nov 2013 21:53:39 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: 3.13-rc1 regression: Loongson2 broken
Message-ID: <20131123195339.GA6755@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

It seems commit 14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson:
Get rid of Loongson 2 #ifdefery all over arch/mips.) broke booting with
loongson2 boards. The boot hangs early, and I bisected the cause to
this commit.

When I tried to review the commit I spotted at least one error. In
local_r4k_flush_icache_range the loongsong path is executed when CPU !=
loongson. Here's a fix:

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 62ffd20..1c2029d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -580,11 +580,11 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
        else {
                switch (boot_cpu_type()) {
                case CPU_LOONGSON2:
-                       protected_blast_icache_range(start, end);
+                       protected_loongson23_blast_icache_range(start, end);
                        break;
 
                default:
-                       protected_loongson23_blast_icache_range(start, end);
+                       protected_blast_icache_range(start, end);
                        break;
                }
        }

But this gets the boot only a little futher, it still crashes when
userspace is started:

[    3.640000] epc   : ffffffff80222628 blast_icache32_page+0x8/0xb0
[    3.640000]     Not tainted
[    3.640000] ra    : ffffffff80222eac r4k_flush_cache_page+0x1b4/0x218
[    3.640000] Status: 300044e3 KX SX UX KERNEL EXL IE
[    3.640000] Cause : 10008028
[    3.640000] PrId  : 00006303 (ICT Loongson-2)
[    3.640000] Modules linked in:
[    3.640000] Process earlyboot.sh (pid: 1, threadinfo=980000009f058000, task=980000009f078000, tls=0000000077ada4d0)
[    3.640000] Stack : 980000009f2a01f8 980000000110e888 980000009f2d8a50 ffffffff802d3d5c
          980000009f2e18c0 980000009f4201f8 980000009f2d8a50 980000009f2e18c0
          000000007fc4c000 980000009f2a01f8 000000007fc70184 980000009f2a01f8
          0000000000000001 980000009f2d8a50 ffffffff810dee60 00000000000000a9
          980000009f3eb8e0 980000009f2d8a50 980000009f2e0dc0 ffffffff802d7718
          0000000200000000 0000000000000000 980000009f2e18c0 980000009f2e1930
          000000007fc70184 00000000000000a9 980000009f2e0dc0 980000009f078000
          0000000000000001 980000009f2e0e18 0000000000030002 980000009f2d8a50
          980000009f05beb0 ffffffff8021bf70 980000009f2d8a50 980000009f2e18c0
          000000007fc74000 980000009f2a01f8 000000007fc74000 ffffffff802d6498
          ...
[    3.640000] Call Trace:
[    3.640000] [<ffffffff80222628>] blast_icache32_page+0x8/0xb0
[    3.640000] [<ffffffff80222eac>] r4k_flush_cache_page+0x1b4/0x218
[    3.640000] [<ffffffff802d3d5c>] do_wp_page.isra.91+0x4ac/0xe78
[    3.640000] [<ffffffff802d7718>] handle_mm_fault+0x940/0x1150
[    3.640000] [<ffffffff8021bf70>] __do_page_fault+0x130/0x530
[    3.640000] [<ffffffff80206be4>] resume_userspace_check+0x0/0x10
[    3.640000]
[    3.640000] Code: 00200825  64834000  00200825 <bc900000> bc900020  bc900040  bc900060  bc900080  bc9000a0
[    3.644000] ---[ end trace f2d7d9a849eaee3a ]---

So, I would recommend reverting this patch completely from 3.13. It
seems to revert cleanly and after that the board boots fine.

A.
