Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:18:52 +0200 (CEST)
Received: from mail-qa0-f73.google.com ([209.85.216.73]:63006 "EHLO
        mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVSvmN3-e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:18:51 +0200
Received: by mail-qa0-f73.google.com with SMTP id s7so1328540qap.2
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggVoKVGB6B7gDWdoNAlbUllia6pZ7EEHSOfgE/2FP9E=;
        b=B9Mz2YbNixSUs7b9d4iKBE9gga9sMRTAlimeiS8svd36EQFP38umdSNo5fDjh1kaH7
         bp//F8fD705ZHZ2opGQDOQ1otua5uW+XQvLTRJl+d4dioquWG0Sys97vGPM1lcIipPwD
         RACw6ImvqKkGkLgyodSp59mbLjEUK7eDd2tn9L8W8vKnHanb9OcxTGj3bnSQ94ME+0cI
         wYcjneMzC8UTBUvsSPPuFvxX2Z1dxa5t4ecL+mU1iF0hjP4C3Y8kEJmSHs1Igm3loU5y
         ZEzS7CtxppoAKbDm6scxn4ARbWJllYRXyO7IcKcQBONKGIcxgy6cgnXpoWuWS/JDqjCc
         FIkA==
X-Gm-Message-State: ALoCoQlwr61/CrHY0n8BnwH95AaVnygV/S6/KyedKeoGe0tfmPWMbGNhej8heGWWZ7f4/OBuiZy5
X-Received: by 10.224.14.82 with SMTP id f18mr655694qaa.2.1408651494832;
        Thu, 21 Aug 2014 13:04:54 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si883612yhe.2.2014.08.21.13.04.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:54 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9966531C5D0;
        Thu, 21 Aug 2014 13:04:54 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 5C1A8220378; Thu, 21 Aug 2014 13:04:54 -0700 (PDT)
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
Subject: [PATCH 7/7] MIPS: ralink: Move device-trees to arch/mips/boot/dts/
Date:   Thu, 21 Aug 2014 13:04:26 -0700
Message-Id: <1408651466-8334-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42178
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

Move the Ralink device-trees to arch/mips/boot/dts/ and update the
Makefiles accordingly.  A built-in device-tree is optional, so select
BUILTIN_DTB when it is requested.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/boot/dts/Makefile                     | 4 ++++
 arch/mips/{ralink => boot}/dts/mt7620a.dtsi     | 0
 arch/mips/{ralink => boot}/dts/mt7620a_eval.dts | 0
 arch/mips/{ralink => boot}/dts/rt2880.dtsi      | 0
 arch/mips/{ralink => boot}/dts/rt2880_eval.dts  | 0
 arch/mips/{ralink => boot}/dts/rt3050.dtsi      | 0
 arch/mips/{ralink => boot}/dts/rt3052_eval.dts  | 0
 arch/mips/{ralink => boot}/dts/rt3883.dtsi      | 0
 arch/mips/{ralink => boot}/dts/rt3883_eval.dts  | 0
 arch/mips/ralink/Kconfig                        | 4 ++++
 arch/mips/ralink/Makefile                       | 2 --
 arch/mips/ralink/dts/Makefile                   | 4 ----
 12 files changed, 8 insertions(+), 6 deletions(-)
 rename arch/mips/{ralink => boot}/dts/mt7620a.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/mt7620a_eval.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt2880.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt2880_eval.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt3050.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt3052_eval.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt3883.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt3883_eval.dts (100%)
 delete mode 100644 arch/mips/ralink/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 1638a38..ca9c90e 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -4,6 +4,10 @@ dtb-$(CONFIG_DT_XLP_EVP)		+= xlp_evp.dtb
 dtb-$(CONFIG_DT_XLP_SVP)		+= xlp_svp.dtb
 dtb-$(CONFIG_DT_XLP_FVP)		+= xlp_fvp.dtb
 dtb-$(CONFIG_DT_XLP_GVP)		+= xlp_gvp.dtb
+dtb-$(CONFIG_DTB_RT2880_EVAL)		+= rt2880_eval.dtb
+dtb-$(CONFIG_DTB_RT305X_EVAL)		+= rt3052_eval.dtb
+dtb-$(CONFIG_DTB_RT3883_EVAL)		+= rt3883_eval.dtb
+dtb-$(CONFIG_DTB_MT7620A_EVAL)		+= mt7620a_eval.dtb
 dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/ralink/dts/mt7620a.dtsi b/arch/mips/boot/dts/mt7620a.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/mt7620a.dtsi
rename to arch/mips/boot/dts/mt7620a.dtsi
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/boot/dts/mt7620a_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/mt7620a_eval.dts
rename to arch/mips/boot/dts/mt7620a_eval.dts
diff --git a/arch/mips/ralink/dts/rt2880.dtsi b/arch/mips/boot/dts/rt2880.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt2880.dtsi
rename to arch/mips/boot/dts/rt2880.dtsi
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/boot/dts/rt2880_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt2880_eval.dts
rename to arch/mips/boot/dts/rt2880_eval.dts
diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/boot/dts/rt3050.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt3050.dtsi
rename to arch/mips/boot/dts/rt3050.dtsi
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/boot/dts/rt3052_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt3052_eval.dts
rename to arch/mips/boot/dts/rt3052_eval.dts
diff --git a/arch/mips/ralink/dts/rt3883.dtsi b/arch/mips/boot/dts/rt3883.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt3883.dtsi
rename to arch/mips/boot/dts/rt3883.dtsi
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/boot/dts/rt3883_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt3883_eval.dts
rename to arch/mips/boot/dts/rt3883_eval.dts
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 4a29665..77e8a96 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -42,18 +42,22 @@ choice
 	config DTB_RT2880_EVAL
 		bool "RT2880 eval kit"
 		depends on SOC_RT288X
+		select BUILTIN_DTB
 
 	config DTB_RT305X_EVAL
 		bool "RT305x eval kit"
 		depends on SOC_RT305X
+		select BUILTIN_DTB
 
 	config DTB_RT3883_EVAL
 		bool "RT3883 eval kit"
 		depends on SOC_RT3883
+		select BUILTIN_DTB
 
 	config DTB_MT7620A_EVAL
 		bool "MT7620A eval kit"
 		depends on SOC_MT7620
+		select BUILTIN_DTB
 
 endchoice
 
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 98ae349..2c09c8a 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -16,5 +16,3 @@ obj-$(CONFIG_SOC_RT3883) += rt3883.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
-
-obj-y += dts/
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
deleted file mode 100644
index 18194fa..0000000
--- a/arch/mips/ralink/dts/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
-obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
-obj-$(CONFIG_DTB_RT3883_EVAL) := rt3883_eval.dtb.o
-obj-$(CONFIG_DTB_MT7620A_EVAL) := mt7620a_eval.dtb.o
-- 
2.1.0.rc2.206.gedb03e5
