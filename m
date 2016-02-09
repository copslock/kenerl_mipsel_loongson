Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:01:39 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34087 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012234AbcBITBEW4LaR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:04 +0100
Received: by mail-pf0-f194.google.com with SMTP id 71so5310883pfv.1;
        Tue, 09 Feb 2016 11:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NkZLFQ6NGMt9OsrGzgsL6YkQoFiOmDi08gEuE2HtmfA=;
        b=BNMgGZfcoqQTiSnMhWFgV+k0D6C6aJXKL7yShD4R1cllzM9snGJdiVvQ1nm4QuPV36
         +FTsVba2Pslz+fL9R1ksu+jzeue6SN3dVuFIYF+nG2CbpVqtx3mId6Z4ueadM/nOyXkJ
         Unqw8VtKJBWkyjLG1zZ/7GQ+k92FXtYRDBxuwAMqC4emwJmOw60j9ZO3DoSF1mYXKDVL
         LF5vhUDXmGXJsVcHV2dHrlHI/sAG0RH2e0PmL1U6eILmMM9ycP1U+pDv3Fvf9WRjhxfA
         CRxSyhaAb9iRSiOgwcjOsS+5pO5rtGKfD++EYldOb3tYgqLBaMwrFZCR/sNxCtuRfqF2
         qjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NkZLFQ6NGMt9OsrGzgsL6YkQoFiOmDi08gEuE2HtmfA=;
        b=VA3NsztsaRqvUUwsoX26fxPaTiHZdhoZTik4psgMOvraPTfCB5+KxRH5Zb56DSdiZ3
         SVJZm2ADLKEf0zKrZ9WLHcfU7r5xllZE2UFPctEi+cEPa12ONRjXZlBIlH3GlZLqqmGM
         XmC8KDkcgjS/ziTxPQq/Tyo4tFI/m7M5Iw6yLXIqjswmFiel5XM0kyjY36oQJqkkl/9+
         R0giKK1y0+nhrjJ8f9qes6YVJMoe0yOPTDyC6RvwCpFz63JwXHROQ3If88/Wb3ycun4u
         tfC2jDbpg/VNdERfZL65XAFJw/NhLEgVlk6ZTDRW0MM4Pu8FTXnQK5J1MuVvfpgoaitM
         VIZA==
X-Gm-Message-State: AG10YOTaP/X5F40jHuZhuwXJKKgT4VrXkHIbiexS98hnVYt0Cojv14AxA5bMdmiaUsqX2Q==
X-Received: by 10.98.72.135 with SMTP id q7mr51805264pfi.151.1455044458752;
        Tue, 09 Feb 2016 11:00:58 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id xz6sm52290796pab.42.2016.02.09.11.00.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:53 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0qx1009876;
        Tue, 9 Feb 2016 11:00:52 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0qYR009875;
        Tue, 9 Feb 2016 11:00:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/8] MIPS: Select CONFIG_HANDLE_DOMAIN_IRQ and make it work.
Date:   Tue,  9 Feb 2016 11:00:07 -0800
Message-Id: <1455044413-9823-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Per the subject, always select HANDLE_DOMAIN_IRQ, and implement
set_irq_regs() so that it actually works.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/irq_regs.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a945e..9a0a780 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -62,6 +62,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
+	select HANDLE_DOMAIN_IRQ
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/irq_regs.h b/arch/mips/include/asm/irq_regs.h
index 33bd2a0..8c48d6d 100644
--- a/arch/mips/include/asm/irq_regs.h
+++ b/arch/mips/include/asm/irq_regs.h
@@ -18,4 +18,14 @@ static inline struct pt_regs *get_irq_regs(void)
 	return current_thread_info()->regs;
 }
 
+static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
+{
+	struct pt_regs *old_regs;
+
+	old_regs = get_irq_regs();
+	current_thread_info()->regs = new_regs;
+
+	return old_regs;
+}
+
 #endif /* __ASM_IRQ_REGS_H */
-- 
1.7.11.7
