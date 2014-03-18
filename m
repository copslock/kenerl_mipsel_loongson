Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 05:48:44 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:47182 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816906AbaCREsktxg3r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 05:48:40 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s2I4mCbT006071
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 17 Mar 2014 21:48:12 -0700 (PDT)
Received: from pek-wyang1-d1.wrs.com (128.224.162.170) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.169.1; Mon, 17 Mar 2014 21:48:11 -0700
From:   <Wei.Yang@windriver.com>
To:     <wei.yang@windriver.com>, <david.daney@cavium.com>,
        <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH V2] mips/octeon_3xxx: Fix a warning on octeon_3xxx
Date:   Tue, 18 Mar 2014 12:48:04 +0800
Message-ID: <1395118084-24018-1-git-send-email-Wei.Yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Wei.Yang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wei.Yang@windriver.com
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

From: Yang Wei <Wei.Yang@windriver.com>

Since the xlate of interrupts property of GPIO on octeon 3xxx
does not success, so the following warning would be triggerred.

WARNING: CPU: 1 PID: 1 at drivers/of/platform.c:173 of_device_alloc+0x294/0x2a0()
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc6- #11
Stack : ffffffff81a20000 0000000000000001 0000000000000004 ffffffff81b50000
      0000000000000001 0000000000000000 0000000000000000 ffffffff8119e878
      ffffffff81a20000 ffffffff8119ee98 0000000000000000 0000000000000000
      ffffffff81b30000 ffffffff81b20000 ffffffff81932900 ffffffff81a11077
      ffffffff81b27a08 800000041f8704a8 0000000000000001 0000000000000001
      0000000000000000 800000041fbf7438 0000000000000001 ffffffff81800d90
      800000041f85fa68 ffffffff8114a60c 0000000000000000 ffffffff811a0838
      800000041f870000 800000041f85f980 0000000000000001 ffffffff81805080
      0000000000000000 0000000000000000 0000000000000000 0000000000000000
      0000000000000000 ffffffff81122620 0000000000000000 0000000000000000
      ...
Call Trace:
[<ffffffff81122620>] show_stack+0xc0/0xe0
[<ffffffff81805080>] dump_stack+0x8c/0xe0
[<ffffffff8114a7ac>] warn_slowpath_common+0x94/0xc8
[<ffffffff81693b1c>] of_device_alloc+0x294/0x2a0
[<ffffffff81693b74>] of_platform_device_create_pdata+0x4c/0xf0
[<ffffffff81693d58>] of_platform_bus_create+0x128/0x1a8
[<ffffffff81693da0>] of_platform_bus_create+0x170/0x1a8
[<ffffffff81693e8c>] of_platform_bus_probe+0xb4/0x110
[<ffffffff81100598>] do_one_initcall+0xe8/0x130
[<ffffffff81a92c5c>] kernel_init_freeable+0x1d4/0x2bc
[<ffffffff817fe140>] kernel_init+0x20/0x118
[<ffffffff8111d024>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Yang Wei <Wei.Yang@windriver.com> 
---

Changes:
 
In v2:
Hi David,

According to your suggestion, I modify octeon-irq.c so that it doesn't try to reserve these numbers to fix this issue in v2.
How about is it?:-)

Thanks
Wei


 arch/mips/cavium-octeon/octeon-irq.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 25fbfae..31c76b1 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -975,10 +975,6 @@ static int octeon_irq_ciu_xlat(struct irq_domain *d,
 	if (ciu > 1 || bit > 63)
 		return -EINVAL;
 
-	/* These are the GPIO lines */
-	if (ciu == 0 && bit >= 16 && bit < 32)
-		return -EINVAL;
-
 	*out_hwirq = (ciu << 6) | bit;
 	*out_type = 0;
 
@@ -1010,6 +1006,13 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
 	if (line > 1 || octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
+	/*
+	 * If the irq is reserved for GPIO, we set virq to 0 so
+	 * that GPIO would be able to map it.
+	 */
+	if (line == 0 && bit >= 16 && bit <32)
+		virq = 0;
+
 	if (octeon_irq_ciu_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
 					   octeon_irq_ciu_chip,
@@ -1525,10 +1528,6 @@ static int octeon_irq_ciu2_xlat(struct irq_domain *d,
 	ciu = intspec[0];
 	bit = intspec[1];
 
-	/* Line 7  are the GPIO lines */
-	if (ciu > 6 || bit > 63)
-		return -EINVAL;
-
 	*out_hwirq = (ciu << 6) | bit;
 	*out_type = 0;
 
@@ -1570,10 +1569,16 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
 	if (!octeon_irq_virq_in_range(virq))
 		return -EINVAL;
 
-	/* Line 7  are the GPIO lines */
-	if (line > 6 || octeon_irq_ciu_to_irq[line][bit] != 0)
+	if (octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
+	/*
+	 * Line 7 are the GPIO lines, we set virq to 0 so
+	 * that GPIO would be able to map it
+	 */
+	if (line > 6 || bit > 63)
+		virq = 0;
+
 	if (octeon_irq_ciu2_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
 					   &octeon_irq_chip_ciu2,
-- 
1.7.9.5
