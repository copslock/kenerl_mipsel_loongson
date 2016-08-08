Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 21:21:37 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992507AbcHHTV27Ai0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 21:21:28 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 351A182B;
        Mon,  8 Aug 2016 19:21:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Qais Yousef <qsyousef@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.6 79/96] irqchip/mips-gic: Match IPI IRQ domain by bus token only
Date:   Mon,  8 Aug 2016 21:11:42 +0200
Message-Id: <20160808180247.364329169@linuxfoundation.org>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160808180243.898163389@linuxfoundation.org>
References: <20160808180243.898163389@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 547aefc4db877e65245c3d95fcce703701bf3a0c upstream.

Commit fbde2d7d8290 ("MIPS: Add generic SMP IPI support") introduced
code which calls irq_find_matching_host with a NULL node parameter in
order to discover IPI IRQ domains which are not associated with the DT
root node's interrupt parent. This suggests that implementations of IPI
IRQ domains should effectively ignore the node parameter if it is NULL
and search purely based upon the bus token. Commit 2af70a962070
("irqchip/mips-gic: Add a IPI hierarchy domain") did not do this when
implementing the GIC IPI IRQ domain, and on MIPS Boston boards this
leads to no IPI domain being discovered and a NULL pointer dereference
when attempting to send an IPI:

  CPU 0 Unable to handle kernel paging request at virtual address 0000000000000040, epc == ffffffff8016e70c, ra == ffffffff8010ff5c
  Oops[#1]:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc6-00223-gad0d1b6 #945
  task: a8000000ff066fc0 ti: a8000000ff068000 task.ti: a8000000ff068000
  $ 0   : 0000000000000000 0000000000000001 ffffffff80730000 0000000000000003
  $ 4   : 0000000000000000 ffffffff8057e5b0 a800000001e3ee00 0000000000000000
  $ 8   : 0000000000000000 0000000000000023 0000000000000001 0000000000000001
  $12   : 0000000000000000 ffffffff803323d0 0000000000000000 0000000000000000
  $16   : 0000000000000000 0000000000000000 0000000000000001 ffffffff801108fc
  $20   : 0000000000000000 ffffffff8057e5b0 0000000000000001 0000000000000000
  $24   : 0000000000000000 ffffffff8012de28
  $28   : a8000000ff068000 a8000000ff06fbc0 0000000000000000 ffffffff8010ff5c
  Hi    : ffffffff8014c174
  Lo    : a800000001e1e140
  epc   : ffffffff8016e70c __ipi_send_mask+0x24/0x11c
  ra    : ffffffff8010ff5c mips_smp_send_ipi_mask+0x68/0x178
  Status: 140084e2        KX SX UX KERNEL EXL
  Cause : 00800008 (ExcCode 02)
  BadVA : 0000000000000040
  PrId  : 0001a920 (MIPS I6400)
  Process swapper/0 (pid: 1, threadinfo=a8000000ff068000, task=a8000000ff066fc0, tls=0000000000000000)
  Stack : 0000000000000000 0000000000000000 0000000000000001 ffffffff801108fc
            0000000000000000 ffffffff8057e5b0 0000000000000001 ffffffff8010ff5c
            0000000000000001 0000000000000020 0000000000000000 0000000000000000
            0000000000000000 ffffffff801108fc 0000000000000000 0000000000000001
            0000000000000001 0000000000000000 0000000000000000 ffffffff801865e8
            a8000000ff0c7500 a8000000ff06fc90 0000000000000001 0000000000000002
            ffffffff801108fc ffffffff801868b8 0000000000000000 ffffffff801108fc
            0000000000000000 0000000000000003 ffffffff8068c700 0000000000000001
            ffffffff80730000 0000000000000001 a8000000ff00a290 ffffffff80110c50
            0000000000000003 a800000001e48308 0000000000000003 0000000000000008
            ...
  Call Trace:
  [<ffffffff8016e70c>] __ipi_send_mask+0x24/0x11c
  [<ffffffff8010ff5c>] mips_smp_send_ipi_mask+0x68/0x178
  [<ffffffff801865e8>] generic_exec_single+0x150/0x170
  [<ffffffff801868b8>] smp_call_function_single+0x108/0x160
  [<ffffffff80110c50>] cps_boot_secondary+0x328/0x394
  [<ffffffff80110534>] __cpu_up+0x38/0x90
  [<ffffffff8012de4c>] bringup_cpu+0x24/0xac
  [<ffffffff8012df40>] cpuhp_up_callbacks+0x58/0xdc
  [<ffffffff8012e648>] cpu_up+0x118/0x18c
  [<ffffffff806dc158>] smp_init+0xbc/0xe8
  [<ffffffff806d4c18>] kernel_init_freeable+0xa0/0x228
  [<ffffffff8056c908>] kernel_init+0x10/0xf0
  [<ffffffff80105098>] ret_from_kernel_thread+0x14/0x1c

Fix this by allowing the GIC IPI IRQ domain to match purely based upon
the bus token if the node provided is NULL.

Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20160705132600.27730-2-paul.burton@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -947,7 +947,7 @@ int gic_ipi_domain_match(struct irq_doma
 	switch (bus_token) {
 	case DOMAIN_BUS_IPI:
 		is_ipi = d->bus_token == bus_token;
-		return to_of_node(d->fwnode) == node && is_ipi;
+		return (!node || to_of_node(d->fwnode) == node) && is_ipi;
 		break;
 	default:
 		return 0;
