Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 15:55:14 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:57719 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012258AbaJWNzMJv80j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 15:55:12 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s9NDt4gc014071
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 23 Oct 2014 13:55:04 GMT
Received: from [10.151.38.178] ([10.151.38.178])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s9NDt4qd019303;
        Thu, 23 Oct 2014 15:55:04 +0200
Message-ID: <544908B8.7050109@nsn.com>
Date:   Thu, 23 Oct 2014 15:55:04 +0200
From:   Alexander Sverdlin <alexander.sverdlin@nsn.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     ddaney.cavm@gmail.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: [PATCH] Make Octeon GPIO IRQ chip CPU hotplug-aware
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1135
X-purgate-ID: 151667::1414072504-00001FC1-806B6981/0/0
Return-Path: <alexander.sverdlin@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nsn.com
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

From: Alexander Sverdlin <alexander.sverdlin@nsn.com>

Make Octeon GPIO IRQ chip CPU hotplug-aware

Seems that irq_cpu_offline callbacks were forgotten in v1 and v2 CIU
GPIO chips. There is such a callback for octeon_irq_chip_ciu2_gpio,
covering CIU2 chips. Without this callback GPIO IRQs are not being migrated
during core offlining. Patch is tested on Octeon II.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nsn.com>

---
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -809,6 +809,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
 	.irq_set_type = octeon_irq_ciu_gpio_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
 #endif
 	.flags = IRQCHIP_SET_TYPE_MASKED,
 };
@@ -823,6 +824,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio = {
 	.irq_set_type = octeon_irq_ciu_gpio_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
 #endif
 	.flags = IRQCHIP_SET_TYPE_MASKED,
 };
