Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 05:16:20 +0200 (CEST)
Received: from mail-qc0-f201.google.com ([209.85.216.201]:52719 "EHLO
        mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007146AbaH1DQNgbqhN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 05:16:13 +0200
Received: by mail-qc0-f201.google.com with SMTP id c9so140459qcz.2
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 20:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tzT2q52+Hadii1roUycXQ4yAI05DZzf6kBZ2IR7VJDI=;
        b=loKzdFytaV1EH9K7mKsdMk5QGriwX8Tx5tK4iZ4fhZ5pEzCQbsbNLDFkcYuz0Wa9+a
         L6j6yY38IAbTQDhaNsCs8VRVLI33mlH6CgKNIiknMcYmcIkSalSapH5N09084UEVY11d
         8IZx0J2gCzeoUFCNMu99/Qr3G0g4MJbhxirdykg+wtsqELiZ8lT3AgIbVGBy+VnIB8Sz
         YswknWEnoN0E/jA5kD8Mv3UPiJqK8kSEMnZ6l9bIKM+uUzIsSlBLgoeWicl/8VWvre3K
         5LI6VwjUwJPuqUsXroVyuHSpwCG9GsLJum5HFB9PTgQYdRonZkE912jpKTkxsdS3iauR
         +3UA==
X-Gm-Message-State: ALoCoQmB2RG9DVAh9woSHl81xBDM2rSpaKU0JbSOjchcDM3bRpidn16FFc2b72lZf5UYESBOF1oe
X-Received: by 10.236.28.228 with SMTP id g64mr556509yha.40.1409195767473;
        Wed, 27 Aug 2014 20:16:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j25si154214yhb.0.2014.08.27.20.16.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 20:16:07 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5089A2F4044;
        Wed, 27 Aug 2014 19:10:19 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 10626221121; Wed, 27 Aug 2014 19:10:19 -0700 (PDT)
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
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH v2 6/7] MIPS: Netlogic: Move device-trees to arch/mips/boot/dts/netlogic/
Date:   Wed, 27 Aug 2014 19:10:11 -0700
Message-Id: <1409191812-23697-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42298
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

Move the Netlogic XLP device-trees to arch/mips/boot/dts/netlogic/ and
update the Makefiles accordingly.  A built-in device-tree is optional,
so select BUILTIN_DTB when it is requested.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/boot/dts/Makefile                               | 1 +
 arch/mips/boot/dts/netlogic/Makefile                      | 4 ++++
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_evp.dts | 0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_fvp.dts | 0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_gvp.dts | 0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_svp.dts | 0
 arch/mips/netlogic/Kconfig                                | 4 ++++
 arch/mips/netlogic/Makefile                               | 1 -
 arch/mips/netlogic/dts/Makefile                           | 4 ----
 9 files changed, 9 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/boot/dts/netlogic/Makefile
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_evp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_fvp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_gvp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_svp.dts (100%)
 delete mode 100644 arch/mips/netlogic/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index e32cc0f..a861be5 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,6 +1,7 @@
 include arch/mips/boot/dts/cavium-octeon/Makefile
 include arch/mips/boot/dts/lantiq/Makefile
 include arch/mips/boot/dts/mti/Makefile
+include arch/mips/boot/dts/netlogic/Makefile
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
new file mode 100644
index 0000000..d15f045
--- /dev/null
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -0,0 +1,4 @@
+dtb-$(CONFIG_DT_XLP_EVP)	+= netlogic/xlp_evp.dtb
+dtb-$(CONFIG_DT_XLP_SVP)	+= netlogic/xlp_svp.dtb
+dtb-$(CONFIG_DT_XLP_FVP)	+= netlogic/xlp_fvp.dtb
+dtb-$(CONFIG_DT_XLP_GVP)	+= netlogic/xlp_gvp.dtb
diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/boot/dts/netlogic/xlp_evp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_evp.dts
rename to arch/mips/boot/dts/netlogic/xlp_evp.dts
diff --git a/arch/mips/netlogic/dts/xlp_fvp.dts b/arch/mips/boot/dts/netlogic/xlp_fvp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_fvp.dts
rename to arch/mips/boot/dts/netlogic/xlp_fvp.dts
diff --git a/arch/mips/netlogic/dts/xlp_gvp.dts b/arch/mips/boot/dts/netlogic/xlp_gvp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_gvp.dts
rename to arch/mips/boot/dts/netlogic/xlp_gvp.dts
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/boot/dts/netlogic/xlp_svp.dts
similarity index 100%
rename from arch/mips/netlogic/dts/xlp_svp.dts
rename to arch/mips/boot/dts/netlogic/xlp_svp.dts
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
