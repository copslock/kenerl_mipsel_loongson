Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:14:32 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:38910
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeA0DO0T5izB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:14:26 +0100
Received: by mail-pl0-x242.google.com with SMTP id 13so158317plb.5;
        Fri, 26 Jan 2018 19:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQMZXrGdmzZadaUvmiNehxHbFL5UTMW7d0SF43xcCaw=;
        b=MpZTr/WuCdCYrubQwGIKG4O2EkzyAe9hY1tVrChGV5dltmxretlp4oE83LVKc5inJO
         HniWTSL+zuIy+g+o/EXnbsQY109883AzffSGIzazBGpRbpUa0XTPSVkDUNEygg67WVhv
         4Nsb/+YkVghbPAQu4rdxa9Z6kgurRoFexNd5hlTcB9DzfvZ2TvB6vqKE7GE/XQFbSa7z
         XP8RgfVJ41YYdXyK6GIO7bQYO3dUnrg6mJWZWEiTI5NxdCzGiwKnTZciP3ckPhNsMnOF
         6SWHG8eSk+16K5KdkiE+1+4wrEa1quCUm9nvy7LOSOi28HKkEIE2afLCgyVx3GqHgoDF
         jqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JQMZXrGdmzZadaUvmiNehxHbFL5UTMW7d0SF43xcCaw=;
        b=FHHYSsEtwEAJC7zOTOjttc+DzxFt3j8aunwRlaZha7XvN/tC4Q+QYIG/gOebgroZLZ
         1VAgB6KC/LvvccO2UqBzIIC/rfTOW3UVmtW1XO/CqmmN2F+rY+MxePZZSev73M2PwGdC
         Vohlr0iNA7/0Fk3HpslZKXkCSpv/iRfxkXUkMMSjLi1cXnEuajL9VQbRKcZREOGnm/to
         n50Q6+wKyKDR7mkojWYEnvVS/8oF/hmzlY7mfwFHyVb+PhKOvdLKsphjwxIh5Qn/17cr
         AagWh/LU28aS5sJWDVxRfUmaHhiJ8O92UQ4B1sIymePHYMXTZUdmb+/OD2JKmnkVWjX+
         e+CQ==
X-Gm-Message-State: AKwxytfMNZ4vWVs5oeRTM5QrWH1UCIJ8gmUrB0hzdXlXTJ9fldsBMQtG
        tQgU4Q6X9DHwHgV9FLM9rpS7ug==
X-Google-Smtp-Source: AH8x226wPSvuWWf+Zx9FNTmPgOBcr6Iy4Hbj2ujkRBAtctKBPtfk569VO0UHnZzF/QPkbXklRp7O9Q==
X-Received: by 2002:a17:902:c81:: with SMTP id 1-v6mr15995209plt.281.1517022860165;
        Fri, 26 Jan 2018 19:14:20 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w16sm4775884pfk.18.2018.01.26.19.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:14:19 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 03/12] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
Date:   Sat, 27 Jan 2018 11:12:23 +0800
Message-Id: <1517022752-3053-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
(Store Fill Buffer) which can improve the performance of memory access.
Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
the generic kernel has no benefit from SFB (even it is running on a new
Loongson-3 machine). With this patch, we can enable SFB at runtime by
detecting the CPU type (the expense is war_io_reorder_wmb() will always
be a 'sync', which will hurt the performance of old Loongson-3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h                                |  2 +-
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..5146efa 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -304,7 +304,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
-#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON3)
 #define war_io_reorder_wmb()		wmb()
 #else
 #define war_io_reorder_wmb()		do { } while (0)
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 3127391..4b7f58a 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -26,12 +26,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, 0xffff
+	slti	t0, 0x6308
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
@@ -52,12 +55,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, 0xffff
+	slti	t0, 0x6308
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
-- 
2.7.0
