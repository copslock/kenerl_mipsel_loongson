Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 22:02:52 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:36426 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009397AbbAOVCsoA4By (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 22:02:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4BC4556F4F5;
        Thu, 15 Jan 2015 23:02:47 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id B5M1Le+yl32t; Thu, 15 Jan 2015 23:02:43 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 118935BC016;
        Thu, 15 Jan 2015 23:02:43 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/2] MIPS: OCTEON: fix kernel crash when offlining a CPU
Date:   Thu, 15 Jan 2015 23:01:58 +0200
Message-Id: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45139
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

octeon_cpu_disable() will unconditionally enable interrupts when called.
We can assume that the routine is always called with interrupts disabled,
so just delete the incorrect local_irq_disable/enable().

The patch fixes the following crash when offlining a CPU:

[   93.818785] ------------[ cut here ]------------
[   93.823421] WARNING: CPU: 1 PID: 10 at kernel/smp.c:231 flush_smp_call_function_queue+0x1c4/0x1d0()
[   93.836215] Modules linked in:
[   93.839287] CPU: 1 PID: 10 Comm: migration/1 Not tainted 3.19.0-rc4-octeon-los_b5f0 #1
[   93.847212] Stack : 0000000000000001 ffffffff81b2cf90 0000000000000004 ffffffff81630000
	  0000000000000000 0000000000000000 0000000000000000 000000000000004a
	  0000000000000006 ffffffff8117e550 0000000000000000 0000000000000000
	  ffffffff81b30000 ffffffff81b26808 8000000032c77748 ffffffff81627e07
	  ffffffff81595ec8 ffffffff81b26808 000000000000000a 0000000000000001
	  0000000000000001 0000000000000003 0000000010008ce1 ffffffff815030c8
	  8000000032cbbb38 ffffffff8113d42c 0000000010008ce1 ffffffff8117f36c
	  8000000032c77300 8000000032cbba50 0000000000000001 ffffffff81503984
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 ffffffff81121668 0000000000000000 0000000000000000
	  ...
