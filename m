Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 09:44:53 +0100 (CET)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:42492
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994564AbeK2IoqAfjhm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 09:44:46 +0100
Received: by mail-pg1-x544.google.com with SMTP id d72so605099pga.9
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 00:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=I6KuxEJcuwNeGPJjY2lgWumxqYUkkEh7Fg7DnYJSet12289NwLHveMP3NpcO0poyib
         Zbkyfcr7pFzlM6c/mE76P+hFFogxGE/ec8bXGHT80Z8kSg6XjQP/Se6VmnBd+sfvzEuZ
         f0NU/Of0dT3Kr0AtWM3/BgDGCdnVL7G7WjRl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=b43V/N3jn4C7tTBfymRHhcL1Tqqa47VeDJqwPgeSQ5xh022cSTQIgnb4rYR5xHgt5E
         a1B8eU6OY3dNZ7ZbYHz2oAkuKEynTrT04nWROlZ3WFLU3nhhWuSGRHcXU07PRt+jooCZ
         nJ3Thq6plQ0sLV/SPp9hf1Qzq3FYs8RFH8hPYpStKuNxDzHHyxhvaGf1FEV28RDVDezJ
         K1x+AZJW0OfPhuUTxnSn0I3SF2bNR+vNkwu5pWNyvlyJhddQqEcCR7Y4COT2L+QVMPsv
         HyEFIAbC/EUgtx2jC9maI935dn1eJhMpSK/VPNgtudvkxQ8oWKZc32wndJyb4EXK2b0Q
         gOlg==
X-Gm-Message-State: AA+aEWblPs3T/A42t6/iuBnfwJ3y08VpLbyLPmTxMnf0aVZRHcDFck6a
        S0hJjbvi1a8TqDCodc9/7h9XTgPBKX8=
X-Google-Smtp-Source: AFSGD/VBobjmhYHkrBHvaIGHNNaNy0pGaPBMBEG+VvEQ6tcCEl/O+7JEsnb52tOza6fdn5hACbtoTA==
X-Received: by 2002:a63:2406:: with SMTP id k6mr455347pgk.229.1543481085000;
        Thu, 29 Nov 2018 00:44:45 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:44 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 4/6] mips: remove syscall table entries
Date:   Thu, 29 Nov 2018 14:13:34 +0530
Message-Id: <1543481016-18500-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67541
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
index 10f6367..43fa5cd 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -205,6 +205,18 @@ einval: li	v0, -ENOSYS
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
+#define sys_sched_setaffinity	mipsmt_sys_sched_setaffinity
+#define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -447,20 +459,8 @@ EXPORT(sys_call_table)
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
