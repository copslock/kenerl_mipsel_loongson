Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Mar 2013 15:47:51 +0100 (CET)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:10875 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817419Ab3CHOrp4E636 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Mar 2013 15:47:45 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r28Eld0L013226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 8 Mar 2013 15:47:39 +0100
Received: from [10.151.24.91] ([10.151.24.91])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r28Elc6r017948;
        Fri, 8 Mar 2013 15:47:38 +0100
Message-ID: <5139FA0A.8060908@nsn.com>
Date:   Fri, 08 Mar 2013 15:47:38 +0100
From:   Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     david.daney@cavium.com
Subject: [PATCH] octeon-irq: Fix GPIO number in IRQ chip private data
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1527
X-purgate-ID: 151667::1362754059-00001023-1F50C039/0-0/0-0
X-archive-position: 35859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin.ext@nsn.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

octeon-irq: Fix GPIO number in IRQ chip private data

Current GPIO chip implementation in octeon-irq is still broken, even after upstream
commit 87161ccdc61862c8b49e75c21209d7f79dc758e9 (MIPS: Octeon: Fix broken interrupt
controller code). It works for GPIO IRQs that have reset-default configuration, but
not for edge-triggered ones.

The problem is in octeon_irq_gpio_map_common(), which passes modified "hw" variable
(which has range of possible values 16..31) as "gpio_line" parameter to
octeon_irq_set_ciu_mapping(), which saves it in private data of the IRQ chip. Later,
neither octeon_irq_gpio_setup() is able to re-configure GPIOs (cvmx_write_csr() is
writing to non-existent CVMX_GPIO_BIT_CFGX), nor octeon_irq_ciu_gpio_ack() is able
to acknowledge such IRQ, because "mask" is incorrect.

Fix is trivial and has been tested on Cavium Octeon II -based board, including
both level-triggered and edge-triggered GPIO IRQs.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
Cc: David Daney <david.daney@cavium.com>
---
--- linux.orig/arch/mips/cavium-octeon/octeon-irq.c
+++ linux/arch/mips/cavium-octeon/octeon-irq.c
@@ -1034,9 +1034,8 @@ static int octeon_irq_gpio_map_common(st
  	if (!octeon_irq_virq_in_range(virq))
  		return -EINVAL;

-	hw += gpiod->base_hwirq;
-	line = hw >> 6;
-	bit = hw & 63;
+	line = (hw + gpiod->base_hwirq) >> 6;
+	bit = (hw + gpiod->base_hwirq) & 63;
  	if (line > line_limit || octeon_irq_ciu_to_irq[line][bit] != 0)
  		return -EINVAL;
