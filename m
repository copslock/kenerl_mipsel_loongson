Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 17:44:13 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:45973 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009654AbaLWQoKiWbub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 17:44:10 +0100
Received: by mail-ie0-f202.google.com with SMTP id rd18so667285iec.5
        for <linux-mips@linux-mips.org>; Tue, 23 Dec 2014 08:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NZXgDiYwC6HOcvLyRvWfuCjgSt4EuluZhFJHqldTlK4=;
        b=HcHAJ074EKdJHtP4yyCiDqBIC/K8/PMq5rFbTB/6Nr+XerD7T548pkMhjMpNzt2VSk
         w6GUeiiAWrmERn/Sk0fgRGzVWCmezbNex2WdU0qw/McydFGp46tK2Xy0Mf0cToxbJG85
         sCGdaECndOhx8Sr/L+SByR1/LnOirRIb3uYFkykV2ATz/zbz6Y+EKCStJrfLq+iJ0XXo
         biI2kuHexqzBOfz+lx6p8pvdfwBFOWnba59najhx/QxNR4Tfdh2QsNtoq9CFJmutfS+O
         aDQgdW6z9Elx+lW/QZvXtZ2t7axf0npeIT2zwiRVk2UxAql4dj6aM6D+w1gLAGMUhGv5
         ci0g==
X-Gm-Message-State: ALoCoQku7eHH7WMc++/NmLBOI6TLII6Rz3HI2OquzeS7zN905YVFxDLVVfm6QBkrJV4O2KnhnLio
X-Received: by 10.42.199.135 with SMTP id es7mr23127033icb.25.1419353044315;
        Tue, 23 Dec 2014 08:44:04 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id v47si354226yhn.0.2014.12.23.08.44.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2014 08:44:04 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id dfFVzIC0.1; Tue, 23 Dec 2014 08:44:04 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 2755522057C; Tue, 23 Dec 2014 08:44:03 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH V2 1/2] MIPS: Move device-trees into vendor sub-directories
Date:   Tue, 23 Dec 2014 08:43:51 -0800
Message-Id: <1419353032-10340-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44901
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

Move the MIPS device-trees into the appropriate vendor sub-directories.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v1:
 - renamed bcm -> brcm
