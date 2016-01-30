Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:18:51 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34659 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009265AbcA3FRmpFnkt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:42 +0100
Received: by mail-pf0-f196.google.com with SMTP id 65so4716218pfd.1;
        Fri, 29 Jan 2016 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=siJ3EZVAJuPONp2ufMQQv0r1LQDFB/A1lbuYNBcUpnM=;
        b=hr0UM68Qe1S10QqH8DPt4TCX4UNJpjcxgz+SyDTKHIH4qe/KueKlVQlocHub1e6akQ
         GTHwZIYeEH5FrX/c8JMVve8iq8uj/rz5ifDjpWJX0eFw2IbdGc0dzbiMjgbJF/VEEC98
         jJ/sEzKi4PdgY3eveZVSPjRTsCpitHgxJwqu1doRXN1qIoibRkb8OkqXgjZSMUE/cwoK
         TXtD7ks9wz4OBtfQ04Wcu48ygIA5WptQ9x/9k4J7uZ/UDrZ8/qCW2FAR7H+UKYsdrSmV
         CYFa14GeEIxd8Tk98Q4pT7+DUuYySjZlJDbmCnNpNUtgPd0nJPjNiXuhSm2KM/j441XU
         psxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=siJ3EZVAJuPONp2ufMQQv0r1LQDFB/A1lbuYNBcUpnM=;
        b=gRQN+uI6Hl0MlX54VROnpg6zy5QyprkbswmdoKGPVYheWUO0Ix8H6BXe7jQswowfUQ
         0YFnY64/3Qrpb3kgEjzqLQVe4JJJu9GV22g7WIriqEiMHvgltWhEJoB+VJfMEa0cplMI
         FYf2B0Ckzhd2UJoCX+NF+i/XIkSx9akD/bRU3S1QWdCZZOU7O0d+s/WEj1D4GyHP2fvh
         HFjaPef+4Fd2PGMUfncJVI5RQ8jKATyFlwRAnOXuGLubsLa6dzjbnOfccxequcpVRLW4
         ciwKO66mgpmB+aIeaCxXkKgTha2eD3XAvoNieocj8Y9kCDTXZOHw8fL2h9drWVDt1sQD
         L1Hw==
X-Gm-Message-State: AG10YORLwSUhljD8+HvLUsEEOLaTtgZAgzoY69nDcN+NOHv193SbNkNMMfuJFvVoEPmQTA==
X-Received: by 10.98.19.93 with SMTP id b90mr19646081pfj.34.1454131056681;
        Fri, 29 Jan 2016 21:17:36 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/6] MIPS: BMIPS: Add cpu-feature-overrides.h
Date:   Fri, 29 Jan 2016 21:17:24 -0800
Message-Id: <1454131046-11124-5-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

BMIPS_GENERIC being multiplatform and intended to support BMIPS3200,
BMIPS3300, BMIPS4350, BMIPS4380 and BMIPS5000-class processors, there is
not much more we can put in there since they do not share the same I and
D cache line sizes at all (doubled for every new generation
essentially), some processors have a S-cache, some don't, some have a
FPU, some don't.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../include/asm/mach-bmips/cpu-feature-overrides.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
new file mode 100644
index 0000000..fa0583e
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
+
+/* Invariants across all BMIPS processors */
+#define cpu_has_vtag_icache		0
+#define cpu_icache_snoops_remote_store	1
+
+/* Processor ISA compatibility is MIPS32R1 */
+#define cpu_has_mips32r1		1
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+
+#endif /* __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H */
-- 
1.7.1
