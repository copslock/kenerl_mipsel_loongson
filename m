Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Nov 2013 12:05:29 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:60170 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815746Ab3KXLF1SHjZO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Nov 2013 12:05:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id E93D021B8D1;
        Sun, 24 Nov 2013 13:05:24 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id uJk7JKF+SSpm; Sun, 24 Nov 2013 13:05:20 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with SMTP id F25985BC006;
        Sun, 24 Nov 2013 13:05:18 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 24 Nov 2013 13:05:18 +0200
Date:   Sun, 24 Nov 2013 13:05:18 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Ungerer <gerg@snapgear.com>,
        Ashok Kumar <ashoks@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: 3.13-rc1 regression: initrd/cramfs broken
Message-ID: <20131124110518.GA24645@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38574
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

With 3.13-rc1 the boot hangs early when initrd/cramfs is used. I bisected
this to commit f9a7febd82f413b9c8bafd40145bc398b7eb619f (MIPS: Fix start
of free memory when using initrd).

I'm loading cramfs initrd on my WRT54GL router (16 MB memory) to
0x80400000. The kernel command line is:
console=ttyS0,115200 rd_start=0x80400000 rd_size=5181440 root=/dev/ram init=/init

With 3.13-rc1 it hangs with below output. With the above commit reverted,
the board boots fine.

Starting program at 0x80231cb0
[    0.000000] Linux version 3.13.0-rc1-wrt54gl-los.git-6e483b8-dirty (aaro@blackmetal) (gcc version 4.8.2 (GCC) ) #13 Sun Nov 24 12:54:47 EET 2013
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00029008 (Broadcom BMIPS3300)
[    0.000000] bcm47xx: using ssb bus
[    0.000000] ssb: Found chip with id 0x5352, rev 0x00 and package 0x02
[    0.000000] ssb: Sonics Silicon Backplane found at address 0x18000000
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 01000000 @ 00000000 (usable)
[    0.000000] Initial ramdisk at: 0x80400000 (5181440 bytes)
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x00ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x00ffffff]
[    0.000000] Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
[    0.000000] Primary data cache 8kB, 2-way, VIPT, no aliases, linesize 16 bytes

A.
