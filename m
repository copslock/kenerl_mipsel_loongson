Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 07:16:24 +0100 (CET)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:35272
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992786AbeKOGPG4fuU4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 07:15:06 +0100
Received: by mail-pl1-x643.google.com with SMTP id v1-v6so1837235plo.2
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2018 22:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PjaOx8k9Y2ORMGO8iIOrEj6UmDS2qPyKnJpoXrQYYCQ=;
        b=LkMeJ5kSK/Ntm3L9XDop5dxfTgCamiEZsmlEegOT40zbn4F3orX+v+HeSVTrewE7bs
         j7v4LnKSpAKH3XJ0nX5E7EQPh5BZ0cq2pYJ85sxYZuHxyv2Qpyi7J+exnM4gJnOlzNB1
         BZBsAqk8JDGQhxPHhPXsck5n52CpflvXU801o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PjaOx8k9Y2ORMGO8iIOrEj6UmDS2qPyKnJpoXrQYYCQ=;
        b=KbsxieIDYkkgD2ve6LyBozXUaYkgUqJ8T7IAsgZ0uzXhCGGSIkgHGG5/eflm5kA+QE
         o7Cxi6fsj80R1LseKsQd75zFZ9SdS2Tn4HXEu97Y7JiKBysSxiBeTdPl525gTdrX8Nsm
         88MHBSOHOJGOX4tyqnpHml58x6GnQJoPH0SL6q7p3GXtQw4hb0I9WeGEKKpkXGNPiuHg
         ONVLZZYAwpJ8H/8rjjVh3LS58arXMl6iah7bfiO5ZDaC4lHjlsopEdQt6i94odsALY0J
         BbGDBa3Cz32+yhUx4LbL3mMTnwALLtIaZ4MvQYhRS0pP42oFscmIgwmobMGURk+EZvBY
         aThg==
X-Gm-Message-State: AGRZ1gK0x2D/g1mXehAv352KAmHTln23rMIRwvWqpTqKJEvH2VLwOcvT
        ax5g1W3OWfH914V/s/+d5BrY5A==
X-Google-Smtp-Source: AJdET5e99EtQfxuBAv04AP+XM60L7ZuS2gDU5GfZxUaBdFcUNHIEpKkerxjiapkpaqW0T2LADkHvOA==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31-v6mr4925440plf.320.1542262506014;
        Wed, 14 Nov 2018 22:15:06 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:15:05 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 3/5] mips: remove syscall table entries
Date:   Thu, 15 Nov 2018 11:44:19 +0530
Message-Id: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

The config flag - CONFIG_MIPS_MT_FPAFF uses to check whether which
syscall entries need to be used in scall32-o32.S file.

One of the patch in this patch series will generate syscall table
file. But CONFIG_MIPS_MT_FPAFF flag will add more complexity in the
script to generate the syscall table file.

In order to come up with a common implementation across all archit-
ecture, we need to remove mipsmt_sys_sched_setaffinity and mipsmt-
_sys_sched_getaffinity from the table and define it in other way.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/scall32-o32.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a9b895f..4eee437 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -208,6 +208,18 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/*
+	 * For FPU affinity scheduling on MIPS MT processors, we need to
+	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
+	 * in kernel/sched/core.c.  Considered only temporary we only support
+	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
+	 * atm.
+	 */
+#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
+#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -450,20 +462,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tkill
 	PTR	sys_sendfile64
 	PTR	sys_futex
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/*
-	 * For FPU affinity scheduling on MIPS MT processors, we need to
-	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
-	 * in kernel/sched/core.c.  Considered only temporary we only support
-	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
-	 * atm.
-	 */
-	PTR	mipsmt_sys_sched_setaffinity
-	PTR	mipsmt_sys_sched_getaffinity
-#else
 	PTR	sys_sched_setaffinity
 	PTR	sys_sched_getaffinity		/* 4240 */
-#endif /* CONFIG_MIPS_MT_FPAFF */
 	PTR	sys_io_setup
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
-- 
1.9.1
