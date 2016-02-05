Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:44:47 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35227 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014896AbcBEAnV4bASl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:21 +0100
Received: by mail-pf0-f193.google.com with SMTP id 66so4492267pfe.2;
        Thu, 04 Feb 2016 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PEtgbWrapkOYgkvfHT8gAZtSZI9s1sqiHl2RzdJYTWQ=;
        b=EC5L2VC78PZxLBV0eOzBoCADZQFWauWmldqh+io7mjFzReFGe2JViofF0ZAlvV7/YY
         OXJcuiv4riogy839bjZc+Aug2VKrui7CK40R4RLUwSLvvZGFutJ6fJ/gRptecAo3Ap6X
         IZWctaBbcBQOufX+w4ObkGiQdFATbVpCAKzdu1pbGtG3srj3ryP8lxMSZVodHeyj36Ue
         Hg4/kNJtfwma5p4Dc1diV3IfuOIoTXiqCZQaf6eBgjXCY5YHlQiqhwGAWAGFcFkcmBpG
         tHmSoMdVp1rQPI6FDIbcQL1j8WR8kqJmFobmwWitIxf4/pajr+HmWSZ5MD395i/eqXgn
         cuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PEtgbWrapkOYgkvfHT8gAZtSZI9s1sqiHl2RzdJYTWQ=;
        b=Mb98UERekmY7dbT4ngKmg5KaL4Lv/fSINg0tzqlGUsspaOMabPaY0lHJAqvy63AI8F
         hH+ccB8dfSkp288M3nV7ECcJ/0AgjtAa/uF1Kr6TVsLD0jQbI/hL/QKSD6PW6xyNNf1y
         j/yZOUc9cVk6e2NGQgwFvtzxSZ/ZCzro8CPgU0tfprKiFs4ewqhDnWiu8kjWm+jptr5G
         j3tHXblWOeaAzmKbvflLVrv9vEN1scQNjMsJxn8bEEBlIayfuapbv5VC33w/oTmnaVH1
         LtAIUxlg94/m/ywcG53GoVgWsGHEZshdMGuCqb0FaSP8mPm+9CJVB1iRcdHDytGIbnXh
         Nfeg==
X-Gm-Message-State: AG10YOR0wc0WRe0jGVZwjm4JTY7KvXZBk1Ia+taQmgxGI6ROwWQptYgDWxsBFvzA70TZ2g==
X-Received: by 10.98.0.135 with SMTP id 129mr15689553pfa.156.1454632996338;
        Thu, 04 Feb 2016 16:43:16 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id c9sm19717420pfd.90.2016.02.04.16.43.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h49I007747;
        Thu, 4 Feb 2016 16:43:04 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h4t9007746;
        Thu, 4 Feb 2016 16:43:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 5/7] MIPS: OCTEON: Don't attempt to use nonexistent registers on OCTEON III models.
Date:   Thu,  4 Feb 2016 16:42:52 -0800
Message-Id: <1454632974-7686-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Attempts to read the nonexistent registers results in bus errors.
Either use registers that exist, or don't do the access as appropriate.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c | 13 +++++++++----
 arch/mips/cavium-octeon/setup.c       | 34 +++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 1882e64..23c2344 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -19,6 +19,7 @@
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-fpa-defs.h>
 
 static u64 f;
 static u64 rdiv;
@@ -65,9 +66,13 @@ void __init octeon_setup_delays(void)
  */
 void octeon_init_cvmcount(void)
 {
+	u64 clk_reg;
 	unsigned long flags;
 	unsigned loops = 2;
 
+	clk_reg = octeon_has_feature(OCTEON_FEATURE_FPA3) ?
+		CVMX_FPA_CLK_COUNT : CVMX_IPD_CLK_COUNT;
+
 	/* Clobber loops so GCC will not unroll the following while loop. */
 	asm("" : "+r" (loops));
 
@@ -77,18 +82,18 @@ void octeon_init_cvmcount(void)
 	 * which should give more deterministic timing.
 	 */
 	while (loops--) {
-		u64 ipd_clk_count = cvmx_read_csr(CVMX_IPD_CLK_COUNT);
+		u64 clk_count = cvmx_read_csr(clk_reg);
 		if (rdiv != 0) {
-			ipd_clk_count *= rdiv;
+			clk_count *= rdiv;
 			if (f != 0) {
 				asm("dmultu\t%[cnt],%[f]\n\t"
 				    "mfhi\t%[cnt]"
-				    : [cnt] "+r" (ipd_clk_count)
+				    : [cnt] "+r" (clk_count)
 				    : [f] "r" (f)
 				    : "hi", "lo");
 			}
 		}
-		write_c0_cvmcount(ipd_clk_count);
+		write_c0_cvmcount(clk_count);
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 9c6ad2f..54a214e 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -492,8 +492,6 @@ const char *get_system_type(void)
 void octeon_user_io_init(void)
 {
 	union octeon_cvmemctl cvmmemctl;
-	union cvmx_iob_fau_timeout fau_timeout;
-	union cvmx_pow_nw_tim nm_tim;
 
 	/* Get the current settings for CP0_CVMMEMCTL_REG */
 	cvmmemctl.u64 = read_c0_cvmmemctl();
@@ -595,17 +593,27 @@ void octeon_user_io_init(void)
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
 
-	/* Set a default for the hardware timeouts */
-	fau_timeout.u64 = 0;
-	fau_timeout.s.tout_val = 0xfff;
-	/* Disable tagwait FAU timeout */
-	fau_timeout.s.tout_enb = 0;
-	cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_timeout.u64);
-
-	nm_tim.u64 = 0;
-	/* 4096 cycles */
-	nm_tim.s.nw_tim = 3;
-	cvmx_write_csr(CVMX_POW_NW_TIM, nm_tim.u64);
+	if (octeon_has_feature(OCTEON_FEATURE_FAU)) {
+		union cvmx_iob_fau_timeout fau_timeout;
+
+		/* Set a default for the hardware timeouts */
+		fau_timeout.u64 = 0;
+		fau_timeout.s.tout_val = 0xfff;
+		/* Disable tagwait FAU timeout */
+		fau_timeout.s.tout_enb = 0;
+		cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_timeout.u64);
+	}
+
+	if ((!OCTEON_IS_MODEL(OCTEON_CN68XX) &&
+	     !OCTEON_IS_MODEL(OCTEON_CN7XXX)) ||
+	    OCTEON_IS_MODEL(OCTEON_CN70XX)) {
+		union cvmx_pow_nw_tim nm_tim;
+
+		nm_tim.u64 = 0;
+		/* 4096 cycles */
+		nm_tim.s.nw_tim = 3;
+		cvmx_write_csr(CVMX_POW_NW_TIM, nm_tim.u64);
+	}
 
 	write_octeon_c0_icacheerr(0);
 	write_c0_derraddr1(0);
-- 
1.7.11.7
