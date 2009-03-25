Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:50:05 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.189]:18456 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28574601AbZCYQtf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:35 +0000
Received: by fk-out-0910.google.com with SMTP id f40so57636fka.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=4HJKymDtj38nF7peKX9QDZofsspvmO11HgoxKqxT/Q8=;
        b=asO+ndhG2MSmJ47wgneBH9iM88BqJFuQqk5C1bQQ3YRSCR2xOUuP8WxhcC3iIDUx8W
         7zEf/impIFo3cFPgZHKEeuP66cXyv/h+25/3xQvcrzY8smsKCK5ZXYOmK/WjMOZy5h5X
         6m6s2brZBjXzqBng4aG6yzZ0Likt3JQ2pJR9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=HUFdFihWI26buXJyW6hWf0xHlTTu3k/lm6JvZhcW2LirTngg1vCMq0gPpf0qanfFxQ
         3yV93A9WNrezj/8i//qfqBss3yK4YfKKT1CyO9PVGWyxJStFUo/u6XEdlH2kP+7IeaRn
         MAvLbuAmSYA4/xSIZrvDVHUokEKlkylJzFWnI=
Received: by 10.103.248.1 with SMTP id a1mr4285861mus.40.1237999774668;
        Wed, 25 Mar 2009 09:49:34 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:34 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/6] Alchemy: provide cpu feature overrides.
Date:	Wed, 25 Mar 2009 17:49:29 +0100
Message-Id: <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add cpu feature override constants tailored for all Alchemy variants
currently in existence.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 .../asm/mach-au1x00/cpu-feature-overrides.h        |   49 ++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
new file mode 100644
index 0000000..d5df0ca
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+#define cpu_has_dc_aliases		0
+#define cpu_has_ic_fills_f_dc		1
+#define cpu_has_mips32r1		1
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#define cpu_has_vint			0
+#define cpu_has_veic			0
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		32
+
+#endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.2
