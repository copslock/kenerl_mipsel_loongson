Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 23:08:54 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.8]:48576 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491096Ab1FIVIv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 23:08:51 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p59L8NG4031590;
        Thu, 9 Jun 2011 16:08:39 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.92) with Microsoft SMTP Server id
 8.3.137.0; Thu, 9 Jun 2011 17:08:34 -0400
Subject: Linux 2.6.39 on Cavium CN38xx
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     linux-mips@linux-mips.org
CC:     David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Thu, 9 Jun 2011 14:08:34 -0700
Message-ID: <1307653714.8271.130.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 30310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8505

Hi folks,

I am trying to get Linux 2.6.39 to run on a board with Cavium CN38xx
(pass 3, cpu ID 0x000d0003).

Problem I have is that CPUs 1..15 come online, but get stuck in and
endless interrupt handling loop as soon as interrupts are enabled. I
attached a log generated with instrumentation code in the interrupt
handler.

Any idea what I might be doing wrong ? Note that I don't start the
system from u-boot; the board uses OFW, so some register initialization
may be wrong.

I did see commit dbb103b243e09475c84df2b8ef17615975593761, but I have no
idea if my problem may be related.

Thanks,
Guenter

------------------------------

SMP: Booting CPU09 (CoreId  9)...
Core 9 ALIVE
 --- waiting for CPU 9
CPU revision is: 000d0003 (Cavium Octeon)
 --- ### CPU 9 SR=0x100000e0
 ---- set CPU 9 (9) callin map bit
 ---- CPU 9 (9) call cpu_idle
CPU 9: IRQ cause 0x0 status 0:0:0:0:0:0
Cpu 9
$ 0   : 0000000000000000 000000001000efe1 ffffffff81582db8
00000000000001ff
$ 4   : 0000000000000009 0000000000000009 0000000000000048
0000000000000000
$ 8   : 0000000000000000 0000000000000008 0000000000000000
0000000000000000
$12   : 0000000000000000 ffffffff812b69bc ffffffff8140aed0
ffffffffbfc02334
$16   : ffffffff81582db8 0000000000000009 ffffffff815f07b0
ffffffff81582db8
$20   : ffffffff815e38d0 ffffffff815830f0 ffffffff815de600
ffffffff81420000
$24   : 0000000000000001
ffffffff8110e870                                  
$28   : a80000041fe20000 a80000041fe23bf0 0000000000000003
ffffffff8110a60c
Hi    : 000000000b71b000
Lo    : 000000000a037a00
epc   : ffffffff8140d8e4 schedule+0xdc/0xde8
    Not tainted
ra    : ffffffff8110a60c cpu_idle+0x2fc/0x350
Status: 1000efe3    KX SX UX KERNEL EXL IE 
Cause : 40800000
PrId  : 000d0003 (Cavium Octeon)
Call Trace:
[<ffffffff8140d18c>] dump_stack+0x8/0x34
[<ffffffff81100fbc>] plat_irq_dispatch+0x2bc/0x2c8
[<ffffffff81107ea8>] ret_from_irq+0x0/0x4
[<ffffffff8140d8e4>] schedule+0xdc/0xde8
[<ffffffff8110a60c>] cpu_idle+0x2fc/0x350

---

2nd and subsequent interrupts:

CPU 9: IRQ cause 0x0 status 0:0:0:0:0:0
Call Trace:
[<ffffffff8140d18c>] dump_stack+0x8/0x34
[<ffffffff81100ec4>] plat_irq_dispatch+0x1c4/0x2c8
[<ffffffff81107ea8>] ret_from_irq+0x0/0x4
[<ffffffff8140d8e4>] schedule+0xdc/0xde8
[<ffffffff8110a60c>] cpu_idle+0x2fc/0x350
