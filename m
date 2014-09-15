Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:55:23 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:65111 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009023AbaIOXvrM0I9H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:47 +0200
Received: by mail-oi0-f74.google.com with SMTP id e131so737727oig.5
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=raFR+ci4fyohR2XzTcw8bLH/pkJsVV8x2KZLLyi6tMI=;
        b=gC/eZ9Rh6zvwDOVDaF8zfN+WGL1wZc6oZrY5626Ir0e70YZTSeSDgCfopO96e5Xn+4
         ucchZSTpz25Zmxl3IQZ2Rkdr5XdYy5e1gd+o8AyPeNu6HOH1wadm3Wv7A/15/Ou6z+xL
         kXMhItjMuP5uXYsk5+PL9lgoP5t15nfXWVkybH0lTqyBbcZmXAhiT4oOppUSlV1kd7Qb
         vuaLEtsVd++MA71hL7vs0FFdj+yAhyCw7AwdTM51+5/t7DpFelHxhMs2P9qG/JxDqT/T
         UJ8xGs3QtqIS37o4208AuCjgCzkaw1Tdfj5h1LN+075TM+tUkgnKg6h+3M3M/PrSiVZ5
         Wn9g==
X-Gm-Message-State: ALoCoQl9jrV+faZ2SDhBa3g3/fEynFR3voseD02701vfqXIw3Vv2a/Nt6jc1dRtJr8mZnVfUNpYh
X-Received: by 10.182.130.168 with SMTP id of8mr18009392obb.27.1410825100576;
        Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id m14si627508yhm.7.2014.09.15.16.51.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 1oB1jrOM.2; Mon, 15 Sep 2014 16:51:40 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 786B7220868; Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
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
Subject: [PATCH 12/24] MIPS: Move MIPS_GIC_IRQ_BASE into platform irq.h
Date:   Mon, 15 Sep 2014 16:51:15 -0700
Message-Id: <1410825087-5497-13-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42631
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
