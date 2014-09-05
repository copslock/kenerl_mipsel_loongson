Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:32:17 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:42389 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025896AbaIERaihM2R3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:38 +0200
Received: by mail-pa0-f74.google.com with SMTP id lf10so136389pab.1
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEf3lBWgMWfWN1ATPISMO6YZI4EBwlI3vsx6cfQ83iE=;
        b=RNa7k+lfpb4lbnjUvgclD5brG149my8zks+CooO4sORTKE9isaSFzoT4B5fdW7dLZM
         uRlAA2IikKvy4/7Ic051fwMYdZc7/UfD0Dq/8tOH4YfKlhJn9saRqZq9arkRfIuUBcrQ
         UEjkn6fjMN2llUaqoY4eHkxgEo4PUUFP8QJfQgYBJjOWNPledGneJPQs/ccDFYCAjsph
         3AldogAuSImoNDOtgKE/ll55Qawq1W2SIYjqJXSwOtMkgqBAC1jvK39ka6/S9kJ8icFe
         FhcaxpPETkVdjF/d0MvihPxjTVu5JcbUBVTh3lxgvxkw9CruhCGVcnv6g8O6BmNentae
         en6Q==
X-Gm-Message-State: ALoCoQmmRCBNhH95M6GcYB46KFdEu1YsvLEl8Qs+9/hA+pd9sKUJebJrhqvjOC6eiYJNV2tRtA29
X-Received: by 10.66.141.165 with SMTP id rp5mr6196664pab.47.1409938232662;
        Fri, 05 Sep 2014 10:30:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c77si506596yha.5.2014.09.05.10.30.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:32 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 762EB5A427D;
        Fri,  5 Sep 2014 10:30:32 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3B0A12209EA; Fri,  5 Sep 2014 10:30:32 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/16] MIPS: Move MIPS_GIC_IRQ_BASE into platform irq.h
Date:   Fri,  5 Sep 2014 10:30:08 -0700
Message-Id: <1409938218-9026-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42435
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

Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v1.
---
 arch/mips/include/asm/mach-generic/irq.h     | 6 ++++++
 arch/mips/include/asm/mach-sead3/irq.h       | 1 +
 arch/mips/include/asm/mips-boards/maltaint.h | 2 --
 arch/mips/include/asm/mips-boards/sead3int.h | 2 --
 4 files changed, 7 insertions(+), 4 deletions(-)

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
diff --git a/arch/mips/include/asm/mach-sead3/irq.h b/arch/mips/include/asm/mach-sead3/irq.h
index d8106f7..52c75d5 100644
--- a/arch/mips/include/asm/mach-sead3/irq.h
+++ b/arch/mips/include/asm/mach-sead3/irq.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_MACH_MIPS_IRQ_H
 #define __ASM_MACH_MIPS_IRQ_H
 
+#define MIPS_GIC_IRQ_BASE 0
 #define GIC_NUM_INTRS (24 + NR_CPUS * 2)
 #define NR_IRQS 256
 
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index e330732..9d23343 100644
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
index 6b17aaf..11ebec9 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -14,6 +14,4 @@
 #define GIC_BASE_ADDR		0x1b1c0000
 #define GIC_ADDRSPACE_SZ	(128 * 1024)
 
-#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 0)
-
 #endif /* !(_MIPS_SEAD3INT_H) */
-- 
2.1.0.rc2.206.gedb03e5
