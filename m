Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 15:23:06 +0100 (CET)
Received: from forward104p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:107]:56071
        "EHLO forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeCVOWxGDR0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 15:22:53 +0100
Received: from mxback13g.mail.yandex.net (mxback13g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:92])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 0169518156E;
        Thu, 22 Mar 2018 17:22:44 +0300 (MSK)
Received: from smtp2j.mail.yandex.net (smtp2j.mail.yandex.net [2a02:6b8:0:801::ac])
        by mxback13g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 76Wx9YVV7Z-MghOisSg;
        Thu, 22 Mar 2018 17:22:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521728563;
        bh=YaSs9b9ptC4WtxYjfgT3DVrGhb5oD8xpJjyQFLPo78o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=CaRf5sFMSFNX3nwO2U1Dy7O9FJwD+LZXd0qsVlJYY2zm2eFS97oO+BX6XHnC6baId
         DIATEKVfj/tfmuP7+ZLoC5vUeQ0/nK8+C/qly3FkgE4zEvQRJ32PDBgtLsjemXHJjK
         VKU1G1H4PMTV/eCPeg6f7Z+5t0+56HBMuzNxxPS8=
Received: by smtp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xanZbOtqWb-MXvOUmmF;
        Thu, 22 Mar 2018 17:22:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521728561;
        bh=YaSs9b9ptC4WtxYjfgT3DVrGhb5oD8xpJjyQFLPo78o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=DC3Wg3Li/qEwuVWRzYTEOlrmKfvxTXYAYtMM1fFLCZkqoOUkBUQo7b9oojnfKshlq
         pQSBcwb4QHsBRfXfBRTNeYcHV1TJ1kFHv0tgVAEs0y5SK2ywPSuiYWA1Bs6j1nEtWN
         YGtxAsaL4g5MlabK+3hgv8Gi7gFlSiUIqZx+3eA4=
Authentication-Results: smtp2j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     jhogan@kernel.org
Cc:     chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/2] MIPS: Loongson64: Define has_cpu_mips*r2_user for Loongson-3
Date:   Thu, 22 Mar 2018 22:22:15 +0800
Message-Id: <20180322142215.7705-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322142215.7705-1-jiaxun.yang@flygoat.com>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
 <20180322142215.7705-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

All loongson-3 processors support mips32r2 mips64r2 usermode instructions.
However 3A1000 3B1000 3B1500 should be treated as r1 in kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 581915ce231c..71c893249374 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -49,6 +49,8 @@
 #define cpu_has_wsbh		1
 #define cpu_has_ic_fills_f_dc	1
 #define cpu_hwrena_impl_bits	0xc0000000
+#define cpu_has_mips32r2_user  1
+#define cpu_has_mips64r2_user  1
 #endif
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
-- 
2.16.2
