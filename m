Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 22:58:09 +0200 (CEST)
Received: from mail-ee0-f52.google.com ([74.125.83.52]:40463 "EHLO
        mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823925AbaDJU6Hf3VKa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 22:58:07 +0200
Received: by mail-ee0-f52.google.com with SMTP id e49so3377483eek.25
        for <linux-mips@linux-mips.org>; Thu, 10 Apr 2014 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=w11Ute7gX0V+7jR1Xqyg3q9v8CDlprxluy30s5ec8p8=;
        b=0OETVWsIpJ3gUCo6hZlFrMq0cxyNjpOqwxXpBU8y339sfpfZFGEevJd8pj+aiqEU2b
         cmUNa2uJim9baUb8HU6nOUd4NFB/lRWES6ua7BCQA7cGljA+ssziuFONtATyuucihxtZ
         G1Ij5+fKOQ7V21FrNDY3XUcNNJYKJowf21vO3YHWRHS3MCRXRUH0LP6iK+4NeETloPGV
         e5+TYQkICPn8MLOklkoLxeex+x6OCj1pfV4kXhjcktKzo96U8iK+F2CxcOdr9FzkRmxK
         cCcYweHm6xzsOzi+0pnSKy/47NkQLTC3dNgH7MlY/yJFgHpoUzymKL2vwrsIkIJCkOl3
         OGyw==
X-Received: by 10.14.6.1 with SMTP id 1mr5679345eem.71.1397163482273;
        Thu, 10 Apr 2014 13:58:02 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D48A.dip0.t-ipconnect.de. [79.216.212.138])
        by mx.google.com with ESMTPSA id m8sm12583812eeg.11.2014.04.10.13.58.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 13:58:01 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: Default to noncoherent IO on Au1200 AB
Date:   Thu, 10 Apr 2014 22:57:59 +0200
Message-Id: <1397163479-279782-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39769
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
Au1200 revision AB to make USB work.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: Ralf made me aware that only enabling this quirk when USB is compiled
    in is flawed since someone might load a newly-compiled USB stack into
    a non-usb aware kernel.

 arch/mips/alchemy/common/setup.c |  6 ++++++
 arch/mips/alchemy/common/usb.c   | 26 ++------------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 566a174..8267e3c 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -67,6 +67,12 @@ void __init plat_mem_setup(void)
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1100:
 		coherentio = 0;
+		break;
+	case ALCHEMY_CPU_AU1200:
+		/* Au1200 AB USB does not support coherent memory */
+		if (0 == (read_c0_prid() & PRID_REV_MASK))
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
