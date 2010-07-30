Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2010 19:58:03 +0200 (CEST)
Received: from kroah.org ([198.145.64.141]:56281 "EHLO coco.kroah.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491859Ab0G3R56 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jul 2010 19:57:58 +0200
Received: from localhost (c-24-16-163-131.hsd1.wa.comcast.net [24.16.163.131])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by coco.kroah.org (Postfix) with ESMTPSA id 07E5A491B9;
        Fri, 30 Jul 2010 10:57:56 -0700 (PDT)
X-Mailbox-Line: From gregkh@clark.site Fri Jul 30 10:51:51 2010
Message-Id: <20100730175151.675394300@clark.site>
User-Agent: quilt/0.48-11.2
Date:   Fri, 30 Jul 2010 10:53:33 -0700
From:   Greg KH <gregkh@suse.de>
To:     linux-kernel@vger.kernel.org, stable@kernel.org,
        linux-mips@linux-mips.org, manuel.lauss@googlemail.com
Cc:     stable-review@kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk,
        Bruno Randolf <br1@einfach.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [196/205] MIPS: MTX-1: Fix PCI on the MeshCube and related boards
In-Reply-To: <20100730175238.GA3924@kroah.com>
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

2.6.34-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Bruno Randolf <randolf.bruno@googlemail.com>

commit 98a0f86a54bb195c28ae1ccb5a5f5cda12cf7121 upstream.

This patch fixes a regression introduced by commit "MIPS: Alchemy: MTX-1:
Use linux gpio api." (bb706b28bbd647c2fd7f22d6bf03a18b9552be05) which broke
PCI bus operation. The problem is caused by alchemy_gpio2_enable() which
resets the GPIO2 block. Two PCI signals (PCI_SERR and PCI_RST) are connected
to GPIO2 and they obviously do not to like the reset. Since GPIO2 is
correctly initialized by the boot monitor (YAMON) it is not necessary to
call this function, so just remove it.

Also replace gpio_set_value() with alchemy_gpio_set_value() to avoid
problems in case gpiolib gets initialized after PCI. And since alchemy
gpio_set_value() calls au_sync() we don't have to au_sync() again later.

Signed-off-by: Bruno Randolf <br1@einfach.org>
To: linux-mips@linux-mips.org
To: manuel.lauss@googlemail.com
Patchwork: https://patchwork.linux-mips.org/patch/1448/
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/mips/alchemy/mtx-1/board_setup.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -67,8 +67,6 @@ static void mtx1_power_off(void)
 
 void __init board_setup(void)
 {
-	alchemy_gpio2_enable();
-
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	/* Enable USB power switch */
 	alchemy_gpio_direction_output(204, 0);
@@ -117,11 +115,11 @@ mtx1_pci_idsel(unsigned int devsel, int
 
 	if (assert && devsel != 0)
 		/* Suppress signal to Cardbus */
-		gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
+		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
 	else
-		gpio_set_value(1, 1);	/* set EXT_IO3 ON */
+		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
 
-	au_sync_udelay(1);
+	udelay(1);
 	return 1;
 }
 
