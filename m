Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 20:54:47 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43859 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041689AbcFJSyp7gH5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2016 20:54:45 +0200
To:     linux-mips@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Felix Fietkau <nbd@nbd.name>
Subject: SMP regression on MIPS 34Kc (Lantiq VRX220)
Message-ID: <7f6f4ddd-5cac-520e-2e14-1fe0d7288e6f@nbd.name>
Date:   Fri, 10 Jun 2016 20:54:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

commit cccf34e9411c41b0cbfb41980fe55fc8e7c98fd2
MIPS: c-r4k: Fix cache flushing for MT cores

This commit breaks SMP on Lantiq VRX220. When r4k_on_each_cpu is called
for a cache flush, I get the following oops very early when user space 
starts:

[    1.689913] CPU 0 Unable to handle kernel paging request at virtual address fffd7000, epc == 80028fd4, ra == 80096240
[    1.699095] Oops[#1]:
[    1.701365] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.12 #2
[    1.707280] task: 805278d8 ti: 80518000 task.ti: 80518000
[    1.712663] $ 0   : 00000000 00000003 80530000 fffd8000
[    1.717884] $ 4   : fffd7000 00000000 00000001 00000000
[    1.723105] $ 8   : 1100ff00 1000001f 00000000 00000001
[    1.728328] $12   : eac0c6e6 00000000 00000000 7748c2b0
[    1.733551] $16   : 82e6bdb0 00000000 80029a14 fffd7000
[    1.738773] $20   : 80499e0c 8051a140 80498424 80520000
[    1.743995] $24   : 00000000 80028fc0                  
[    1.749217] $28   : 80518000 80519d08 80520000 80096240
[    1.754441] Hi    : 013b114e
[    1.757316] Lo    : 6eff374b
[    1.760209] epc   : 80028fd4 r4k_blast_dcache_page_dc32+0x14/0xb8
[    1.766299] ra    : 80096240 generic_smp_call_function_single_interrupt+0x160/0x200
[    1.773941] Status: 1100fd02 KERNEL EXL 
[    1.777858] Cause : 00800008 (ExcCode 02)
[    1.781862] BadVA : fffd7000
[    1.784734] PrId  : 00019556 (MIPS 34Kc)
[    1.788648] Modules linked in:
[    1.791706] Process swapper/0 (pid: 0, threadinfo=80518000, task=805278d8, tls=00000000)
[    1.799789] Stack : 00000001 8007d3f4 00000000 80520000 80528cc0 80530620 00000000 00000000
         00000001 8000e4f0 00010000 80a922a4 00000001 80520000 00000001 80071ad4
         80490000 80071c64 00000024 00000100 8051a040 8051a068 8049844c 80498460
         8051a140 80530620 8052470c 80a922a4 00000001 80520000 00000001 80520000
         80490000 80076214 804965b0 fffedc9a 80520000 00200000 00000000 00000001
         ...
[    1.835300] Call Trace:
[    1.837757] [<80028fd4>] r4k_blast_dcache_page_dc32+0x14/0xb8
[    1.843506] [<80096240>] generic_smp_call_function_single_interrupt+0x160/0x200
[    1.850834] [<8000e4f0>] ipi_call_interrupt+0x10/0x20
[    1.855874] [<80071ad4>] handle_irq_event_percpu+0x78/0x1b4
[    1.861445] [<80076214>] handle_percpu_irq+0x88/0xb8
[    1.866397] [<800711a0>] generic_handle_irq+0x40/0x58
[    1.871445] [<80015528>] do_IRQ+0x1c/0x2c
[    1.875447] [<80002430>] ret_from_irq+0x0/0x4
[    1.879796] [<80015494>] r4k_wait_irqoff+0x18/0x20
[    1.884606] [<80069464>] cpu_startup_entry+0x164/0x1c4
[    1.889740] [<80542c28>] start_kernel+0x4a4/0x4c4
[    1.894416] 
[    1.895878] 
Code: 00002821  10000026  8c46ab2c <bc950000> bc950020  bc950040  bc950060  bc950080  bc9500a0 
[    1.905894] ---[ end trace e17f61a2b2391e19 ]---

If I add a #ifndef CONFIG_MIPS_MT_SMP around the smp_call_function_many call,
everything works fine again. From what I can tell, we should not do any IPIs
for cache flushing on that device, since there are only two threads on the
same core.

- Felix
