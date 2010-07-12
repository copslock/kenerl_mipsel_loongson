Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2010 02:05:17 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:49164 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492187Ab0GLAFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jul 2010 02:05:10 +0200
Received: by pwj7 with SMTP id 7so1837739pwj.36
        for <multiple recipients>; Sun, 11 Jul 2010 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=k+61SQGnT+K3KBEdPAwmB4ftr4UCfyO2uLhoVcq4ygA=;
        b=tftE2Rrk6bKNJFBZOkSE0JQ+BoZSsKJH/qZhk1VIAx8hcbpDEbdF8f0fCiZYrGIVEu
         TyYT+6CC2MaS1GRZrQsVKWBK3jIlsosgcSqBq+XcWiDayi6vJBxop9zaO0loyVAcVO8w
         junHuf0g/dgw7dcNjzudTNmErGA/5RY8GHT7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=xXdsnUGD6/BAsDYQj8I+HvjBaJVsTYFaVZFK5pyqqnJmKd+IPjKty/rOnpFpYpddft
         uomaEigAMRTGAKkkFSh86linZYCNsflrHEkgxSEBc/gwJmQVFNbnRopzF8mZD+URGS7x
         z/7y/y+4EHFaXm+CBfVSlC4iaMDMLXcK76pDs=
Received: by 10.114.159.14 with SMTP id h14mr15094245wae.113.1278893102790;
        Sun, 11 Jul 2010 17:05:02 -0700 (PDT)
Received: from [127.0.1.1] (zaq3d2e62b2.zaq.ne.jp [61.46.98.178])
        by mx.google.com with ESMTPS id d38sm58416358wam.8.2010.07.11.17.05.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 17:05:01 -0700 (PDT)
Subject: [PATCH] MIPS: MTX-1: fix PCI on the MeshCube and related boards
To:     linux-mips@linux-mips.org, manuel.lauss@googlemail.com,
        ralf@linux-mips.org
From:   Bruno Randolf <randolf.bruno@googlemail.com>
Cc:     stable@kernel.org
Date:   Mon, 12 Jul 2010 09:04:58 +0900
Message-ID: <20100712000425.31611.49721.stgit@void>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <randolf.bruno@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randolf.bruno@googlemail.com
Precedence: bulk
X-list: linux-mips

This patch fixes a regression introduced by commit "MIPS: Alchemy: MTX-1: Use
linux gpio api." (bb706b28bbd647c2fd7f22d6bf03a18b9552be05) which broke PCI bus
operation. The problem is caused by alchemy_gpio2_enable() which resets the
GPIO2 block. Two PCI signals (PCI_SERR and PCI_RST) are connected to GPIO2 and
they obviously do not to like the reset. Since GPIO2 is correctly initialized
by the boot monitor (YAMON) it is not necessary to call this function, so just
remove it.

Also replace gpio_set_value() with alchemy_gpio_set_value() to avoid problems
in case gpiolib gets initialized after PCI. And since alchemy gpio_set_value()
calls au_sync() we don't have to au_sync() again later.

Cc: stable@kernel.org
Signed-off-by: Bruno Randolf <br1@einfach.org>
---
sending again with stable on cc:
---
 arch/mips/alchemy/mtx-1/board_setup.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index a9f0336..52d883d 100644
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
@@ -117,11 +115,11 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
 
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
 
