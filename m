Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:50:48 +0200 (CEST)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:41789 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009248AbaIRVruMDxeF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:50 +0200
Received: by mail-ob0-f201.google.com with SMTP id wm4so310313obc.4
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CKcuzXE6vPvx9+h22WzD1MmwwxBvDrqwYK9wakqBZw=;
        b=VsF3vHBNOKJ7dGh9etUlXB5gkzQYZNeSmt1jtJquUVSQb3rCzASfiFA980sqMHh9zm
         WU6oSI9VO3ZI7Gv/jwaan3hQw05WU57UjAP1A/+eiRqoYAwR6GVEt79xK1lrIYw/Yywi
         xPSBbEQfAHWVpV1PvkOUQXqX2t+VNE7pxUHvo3KUhPAwi4WcsrO7ZDD4HqfkX/xFEM6q
         QCFTnekUYVymZuw77EO3oku9VY1f6nI3xUwLIvEcId17in5hAL2hp4/Esb15U/zRPwm5
         TbLpbokjvDKT+eh3JikLREhRUJtANi6GpAxxXMd+D+TyQPc12n77oLOucstkUq6UFh2C
         Ml2w==
X-Gm-Message-State: ALoCoQmTZ383OlGzGBABAqx+Z559gnvVFJMO3xSMqSZEJs5k0/lHpnpveFYmCgRwbyu+BxIZX7Ty
X-Received: by 10.42.38.15 with SMTP id a15mr7440306ice.30.1411076861841;
        Thu, 18 Sep 2014 14:47:41 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si2190yho.5.2014.09.18.14.47.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:41 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id mCkhyaue.2; Thu, 18 Sep 2014 14:47:41 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B30CE220CC1; Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/24] MIPS: Move MIPS_GIC_IRQ_BASE into platform irq.h
Date:   Thu, 18 Sep 2014 14:47:18 -0700
Message-Id: <1411076851-28242-13-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Define a generic MIPS_GIC_IRQ_BASE which should be suitable for all
current boards in <mach-generic/irq.h>.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/include/asm/mach-generic/irq.h     | 6 ++++++
 arch/mips/include/asm/mips-boards/maltaint.h | 2 --
 arch/mips/include/asm/mips-boards/sead3int.h | 2 --
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/irq.h b/arch/mips/include/asm/mach-generic/irq.h
index 139cd20..050e18b 100644
--- a/arch/mips/include/asm/mach-generic/irq.h
+++ b/arch/mips/include/asm/mach-generic/irq.h
@@ -36,4 +36,10 @@
 
 #endif /* CONFIG_IRQ_CPU */
 
+#ifdef CONFIG_MIPS_GIC
+#ifndef MIPS_GIC_IRQ_BASE
+#define MIPS_GIC_IRQ_BASE (MIPS_CPU_IRQ_BASE + 8)
+#endif
+#endif /* CONFIG_MIPS_GIC */
+
 #endif /* __ASM_MACH_GENERIC_IRQ_H */
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index 4186606..d741628 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -10,8 +10,6 @@
 #ifndef _MIPS_MALTAINT_H
 #define _MIPS_MALTAINT_H
 
-#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
-
 /*
  * Interrupts 0..15 are used for Malta ISA compatible interrupts
  */
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index 2320331..11ebec9 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -14,6 +14,4 @@
 #define GIC_BASE_ADDR		0x1b1c0000
 #define GIC_ADDRSPACE_SZ	(128 * 1024)
 
-#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
-
 #endif /* !(_MIPS_SEAD3INT_H) */
-- 
2.1.0.rc2.206.gedb03e5
