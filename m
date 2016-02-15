Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 16:45:38 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:33624 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011655AbcBOPpf6iChN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 16:45:35 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u1FFjFQ8023181
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 15 Feb 2016 15:45:16 GMT
Received: from ulegcpding.emea.nsn-net.net ([10.151.15.193])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id u1FFjDai010475;
        Mon, 15 Feb 2016 16:45:13 +0100
Date:   Mon, 15 Feb 2016 16:45:13 +0100
From:   Ioan Nicu <ioan.nicu.ext@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Uwe Duerr <uwe.duerr.ext@nokia.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: do not change affinity for disabled irqs
Message-ID: <20160215154513.GF25050@ulegcpding.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 4634
X-purgate-ID: 151667::1455551116-00004E94-6E86FD97/0/0
Return-Path: <ioan.nicu.ext@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ioan.nicu.ext@nokia.com
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

Octeon sets the default irq affinity to value 1 in the early arch init
code, so by default all irqs get registered with their affinity set to
core 0.

When setting one CPU ofline, octeon_irq_cpu_offline_ciu() calls
irq_set_affinity_locked(), but this function sets the IRQD_AFFINITY_SET bit
in the irq descriptor. This has the side effect that if one irq is
requested later, after putting one CPU offline, the affinity of this irq
would not be the default anymore, but rather forced to "all cores - the
offline core".

This patch sets the IRQCHIP_ONOFFLINE_ENABLED flag in octeon irq
controllers, so that the kernel would call the irq_cpu_[on|off]line()
callbacks only for enabled irqs. If some other irq is requested after
setting one cpu offline, it would use the default irq affinity, same as it
would do in the normal case where there is no CPU hotplug operation.

Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 368eb49..684582e 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -935,6 +935,7 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -948,6 +949,7 @@ static struct irq_chip octeon_irq_chip_ciu_v2_edge = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -963,6 +965,7 @@ static struct irq_chip octeon_irq_chip_ciu_sum2 = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_sum2,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -976,6 +979,7 @@ static struct irq_chip octeon_irq_chip_ciu_sum2_edge = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_sum2,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -988,6 +992,7 @@ static struct irq_chip octeon_irq_chip_ciu = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -1001,6 +1006,7 @@ static struct irq_chip octeon_irq_chip_ciu_edge = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -1041,7 +1047,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
 #endif
-	.flags = IRQCHIP_SET_TYPE_MASKED,
+	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 static struct irq_chip octeon_irq_chip_ciu_gpio = {
@@ -1056,7 +1062,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio = {
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
 #endif
-	.flags = IRQCHIP_SET_TYPE_MASKED,
+	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 /*
@@ -1838,6 +1844,7 @@ static struct irq_chip octeon_irq_chip_ciu2 = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -1851,6 +1858,7 @@ static struct irq_chip octeon_irq_chip_ciu2_edge = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
@@ -1886,7 +1894,7 @@ static struct irq_chip octeon_irq_chip_ciu2_gpio = {
 	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
 #endif
-	.flags = IRQCHIP_SET_TYPE_MASKED,
+	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 static int octeon_irq_ciu2_xlat(struct irq_domain *d,
@@ -2537,6 +2545,7 @@ static struct irq_chip octeon_irq_chip_ciu3 = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu3_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 #endif
 };
 
-- 
1.7.1