---
 arch/mips/Makefile                                 |  2 +-
 arch/mips/boot/dts/Makefile                        | 33 ++++++++--------------
 arch/mips/boot/dts/brcm/Makefile                   |  9 ++++++
 arch/mips/boot/dts/{ => brcm}/bcm3384.dtsi         |  0
 arch/mips/boot/dts/{ => brcm}/bcm93384wvg.dts      |  0
 arch/mips/boot/dts/cavium-octeon/Makefile          |  9 ++++++
 .../boot/dts/{ => cavium-octeon}/octeon_3xxx.dts   |  0
 .../boot/dts/{ => cavium-octeon}/octeon_68xx.dts   |  0
 arch/mips/boot/dts/lantiq/Makefile                 |  9 ++++++
 arch/mips/boot/dts/{ => lantiq}/danube.dtsi        |  0
 arch/mips/boot/dts/{ => lantiq}/easy50712.dts      |  0
 arch/mips/boot/dts/mti/Makefile                    |  9 ++++++
 arch/mips/boot/dts/{ => mti}/sead3.dts             |  0
 arch/mips/boot/dts/netlogic/Makefile               | 12 ++++++++
 arch/mips/boot/dts/{ => netlogic}/xlp_evp.dts      |  0
 arch/mips/boot/dts/{ => netlogic}/xlp_fvp.dts      |  0
 arch/mips/boot/dts/{ => netlogic}/xlp_gvp.dts      |  0
 arch/mips/boot/dts/{ => netlogic}/xlp_svp.dts      |  0
 arch/mips/boot/dts/ralink/Makefile                 | 12 ++++++++
 arch/mips/boot/dts/{ => ralink}/mt7620a.dtsi       |  0
 arch/mips/boot/dts/{ => ralink}/mt7620a_eval.dts   |  0
 arch/mips/boot/dts/{ => ralink}/rt2880.dtsi        |  0
 arch/mips/boot/dts/{ => ralink}/rt2880_eval.dts    |  0
 arch/mips/boot/dts/{ => ralink}/rt3050.dtsi        |  0
 arch/mips/boot/dts/{ => ralink}/rt3052_eval.dts    |  0
 arch/mips/boot/dts/{ => ralink}/rt3883.dtsi        |  0
 arch/mips/boot/dts/{ => ralink}/rt3883_eval.dts    |  0
 27 files changed, 73 insertions(+), 22 deletions(-)
 create mode 100644 arch/mips/boot/dts/brcm/Makefile
 rename arch/mips/boot/dts/{ => brcm}/bcm3384.dtsi (100%)
 rename arch/mips/boot/dts/{ => brcm}/bcm93384wvg.dts (100%)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/Makefile
 rename arch/mips/boot/dts/{ => cavium-octeon}/octeon_3xxx.dts (100%)
 rename arch/mips/boot/dts/{ => cavium-octeon}/octeon_68xx.dts (100%)
 create mode 100644 arch/mips/boot/dts/lantiq/Makefile
 rename arch/mips/boot/dts/{ => lantiq}/danube.dtsi (100%)
 rename arch/mips/boot/dts/{ => lantiq}/easy50712.dts (100%)
 create mode 100644 arch/mips/boot/dts/mti/Makefile
 rename arch/mips/boot/dts/{ => mti}/sead3.dts (100%)
 create mode 100644 arch/mips/boot/dts/netlogic/Makefile
 rename arch/mips/boot/dts/{ => netlogic}/xlp_evp.dts (100%)
 rename arch/mips/boot/dts/{ => netlogic}/xlp_fvp.dts (100%)
 rename arch/mips/boot/dts/{ => netlogic}/xlp_gvp.dts (100%)
 rename arch/mips/boot/dts/{ => netlogic}/xlp_svp.dts (100%)
 create mode 100644 arch/mips/boot/dts/ralink/Makefile
 rename arch/mips/boot/dts/{ => ralink}/mt7620a.dtsi (100%)
 rename arch/mips/boot/dts/{ => ralink}/mt7620a_eval.dts (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt2880.dtsi (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt2880_eval.dts (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt3050.dtsi (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt3052_eval.dts (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt3883.dtsi (100%)
 rename arch/mips/boot/dts/{ => ralink}/rt3883_eval.dts (100%)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 37fce70..9c4b9c8 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -354,7 +354,7 @@ core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
 
 PHONY += dtbs
 dtbs: scripts
-	$(Q)$(MAKE) $(build)=arch/mips/boot/dts dtbs
+	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
 
 archprepare:
 ifdef CONFIG_MIPS32_N32
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 4f49fa4..5d95e4b 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,21 +1,12 @@
-dtb-$(CONFIG_BCM3384)			+= bcm93384wvg.dtb
-dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
-dtb-$(CONFIG_DT_EASY50712)		+= easy50712.dtb
-dtb-$(CONFIG_DT_XLP_EVP)		+= xlp_evp.dtb
-dtb-$(CONFIG_DT_XLP_SVP)		+= xlp_svp.dtb
-dtb-$(CONFIG_DT_XLP_FVP)		+= xlp_fvp.dtb
-dtb-$(CONFIG_DT_XLP_GVP)		+= xlp_gvp.dtb
-dtb-$(CONFIG_DTB_RT2880_EVAL)		+= rt2880_eval.dtb
-dtb-$(CONFIG_DTB_RT305X_EVAL)		+= rt3052_eval.dtb
-dtb-$(CONFIG_DTB_RT3883_EVAL)		+= rt3883_eval.dtb
-dtb-$(CONFIG_DTB_MT7620A_EVAL)		+= mt7620a_eval.dtb
-dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
-
-obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-targets		+= dtbs
-targets		+= $(dtb-y)
-
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-
-clean-files	+= *.dtb *.dtb.S
+dts-dirs	+= brcm
+dts-dirs	+= cavium-octeon
+dts-dirs	+= lantiq
+dts-dirs	+= mti
+dts-dirs	+= netlogic
+dts-dirs	+= ralink
+
+obj-y		:= $(addsuffix /, $(dts-dirs))
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
new file mode 100644
index 0000000..a353d4e
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_BCM3384)		+= bcm93384wvg.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/bcm3384.dtsi b/arch/mips/boot/dts/brcm/bcm3384.dtsi
similarity index 100%
rename from arch/mips/boot/dts/bcm3384.dtsi
rename to arch/mips/boot/dts/brcm/bcm3384.dtsi
diff --git a/arch/mips/boot/dts/bcm93384wvg.dts b/arch/mips/boot/dts/brcm/bcm93384wvg.dts
similarity index 100%
rename from arch/mips/boot/dts/bcm93384wvg.dts
rename to arch/mips/boot/dts/brcm/bcm93384wvg.dts
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
new file mode 100644
index 0000000..5b99c40
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_CAVIUM_OCTEON_SOC)	+= octeon_3xxx.dtb octeon_68xx.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
similarity index 100%
rename from arch/mips/boot/dts/octeon_3xxx.dts
rename to arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
diff --git a/arch/mips/boot/dts/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
similarity index 100%
rename from arch/mips/boot/dts/octeon_68xx.dts
rename to arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
new file mode 100644
index 0000000..0906c62
--- /dev/null
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
similarity index 100%
rename from arch/mips/boot/dts/danube.dtsi
rename to arch/mips/boot/dts/lantiq/danube.dtsi
diff --git a/arch/mips/boot/dts/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
similarity index 100%
rename from arch/mips/boot/dts/easy50712.dts
rename to arch/mips/boot/dts/lantiq/easy50712.dts
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
new file mode 100644
index 0000000..ef1f3db
--- /dev/null
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_MIPS_SEAD3)	+= sead3.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
similarity index 100%
rename from arch/mips/boot/dts/sead3.dts
rename to arch/mips/boot/dts/mti/sead3.dts
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
new file mode 100644
index 0000000..e126cd3
--- /dev/null
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -0,0 +1,12 @@
+dtb-$(CONFIG_DT_XLP_EVP)	+= xlp_evp.dtb
+dtb-$(CONFIG_DT_XLP_SVP)	+= xlp_svp.dtb
+dtb-$(CONFIG_DT_XLP_FVP)	+= xlp_fvp.dtb
+dtb-$(CONFIG_DT_XLP_GVP)	+= xlp_gvp.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/xlp_evp.dts b/arch/mips/boot/dts/netlogic/xlp_evp.dts
similarity index 100%
rename from arch/mips/boot/dts/xlp_evp.dts
rename to arch/mips/boot/dts/netlogic/xlp_evp.dts
diff --git a/arch/mips/boot/dts/xlp_fvp.dts b/arch/mips/boot/dts/netlogic/xlp_fvp.dts
similarity index 100%
rename from arch/mips/boot/dts/xlp_fvp.dts
rename to arch/mips/boot/dts/netlogic/xlp_fvp.dts
diff --git a/arch/mips/boot/dts/xlp_gvp.dts b/arch/mips/boot/dts/netlogic/xlp_gvp.dts
similarity index 100%
rename from arch/mips/boot/dts/xlp_gvp.dts
rename to arch/mips/boot/dts/netlogic/xlp_gvp.dts
diff --git a/arch/mips/boot/dts/xlp_svp.dts b/arch/mips/boot/dts/netlogic/xlp_svp.dts
similarity index 100%
rename from arch/mips/boot/dts/xlp_svp.dts
rename to arch/mips/boot/dts/netlogic/xlp_svp.dts
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
new file mode 100644
index 0000000..2a72259
--- /dev/null
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -0,0 +1,12 @@
+dtb-$(CONFIG_DTB_RT2880_EVAL)	+= rt2880_eval.dtb
+dtb-$(CONFIG_DTB_RT305X_EVAL)	+= rt3052_eval.dtb
+dtb-$(CONFIG_DTB_RT3883_EVAL)	+= rt3883_eval.dtb
+dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
similarity index 100%
rename from arch/mips/boot/dts/mt7620a.dtsi
rename to arch/mips/boot/dts/ralink/mt7620a.dtsi
diff --git a/arch/mips/boot/dts/mt7620a_eval.dts b/arch/mips/boot/dts/ralink/mt7620a_eval.dts
similarity index 100%
rename from arch/mips/boot/dts/mt7620a_eval.dts
rename to arch/mips/boot/dts/ralink/mt7620a_eval.dts
diff --git a/arch/mips/boot/dts/rt2880.dtsi b/arch/mips/boot/dts/ralink/rt2880.dtsi
similarity index 100%
rename from arch/mips/boot/dts/rt2880.dtsi
rename to arch/mips/boot/dts/ralink/rt2880.dtsi
diff --git a/arch/mips/boot/dts/rt2880_eval.dts b/arch/mips/boot/dts/ralink/rt2880_eval.dts
similarity index 100%
rename from arch/mips/boot/dts/rt2880_eval.dts
rename to arch/mips/boot/dts/ralink/rt2880_eval.dts
diff --git a/arch/mips/boot/dts/rt3050.dtsi b/arch/mips/boot/dts/ralink/rt3050.dtsi
similarity index 100%
rename from arch/mips/boot/dts/rt3050.dtsi
rename to arch/mips/boot/dts/ralink/rt3050.dtsi
diff --git a/arch/mips/boot/dts/rt3052_eval.dts b/arch/mips/boot/dts/ralink/rt3052_eval.dts
similarity index 100%
rename from arch/mips/boot/dts/rt3052_eval.dts
rename to arch/mips/boot/dts/ralink/rt3052_eval.dts
diff --git a/arch/mips/boot/dts/rt3883.dtsi b/arch/mips/boot/dts/ralink/rt3883.dtsi
similarity index 100%
rename from arch/mips/boot/dts/rt3883.dtsi
rename to arch/mips/boot/dts/ralink/rt3883.dtsi
diff --git a/arch/mips/boot/dts/rt3883_eval.dts b/arch/mips/boot/dts/ralink/rt3883_eval.dts
similarity index 100%
rename from arch/mips/boot/dts/rt3883_eval.dts
rename to arch/mips/boot/dts/ralink/rt3883_eval.dts
-- 
2.2.0.rc0.207.ga3a616c
