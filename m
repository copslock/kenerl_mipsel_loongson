Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:32:23 +0200 (CEST)
Received: from mail-we0-f169.google.com ([74.125.82.169]:51545 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVcWcX736 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:32:22 +0200
Received: by mail-we0-f169.google.com with SMTP id u56so11209452wes.0
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gS1vrRtE2m3W4ttrkGRVvV5EqhxOuRXgCRgVy1zQ4o4=;
        b=PSfOiaAd2VzSGCU9aNKvelZs3THtots1LYAGKm9olgZ1fhBZfT46P21D9z9Y4zxPCu
         8RowyWp8Bt5oPYKq8DK+o7HRk3iTtgvyzMzypJtN3fn2wFdNGfnffndf66qK0Bc0vtJK
         ReUfyhARd9VEkHT5QnhzaG3duYgzYI6G6CdoN8Ego16t6eYl2X5lZPtx+6qAUGw50tUN
         8ogweGcWEIjZ6QVt4OY4kVxSg4ojYpTElh0wL20ErTEnVupnIgEJxL1OEjpITSddXokL
         oO0dXTputYAVnx3mvZfPfKnjdTFjXiZV7v6RQplWRjkg5DnbJSfYZXuWStt/dYu1xlgu
         66qA==
X-Received: by 10.180.20.105 with SMTP id m9mr17250097wie.35.1408563412124;
        Wed, 20 Aug 2014 12:36:52 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DBDE.dip0.t-ipconnect.de. [79.216.219.222])
        by mx.google.com with ESMTPSA id vn10sm60779177wjc.28.2014.08.20.12.36.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Aug 2014 12:36:51 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/4] MIPS: Alchemy: update cpu-feature-overrides
Date:   Wed, 20 Aug 2014 21:36:31 +0200
Message-Id: <1408563393-132515-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
References: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42179
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

More features the Au1 core definitely doesn't have.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index 09f45e6..c5b6eef 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -8,6 +8,12 @@
 #define __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
 
 #define cpu_has_tlb			1
+#define cpu_has_tlbinv			0
+#define cpu_has_segments		0
+#define cpu_has_eva			0
+#define cpu_has_htw			0
+#define cpu_has_rixiex			0
+#define cpu_has_maar			0
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
@@ -28,6 +34,8 @@
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
+#define cpu_has_rixi			0
+#define cpu_has_mmips			0
 #define cpu_has_vtag_icache		0
 #define cpu_has_dc_aliases		0
 #define cpu_has_ic_fills_f_dc		1
@@ -50,4 +58,8 @@
 #define cpu_dcache_line_size()		32
 #define cpu_icache_line_size()		32
 
+#define cpu_has_perf_cntr_intr_bit	0
+#define cpu_has_vz			0
+#define cpu_has_msa			0
+
 #endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
2.0.4
