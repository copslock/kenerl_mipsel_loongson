Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 11:28:41 +0200 (CEST)
Received: from mail.work-microwave.de ([62.245.205.51]:47364 "EHLO
        work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1903468Ab2FRJ2g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2012 11:28:36 +0200
Received: from rst-pc1.lan.work-microwave.de ([192.168.11.78])
        (authenticated bits=0)
        by mail.work-microwave.de  with ESMTP id q5I9SU85031289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 18 Jun 2012 10:28:31 +0100
Received: by rst-pc1.lan.work-microwave.de (Postfix, from userid 1000)
        id BADEEAE096; Mon, 18 Jun 2012 11:28:30 +0200 (CEST)
From:   Roland Stigge <stigge@antcom.de>
To:     ralf@linux-mips.org, blogic@openwrt.org, jkosina@suse.cz,
        standby24x7@gmail.com, bhelgaas@google.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        grant.likely@secretlab.ca, linus.walleij@stericsson.com
Cc:     Roland Stigge <stigge@antcom.de>
Subject: [PATCH] mips: pci-lantiq: Fix check for valid gpio
Date:   Mon, 18 Jun 2012 11:28:26 +0200
Message-Id: <1340011706-32281-1-git-send-email-stigge@antcom.de>
X-Mailer: git-send-email 1.7.10
X-FEAS-SYSTEM-WL: rst@work-microwave.de, 192.168.11.78
X-archive-position: 33685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stigge@antcom.de
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

This patch fixes two checks for valid gpio number, formerly (wrongly)
considering zero as invalid, now using gpio_is_valid().

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/mips/pci/pci-lantiq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/mips/pci/pci-lantiq.c
+++ linux-2.6/arch/mips/pci/pci-lantiq.c
@@ -129,7 +129,7 @@ static int __devinit ltq_pci_startup(str
 
 	/* setup reset gpio used by pci */
 	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
-	if (reset_gpio > 0)
+	if (gpio_is_valid(reset_gpio))
 		devm_gpio_request(&pdev->dev, reset_gpio, "pci-reset");
 
 	/* enable auto-switching between PCI and EBU */
@@ -192,7 +192,7 @@ static int __devinit ltq_pci_startup(str
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_IEN) | 0x10, LTQ_EBU_PCC_IEN);
 
 	/* toggle reset pin */
-	if (reset_gpio > 0) {
+	if (gpio_is_valid(reset_gpio)) {
 		__gpio_set_value(reset_gpio, 0);
 		wmb();
 		mdelay(1);