[   93.912819] Call Trace:
[   93.915273] [<ffffffff81121668>] show_stack+0x68/0x80
[   93.920335] [<ffffffff81503984>] dump_stack+0x6c/0x90
[   93.925395] [<ffffffff8113d58c>] warn_slowpath_common+0x94/0xd8
[   93.931324] [<ffffffff811a402c>] flush_smp_call_function_queue+0x1c4/0x1d0
[   93.938208] [<ffffffff811a4128>] hotplug_cfd+0xf0/0x108
[   93.943444] [<ffffffff8115bacc>] notifier_call_chain+0x5c/0xb8
[   93.949286] [<ffffffff8113d704>] cpu_notify+0x24/0x60
[   93.954348] [<ffffffff81501738>] take_cpu_down+0x38/0x58
[   93.959670] [<ffffffff811b343c>] multi_cpu_stop+0x154/0x180
[   93.965250] [<ffffffff811b3768>] cpu_stopper_thread+0xd8/0x160
[   93.971093] [<ffffffff8115ea4c>] smpboot_thread_fn+0x1ec/0x1f8
[   93.976936] [<ffffffff8115ab04>] kthread+0xd4/0xf0
[   93.981735] [<ffffffff8111c4f0>] ret_from_kernel_thread+0x14/0x1c
[   93.987835]
[   93.989326] ---[ end trace c9e3815ee655bda9 ]---
[   93.993951] Kernel bug detected[#1]:
[   93.997533] CPU: 1 PID: 10 Comm: migration/1 Tainted: G        W      3.19.0-rc4-octeon-los_b5f0 #1
[   94.006591] task: 8000000032c77300 ti: 8000000032cb8000 task.ti: 8000000032cb8000
[   94.014081] $ 0   : 0000000000000000 0000000010000ce1 0000000000000001 ffffffff81620000
[   94.022146] $ 4   : 8000000002c72ac0 0000000000000000 00000000000001a7 ffffffff813b06f0
[   94.030210] $ 8   : ffffffff813b20d8 0000000000000000 0000000000000000 ffffffff81630000
[   94.038275] $12   : 0000000000000087 0000000000000000 0000000000000086 0000000000000000
[   94.046339] $16   : ffffffff81623168 0000000000000001 0000000000000000 0000000000000008
[   94.054405] $20   : 0000000000000001 0000000000000001 0000000000000001 0000000000000003
[   94.062470] $24   : 0000000000000038 ffffffff813b7f10
[   94.070536] $28   : 8000000032cb8000 8000000032cbbc20 0000000010008ce1 ffffffff811bcaf4
[   94.078601] Hi    : 0000000000f188e8
[   94.082179] Lo    : d4fdf3b646c09d55
[   94.085760] epc   : ffffffff811bc9d0 irq_work_run_list+0x8/0xf8
[   94.091686]     Tainted: G        W
[   94.095613] ra    : ffffffff811bcaf4 irq_work_run+0x34/0x60
[   94.101192] Status: 10000ce3	KX SX UX KERNEL EXL IE
[   94.106235] Cause : 40808034
[   94.109119] PrId  : 000d9301 (Cavium Octeon II)
[   94.113653] Modules linked in:
[   94.116721] Process migration/1 (pid: 10, threadinfo=8000000032cb8000, task=8000000032c77300, tls=0000000000000000)
[   94.127168] Stack : 8000000002c74c80 ffffffff811a4128 0000000000000001 ffffffff81635720
	  fffffffffffffff2 ffffffff8115bacc 80000000320fbce0 80000000320fbca4
	  80000000320fbc80 0000000000000002 0000000000000004 ffffffff8113d704
	  80000000320fbce0 ffffffff81501738 0000000000000003 ffffffff811b343c
	  8000000002c72aa0 8000000002c72aa8 ffffffff8159cae8 ffffffff8159caa0
	  ffffffff81650000 80000000320fbbf0 80000000320fbc80 ffffffff811b32e8
	  0000000000000000 ffffffff811b3768 ffffffff81622b80 ffffffff815148a8
	  8000000032c77300 8000000002c73e80 ffffffff815148a8 8000000032c77300
	  ffffffff81622b80 ffffffff815148a8 8000000032c77300 ffffffff81503f48
	  ffffffff8115ea0c ffffffff81620000 0000000000000000 ffffffff81174d64
	  ...
[   94.192771] Call Trace:
[   94.195222] [<ffffffff811bc9d0>] irq_work_run_list+0x8/0xf8
[   94.200802] [<ffffffff811bcaf4>] irq_work_run+0x34/0x60
[   94.206036] [<ffffffff811a4128>] hotplug_cfd+0xf0/0x108
[   94.211269] [<ffffffff8115bacc>] notifier_call_chain+0x5c/0xb8
[   94.217111] [<ffffffff8113d704>] cpu_notify+0x24/0x60
[   94.222171] [<ffffffff81501738>] take_cpu_down+0x38/0x58
[   94.227491] [<ffffffff811b343c>] multi_cpu_stop+0x154/0x180
[   94.233072] [<ffffffff811b3768>] cpu_stopper_thread+0xd8/0x160
[   94.238914] [<ffffffff8115ea4c>] smpboot_thread_fn+0x1ec/0x1f8
[   94.244757] [<ffffffff8115ab04>] kthread+0xd4/0xf0
[   94.249555] [<ffffffff8111c4f0>] ret_from_kernel_thread+0x14/0x1c
[   94.255654]
[   94.257146]
Code: a2423c40  40026000  30420001 <00020336> dc820000  10400037  00000000  0000010f  0000010f
[   94.267183] ---[ end trace c9e3815ee655bdaa ]---
[   94.271804] Fatal exception: panic in 5 seconds

Reported-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: David Daney <david.daney@cavium.com>
Cc: stable@vger.kernel.org # v3.18+
---

	v2: Remove local_irq_disable/local_irq_enable altogether, instead of
            saving and restoring the old context.

        v1: http://marc.info/?l=linux-mips&m=142134781818170&w=2

 arch/mips/cavium-octeon/smp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index ecd903d..8b1eeff 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -240,9 +240,7 @@ static int octeon_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	cpu_clear(cpu, cpu_callin_map);
-	local_irq_disable();
 	octeon_fixup_irqs();
-	local_irq_enable();
 
 	flush_cache_all();
 	local_flush_tlb_all();
-- 
2.2.0
