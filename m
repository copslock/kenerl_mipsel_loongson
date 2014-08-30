Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:05:58 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40691 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007490AbaH3CF3qJ3cI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:29 +0200
Received: by mail-lb0-f174.google.com with SMTP id p9so3464046lbv.19
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIC60uMSobWsJE5joNyvR1TH6hLm1fI3E4x2Tbn3aIM=;
        b=ol8vE9cbjW4EAmVjSbXWRFGLg36EpljM4V6fqNtWf+a1ANjwwDwzc8iAe5SJ3aX+1s
         +EdXPQvvloSwPqDZts7e/TkCC2uDpn6jB+U1nO9LurqD2TmXH/7NIF0bsUeuTxL5xTsE
         Zcg2O+qBsI9hx7Gkoah5A8vHq/BoV6LzmwnoBMNq+MN9csAoxMNlZNCBfjpR8UW37Muh
         WV//hEz5s5k7Drm/qd2H5QEDHmQMWVfimBrgCOxqQ2N40YlGC4VUMYglXWTjA/EEcECr
         l0SloeiQb9ch/EI5ertn1LH16Wt1x0C2ZNx7egbI7sWd2TRh3Y80Fguebns7fMTrHLia
         SXtA==
X-Received: by 10.152.27.2 with SMTP id p2mr14676035lag.23.1409364324424;
        Fri, 29 Aug 2014 19:05:24 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:23 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 2/5] MIPS: MSP71xx: remove odd locking in PCI config space access code
Date:   Sat, 30 Aug 2014 06:06:25 +0400
Message-Id: <1409364388-7108-3-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
---
 arch/mips/pci/ops-pmcmsp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 50034f9..dd2d9f7 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -193,8 +193,6 @@ static void pci_proc_init(void)
 }
 #endif /* CONFIG_PROC_FS && PCI_COUNTERS */
 
-static DEFINE_SPINLOCK(bpci_lock);
-
 /*****************************************************************************
  *
  *  STRUCT: pci_io_resource
@@ -368,7 +366,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 	struct msp_pci_regs *preg = (void *)PCI_BASE_REG;
 	unsigned char bus_num = bus->number;
 	unsigned char dev_fn = (unsigned char)devfn;
-	unsigned long flags;
 	unsigned long intr;
 	unsigned long value;
 	static char pciirqflag;
@@ -401,10 +398,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 	}
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
-	local_irq_save(flags);
 	vpe_status = dvpe();
-#else
-	spin_lock_irqsave(&bpci_lock, flags);
 #endif
 
 	/*
@@ -457,9 +451,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 		evpe(vpe_status);
-		local_irq_restore(flags);
-#else
-		spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 		return -1;
@@ -467,9 +458,6 @@ int msp_pcibios_config_access(unsigned char access_type,
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 	evpe(vpe_status);
-	local_irq_restore(flags);
-#else
-	spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
-- 
1.8.1.5
