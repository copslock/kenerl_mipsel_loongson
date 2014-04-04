Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 16:33:35 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:47223 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822264AbaDDOddXDyV4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 16:33:33 +0200
Received: by mail-we0-f172.google.com with SMTP id t61so3578707wes.3
        for <linux-mips@linux-mips.org>; Fri, 04 Apr 2014 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7bdRhXJI7z9CccARmH5Exl+B0g7ZWpYqZu5HB2fMB8c=;
        b=B+XGhGqvQ4w6vUPfzGYlZJ0IUukFuXyneE6XE3ZbUQhsSLqcjssOYEHrAsClbdusIm
         f7HDKC6AKc8oXSWMjMdyFJ8dnTWDKbM2858aNeL7KxaFAuRh8luoQoYkKZhmSBAsMKVn
         U6ANmlHltOo55AxUADkAKMj82J9ABrk9Y3/NdDAPZgD4c30HWXvgFqvkg9K5Y0YeH3ZQ
         dOjh/6ryd7F9CMYL+aSDeM1C4dN2U0sJxEPc/lAT79XWnHCwfaCN2trsJjdFw46DMsrz
         z94PqmsUqjwOkaWZGArTWJdef0insk/yygWyovY/yyEnVT9q0AmgF2rOuYlZx00hVGTt
         Aogg==
X-Received: by 10.180.38.41 with SMTP id d9mr5059123wik.9.1396622008024;
        Fri, 04 Apr 2014 07:33:28 -0700 (PDT)
Received: from localhost.localdomain (p57A35AD1.dip0.t-ipconnect.de. [87.163.90.209])
        by mx.google.com with ESMTPSA id x45sm19945862eef.15.2014.04.04.07.33.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Apr 2014 07:33:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: Default to noncoherent IO on Au1200 AB w. USB
Date:   Fri,  4 Apr 2014 16:33:23 +0200
Message-Id: <1396622004-157911-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

CONFIG_DMA_COHERENT is no longer set; default to noncoherent io on
Au1200 revision AB if USB is enabled.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/setup.c |  7 +++++++
 arch/mips/alchemy/common/usb.c   | 26 ++------------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 566a174..577b0be 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -67,6 +67,13 @@ void __init plat_mem_setup(void)
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1100:
 		coherentio = 0;
+		break;
+	case ALCHEMY_CPU_AU1200:
+		/* Au1200 AB USB does not support coherent memory */
+		if (IS_ENABLED(CONFIG_USB) &&
+		    (!(read_c0_prid() & PRID_REV_MASK)))
+			coherentio = 0;
+		break;
 	}
 
 	board_setup();	/* board specific setup */
diff --git a/arch/mips/alchemy/common/usb.c b/arch/mips/alchemy/common/usb.c
index 2adc7ed..d193dbe 100644
--- a/arch/mips/alchemy/common/usb.c
+++ b/arch/mips/alchemy/common/usb.c
@@ -355,47 +355,25 @@ static inline void __au1200_udc_control(void __iomem *base, int enable)
 	}
 }
 
-static inline int au1200_coherency_bug(void)
-{
-#if defined(CONFIG_DMA_COHERENT)
-	/* Au1200 AB USB does not support coherent memory */
-	if (!(read_c0_prid() & PRID_REV_MASK)) {
-		printk(KERN_INFO "Au1200 USB: this is chip revision AB !!\n");
-		printk(KERN_INFO "Au1200 USB: update your board or re-configure"
-				 " the kernel\n");
-		return -ENODEV;
-	}
-#endif
-	return 0;
-}
-
 static inline int au1200_usb_control(int block, int enable)
 {
 	void __iomem *base =
 			(void __iomem *)KSEG1ADDR(AU1200_USB_CTL_PHYS_ADDR);
-	int ret = 0;
 
 	switch (block) {
 	case ALCHEMY_USB_OHCI0:
-		ret = au1200_coherency_bug();
-		if (ret && enable)
-			goto out;
 		__au1200_ohci_control(base, enable);
 		break;
 	case ALCHEMY_USB_UDC0:
 		__au1200_udc_control(base, enable);
 		break;
 	case ALCHEMY_USB_EHCI0:
-		ret = au1200_coherency_bug();
-		if (ret && enable)
-			goto out;
 		__au1200_ehci_control(base, enable);
 		break;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-out:
-	return ret;
+	return 0;
 }
 
 
-- 
1.9.1
