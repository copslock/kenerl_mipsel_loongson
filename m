Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:04:24 +0200 (CEST)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:62762 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVEUEfVq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:04:20 +0200
Received: by mail-qg0-f73.google.com with SMTP id i50so863544qgf.2
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbDtgRFanwH6oNav45Q5rT7RSS1r5Mn3PXuIDW8UzkQ=;
        b=I4ibsGsI9DAT3dklhOxi9xWH0P2cLHn9gSW5H/YKLXeO0gNWsOBjPX7KBc/Gf/48MT
         8tneiDfKB0DgXiepilkXRvkw1LC5OqPjrDSzGIuP6x76LYh1oaWis8vrJAgD6J+awgok
         PgC2irmFTHFEtnuG1KA1/SPqyiXgSg7Zft3U7U+YoYofTE+Le1F4cG8UybTPK1kbda8f
         noRaYCvH1/YmTbxZuLjhcahLsW8J8S6zv8SNEsMlbK7hAO7IQ44FblpbZTON37Y8ryUL
         FWVpbAV5wC9OFfLpLhAbxS2HFRg/ExyQk5SVBx6S6dSXBKTkiMbPVzmQKD1W37+rvrA8
         6w1w==
X-Gm-Message-State: ALoCoQkGB/5nnOTWxMwdlxcH0nVVEea1tx6mPzWpVem9LnYeFLcRn9cHuOy2JgK7AuYSddSat/RN
X-Received: by 10.236.61.36 with SMTP id v24mr604035yhc.24.1408651493567;
        Thu, 21 Aug 2014 13:04:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si887244yhg.0.2014.08.21.13.04.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:53 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4B8F931C5DE;
        Thu, 21 Aug 2014 13:04:53 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0EA9C220378; Thu, 21 Aug 2014 13:04:53 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 6/7] MIPS: Netlogic: Move device-trees to arch/mips/boot/dts/
Date:   Thu, 21 Aug 2014 13:04:25 -0700
Message-Id: <1408651466-8334-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42176
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

Move the Netlogic XLP device-trees to arch/mips/boot/dts/ and update the
Makefiles accordingly.  A built-in device-tree is optional, so select
BUILTIN_DTB when it is requested.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/boot/dts/Makefile                  | 4 ++++
 arch/mips/{netlogic => boot}/dts/xlp_evp.dts | 0
 arch/mips/{netlogic => boot}/dts/xlp_fvp.dts | 0
 arch/mips/{netlogic => boot}/dts/xlp_gvp.dts | 0
 arch/mips/{netlogic => boot}/dts/xlp_svp.dts | 0
 arch/mips/netlogic/Kconfig                   | 4 ++++
 arch/mips/netlogic/Makefile                  | 1 -
 arch/mips/netlogic/dts/Makefile              | 4 ----
 8 files changed, 8 insertions(+), 5 deletions(-)
 rename arch/mips/{netlogic => boot}/dts/xlp_evp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_fvp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_gvp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_svp.dts (100%)
 delete mode 100644 arch/mips/netlogic/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 8df3d3e..1638a38 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,9 @@
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
 dtb-$(CONFIG_DT_EASY50712)		+= easy50712.dtb
+dtb-$(CONFIG_DT_XLP_EVP)		+= xlp_evp.dtb
+dtb-$(CONFIG_DT_XLP_SVP)		+= xlp_svp.dtb
+dtb-$(CONFIG_DT_XLP_FVP)		+= xlp_fvp.dtb
+dtb-$(CONFIG_DT_XLP_GVP)		+= xlp_gvp.dtb
 dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/boot/dts/xlp_evp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_evp.dts
rename to arch/mips/boot/dts/xlp_evp.dts
diff --git a/arch/mips/netlogic/dts/xlp_fvp.dts b/arch/mips/boot/dts/xlp_fvp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_fvp.dts
rename to arch/mips/boot/dts/xlp_fvp.dts
diff --git a/arch/mips/netlogic/dts/xlp_gvp.dts b/arch/mips/boot/dts/xlp_gvp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_gvp.dts
rename to arch/mips/boot/dts/xlp_gvp.dts
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/boot/dts/xlp_svp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_svp.dts
rename to arch/mips/boot/dts/xlp_svp.dts
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 4eb683a..0823321 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -4,6 +4,7 @@ if NLM_XLP_BOARD
 config DT_XLP_EVP
 	bool "Built-in device tree for XLP EVP boards"
 	default y
+	select BUILTIN_DTB
 	help
 	  Add an FDT blob for XLP EVP boards into the kernel.
 	  This DTB will be used if the firmware does not pass in a DTB
@@ -13,6 +14,7 @@ config DT_XLP_EVP
 config DT_XLP_SVP
 	bool "Built-in device tree for XLP SVP boards"
 	default y
+	select BUILTIN_DTB
 	help
 	  Add an FDT blob for XLP VP boards into the kernel.
 	  This DTB will be used if the firmware does not pass in a DTB
@@ -22,6 +24,7 @@ config DT_XLP_SVP
 config DT_XLP_FVP
 	bool "Built-in device tree for XLP FVP boards"
 	default y
+	select BUILTIN_DTB
 	help
 	  Add an FDT blob for XLP FVP board into the kernel.
 	  This DTB will be used if the firmware does not pass in a DTB
@@ -31,6 +34,7 @@ config DT_XLP_FVP
 config DT_XLP_GVP
 	bool "Built-in device tree for XLP GVP boards"
 	default y
+	select BUILTIN_DTB
 	help
 	  Add an FDT blob for XLP GVP board into the kernel.
 	  This DTB will be used if the firmware does not pass in a DTB
diff --git a/arch/mips/netlogic/Makefile b/arch/mips/netlogic/Makefile
index 7602d13..36d169b 100644
--- a/arch/mips/netlogic/Makefile
+++ b/arch/mips/netlogic/Makefile
@@ -1,4 +1,3 @@
 obj-$(CONFIG_NLM_COMMON)	+=	common/
 obj-$(CONFIG_CPU_XLR)		+=	xlr/
 obj-$(CONFIG_CPU_XLP)		+=	xlp/
-obj-$(CONFIG_CPU_XLP)		+=	dts/
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
deleted file mode 100644
index 25c8e87..0000000
--- a/arch/mips/netlogic/dts/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
-obj-$(CONFIG_DT_XLP_SVP) += xlp_svp.dtb.o
-obj-$(CONFIG_DT_XLP_FVP) += xlp_fvp.dtb.o
-obj-$(CONFIG_DT_XLP_GVP) += xlp_gvp.dtb.o
-- 
2.1.0.rc2.206.gedb03e5
