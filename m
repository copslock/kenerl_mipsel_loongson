Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 15:30:17 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:58218 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007408AbaH2NaMDetcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 15:30:12 +0200
Received: by mail-pd0-f201.google.com with SMTP id g10so195322pdj.0
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 06:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CD83U2jorB9rXfO9lYI5wOO8TdMqpL+KYCWwgA2U2W4=;
        b=dHZ4hSEealfwu/IRCYmz72V5zRQMB6N4oRHhR7t7gaI+ty78f/58ipC+taAlA9UZkc
         jYWcXVAQOO0y1N77dwHN/xytFLajeNGElqJDTfbK6nIKgk9/kPfXWZAKEOruXLyelIxE
         YK7ybLEU6ARd6mekP2zBkLIx9Hy4qwwlbCdlwCtHc/V8dF2PehZPhx7ckZLGqo/nJqCj
         5hP2Pu0njsSNeytetZOucLNrmnc+szgCqDI99sS5V1WXPtZG+LtBq0T0p6A7yi2H8Xb+
         E1l/r2b1YXURpNMvLxB8H6tFzw+jEYSIx96bd23lN5MHgiW8b5imsB0ilKzKRgy4e26A
         nyGA==
X-Gm-Message-State: ALoCoQlD+gCCK8D9wdPuO4/F2XWjtomXbFZlKo6UkT8FKjXhD/GLBjixFlw8PV6MHsWw4cc5rThy
X-Received: by 10.70.37.41 with SMTP id v9mr5823440pdj.0.1409319000800;
        Fri, 29 Aug 2014 06:30:00 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id m14si391988yhm.7.2014.08.29.06.30.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 06:30:00 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ACF29310296;
        Thu, 28 Aug 2014 20:57:03 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 691DD220E9D; Thu, 28 Aug 2014 20:57:03 -0700 (PDT)
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
Subject: [PATCH v2 7/7] MIPS: ralink: Move device-trees to arch/mips/boot/dts/ralink/
Date:   Thu, 28 Aug 2014 20:56:59 -0700
Message-Id: <1409284619-6910-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42320
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

Move the Ralink device-trees to arch/mips/boot/dts/ralink/ and update
the Makefiles accordingly.  A built-in device-tree is optional, so
select BUILTIN_DTB when it is requested.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Looks like this one didn't make it through the first time.
---
 arch/mips/boot/dts/Makefile                                | 1 +
 arch/mips/boot/dts/ralink/Makefile                         | 4 ++++
 arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a.dtsi     | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a_eval.dts | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt2880.dtsi      | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt2880_eval.dts  | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3050.dtsi      | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3052_eval.dts  | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3883.dtsi      | 0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3883_eval.dts  | 0
 arch/mips/ralink/Kconfig                                   | 4 ++++
 arch/mips/ralink/Makefile                                  | 2 --
 arch/mips/ralink/dts/Makefile                              | 4 ----
 13 files changed, 9 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/boot/dts/ralink/Makefile
 rename arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt2880.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt2880_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3050.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3052_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3883.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3883_eval.dts (100%)
 delete mode 100644 arch/mips/ralink/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index a861be5..47406f7 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -2,6 +2,7 @@ include arch/mips/boot/dts/cavium-octeon/Makefile
 include arch/mips/boot/dts/lantiq/Makefile
 include arch/mips/boot/dts/mti/Makefile
 include arch/mips/boot/dts/netlogic/Makefile
+include arch/mips/boot/dts/ralink/Makefile
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
new file mode 100644
index 0000000..81a567e
--- /dev/null
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -0,0 +1,4 @@
+dtb-$(CONFIG_DTB_RT2880_EVAL)	+= ralink/rt2880_eval.dtb
+dtb-$(CONFIG_DTB_RT305X_EVAL)	+= ralink/rt3052_eval.dtb
+dtb-$(CONFIG_DTB_RT3883_EVAL)	+= ralink/rt3883_eval.dtb
+dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= ralink/mt7620a_eval.dtb
diff --git a/arch/mips/ralink/dts/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/mt7620a.dtsi
rename to arch/mips/boot/dts/ralink/mt7620a.dtsi
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/boot/dts/ralink/mt7620a_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/mt7620a_eval.dts
rename to arch/mips/boot/dts/ralink/mt7620a_eval.dts
diff --git a/arch/mips/ralink/dts/rt2880.dtsi b/arch/mips/boot/dts/ralink/rt2880.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt2880.dtsi
rename to arch/mips/boot/dts/ralink/rt2880.dtsi
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/boot/dts/ralink/rt2880_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt2880_eval.dts
rename to arch/mips/boot/dts/ralink/rt2880_eval.dts
diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/boot/dts/ralink/rt3050.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt3050.dtsi
rename to arch/mips/boot/dts/ralink/rt3050.dtsi
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/boot/dts/ralink/rt3052_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt3052_eval.dts
rename to arch/mips/boot/dts/ralink/rt3052_eval.dts
diff --git a/arch/mips/ralink/dts/rt3883.dtsi b/arch/mips/boot/dts/ralink/rt3883.dtsi
similarity index 100%
rename from arch/mips/ralink/dts/rt3883.dtsi
rename to arch/mips/boot/dts/ralink/rt3883.dtsi
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/boot/dts/ralink/rt3883_eval.dts
similarity index 100%
rename from arch/mips/ralink/dts/rt3883_eval.dts
rename to arch/mips/boot/dts/ralink/rt3883_eval.dts
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
