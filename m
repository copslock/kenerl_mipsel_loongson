Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2017 17:05:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20343 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993359AbdGTPFJAh9Gv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2017 17:05:09 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6F8C49445BBAF;
        Thu, 20 Jul 2017 16:04:59 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Jul 2017 16:05:02 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: PCI: Fix smp_processor_id() in preemptible
Date:   Thu, 20 Jul 2017 16:04:43 +0100
Message-ID: <1500563083-13420-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit 1c3c5eab1715 ("sched/core: Enable might_sleep() and
smp_processor_id() checks early") enables checks for might_sleep() and
smp_processor_id() being used in preemptible code earlier in the boot
than before. This results in a new BUG from
pcibios_set_cache_line_size().

BUG: using smp_processor_id() in preemptible [00000000] code:
swapper/0/1
caller is pcibios_set_cache_line_size+0x10/0x70
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc1-00007-g3ce3e4ba4275 #615
Stack : 0000000000000000 ffffffff81189694 0000000000000000 ffffffff81822318
        000000000000004e 0000000000000001 800000000e20bd08 20c49ba5e3540000
        0000000000000000 0000000000000000 ffffffff818d0000 0000000000000000
        0000000000000000 ffffffff81189328 ffffffff818ce692 0000000000000000
        0000000000000000 ffffffff81189bc8 ffffffff818d0000 0000000000000000
        ffffffff81828907 ffffffff81769970 800000020ec78d80 ffffffff818c7b48
        0000000000000001 0000000000000001 ffffffff818652b0 ffffffff81896268
        ffffffff818c0000 800000020ec7fb40 800000020ec7fc58 ffffffff81684cac
        0000000000000000 ffffffff8118ab50 0000000000000030 ffffffff81769970
        0000000000000001 ffffffff81122a58 0000000000000000 0000000000000000
        ...
Call Trace:
[<ffffffff81122a58>] show_stack+0x90/0xb0
[<ffffffff81684cac>] dump_stack+0xac/0xf0
[<ffffffff813f7050>] check_preemption_disabled+0x120/0x128
[<ffffffff818855e8>] pcibios_set_cache_line_size+0x10/0x70
[<ffffffff81100578>] do_one_initcall+0x48/0x140
[<ffffffff81865dc4>] kernel_init_freeable+0x194/0x24c
[<ffffffff8169c534>] kernel_init+0x14/0x118
[<ffffffff8111ca84>] ret_from_kernel_thread+0x14/0x1c

Fix this by using raw_current_cpu_data instead.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

In heteregenerous systems the more correct fix for this would be to
iterate over CPUs checking each ones cache hierarchy. However, as no
such systems currently exist that seems wasteful.

---
 arch/mips/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index bd67ac74fe2d..7ef8d97fa324 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -28,7 +28,7 @@ EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
 static int __init pcibios_set_cache_line_size(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpuinfo_mips *c = &raw_current_cpu_data;
 	unsigned int lsize;
 
 	/*
-- 
2.7.4
