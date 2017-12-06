Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 08:05:09 +0100 (CET)
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:46661 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990391AbdLFHFCZguQ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 08:05:02 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A2DA28E6E;
        Wed,  6 Dec 2017 07:05:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ice35_82f4b10afcf47
X-Filterd-Recvd-Size: 2742
Received: from joe-laptop.perches.com (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Dec 2017 07:04:59 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Fix logging messages with spurious periods after newlines
Date:   Tue,  5 Dec 2017 23:04:58 -0800
Message-Id: <ac33924a3e39541330e8f008f3ad0fbda74845d6.1512543855.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Using a period after a newline causes bad output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 5b3a3f6a9ad3..b993d9f2c9b9 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2271,7 +2271,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	parent_irq = irq_of_parse_and_map(ciu_node, 0);
 	if (!parent_irq) {
-		pr_err("ERROR: Couldn't acquire parent_irq for %s\n.",
+		pr_err("ERROR: Couldn't acquire parent_irq for %s\n",
 			ciu_node->name);
 		return -EINVAL;
 	}
@@ -2281,7 +2281,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(0) %s\n.", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(0) %s\n", ciu_node->name);
 		return -EINVAL;
 	}
 	host_data->raw_reg = (u64)phys_to_virt(
@@ -2289,7 +2289,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 1, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(1) %s\n.", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(1) %s\n", ciu_node->name);
 		return -EINVAL;
 	}
 	host_data->en_reg = (u64)phys_to_virt(
@@ -2297,7 +2297,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	r = of_property_read_u32(ciu_node, "cavium,max-bits", &val);
 	if (r) {
-		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n.",
+		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n",
 			ciu_node->name);
 		return r;
 	}
@@ -2307,7 +2307,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 					   &octeon_irq_domain_cib_ops,
 					   host_data);
 	if (!cib_domain) {
-		pr_err("ERROR: Couldn't irq_domain_add_linear()\n.");
+		pr_err("ERROR: Couldn't irq_domain_add_linear()\n");
 		return -ENOMEM;
 	}
 
-- 
2.15.0
