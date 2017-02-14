Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 13:04:30 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:34133
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdBNMDkSTsSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 13:03:40 +0100
Received: by mail-wr0-x241.google.com with SMTP id c4so1832357wrd.1;
        Tue, 14 Feb 2017 04:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17BSlvTcLZOJlfIR9pOwO070+WM0i14rMT5lnpLPrdw=;
        b=CdThbo6mfGp0qtLi0ly5z36Mxqjke8BSK9F4A8K7F2BG4CFyAxZ9kP1gHJTxGLwv6l
         +fxZ5JatTnAqWFjZUkBmlSsjWnWd55nF5V04/1kT43IiLBD2cahbvnYo432/lhTa3EYa
         aZtK54Oj2DCYhKLjjlyAy1kbI387rgqnNosx9+pBbOmHs0rMvlztK8x7rlqCaKGsMpc/
         kl/UyZnKqFoVRI3CwwhenxrA8jYKtAsEId23FV7ZEw7wypY1qAfs5cezUhyTfi4RSdun
         yEeX7tinKYmUFct9Dx3Kh/GkdlVdfkFuTmiHxRVeM7J+2zKl5wiypYkKvqN8mwmY9XtV
         8FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=17BSlvTcLZOJlfIR9pOwO070+WM0i14rMT5lnpLPrdw=;
        b=CfLk5Hd9G2SUUjFrlFVudv65ZfxXp3sv2oO64pIyGm1s7QjlMT465WNq4IkAU2mzRp
         4ORTJPghccK8ZZhsg1kEFFUU7MtjX8xECHXJFqjn85m5rcx/4LjbJ2PyzCpJ0LiGyaDW
         gjjreAEfVmWif2ZO+S7G2TFuqbMdAbTgcPaYTEIKqOpISQZkNaRKsld2KFvnC3PN0cuY
         bNYGxDtK6sMdPywaWiPP2zdml52ZAq6Sp93kn4sWiikMBqQ9emwFqmdPUOEHErpbY6PA
         swDAYzAu6uXETQFRiB3rrLadSDsbzv6GrWD69X9z2ibNgNH9tY+SCWBVl8zfDjqNo5wD
         INQA==
X-Gm-Message-State: AMke39mkUdjGojpwgEb2AHI4FBu5yPiGFHuxVpTC5jSAXrOLtjc/gtPfKRwLIGnIS4rOcg==
X-Received: by 10.223.136.205 with SMTP id g13mr2713264wrg.56.1487073814999;
        Tue, 14 Feb 2017 04:03:34 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_05_020 (p200300C023CC14391746B39401FFCB78.dip0.t-ipconnect.de. [2003:c0:23cc:1439:1746:b394:1ff:cb78])
        by smtp.gmail.com with ESMTPSA id e71sm1030339wma.8.2017.02.14.04.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 04:03:34 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: update cpu feature overrides
Date:   Tue, 14 Feb 2017 13:03:27 +0100
Message-Id: <20170214120328.240326-3-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170214120328.240326-1-manuel.lauss@gmail.com>
References: <20170214120328.240326-1-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

No advanced MIPS features for Alchemy.
This patch shaves additional 43kB off the DB1300 kernel
(~0.5% size reduction).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 .../asm/mach-au1x00/cpu-feature-overrides.h        | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index c5b6eef0efa7..7d720aa3bc8b 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -8,12 +8,16 @@
 #define __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
 
 #define cpu_has_tlb			1
+#define cpu_has_ftlb			0
 #define cpu_has_tlbinv			0
 #define cpu_has_segments		0
 #define cpu_has_eva			0
 #define cpu_has_htw			0
+#define cpu_has_ldpte			0
 #define cpu_has_rixiex			0
 #define cpu_has_maar			0
+#define cpu_has_rw_llb			0
+#define cpu_has_3kex			0
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
@@ -30,23 +34,35 @@
 #define cpu_has_mcheck			1
 #define cpu_has_ejtag			1
 #define cpu_has_llsc			1
+#define cpu_has_guestctl0ext		0
+#define cpu_has_guestctl1		0
+#define cpu_has_guestctl2		0
+#define cpu_has_guestid			0
+#define cpu_has_drg			0
+#define cpu_has_bp_ghist		0
 #define cpu_has_mips16			0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
 #define cpu_has_rixi			0
 #define cpu_has_mmips			0
+#define cpu_has_lpa			0
+#define cpu_has_mhv			0
 #define cpu_has_vtag_icache		0
 #define cpu_has_dc_aliases		0
 #define cpu_has_ic_fills_f_dc		1
 #define cpu_has_pindexed_dcache		0
 #define cpu_has_mips32r1		1
 #define cpu_has_mips32r2		0
+#define cpu_has_mips32r6		0
 #define cpu_has_mips64r1		0
 #define cpu_has_mips64r2		0
+#define cpu_has_mips64r6		0
 #define cpu_has_dsp			0
 #define cpu_has_dsp2			0
+#define cpu_has_dsp3			0
 #define cpu_has_mipsmt			0
+#define cpu_has_vp			0
 #define cpu_has_userlocal		0
 #define cpu_has_nofpuex			0
 #define cpu_has_64bits			0
@@ -57,9 +73,19 @@
 
 #define cpu_dcache_line_size()		32
 #define cpu_icache_line_size()		32
+#define cpu_scache_line_size()		0
 
 #define cpu_has_perf_cntr_intr_bit	0
 #define cpu_has_vz			0
 #define cpu_has_msa			0
+#define cpu_has_fre			0
+#define cpu_has_cdmm			0
+#define cpu_has_small_pages		0
+#define cpu_has_nan_legacy		1
+#define cpu_has_nan_2008		1
+#define cpu_has_ebase_wg		0
+#define cpu_has_badinstr		0
+#define cpu_has_badinstrp		0
+#define cpu_has_contextconfig		0
 
 #endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
2.11.1
