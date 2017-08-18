Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 17:34:06 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36786
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbdHRPd63kCCs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 17:33:58 +0200
Received: by mail-wr0-x241.google.com with SMTP id f8so5398431wrf.3;
        Fri, 18 Aug 2017 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pRJUv4Af109BXxtrK4wMc67RTrV/uyq58nOXmhRNoGE=;
        b=AxkSHZUh+NLLgIz2MAt47crnEu92lNSZ7Y7ZXOwEGRBGiqw1ei15cKgev+utfqR4lq
         pgDHsd7KS2uEO/qur6X3PMZHxbrY8bqRc+NxTSt3IeMWQkO8UXruASuitQUoM9a64C5n
         mb6l1hKW1baUfGD1zOsCzROEmu4A0of3M8dV4gNhIxOiMb/p3RmVPVigDIx7re9YVtBC
         f3r7gaXbUOKk0CzWb+nN39ucZLakxFJ+RjF07jcj49K76G8aibO1bkxwUGcdRahhGlC3
         ha3EL86yPNdTR/aJ8uPzoZ9+PmVdXSYJ3V8mFszTVbfUasGpdYIPbOt/oWZaq+BmupJ4
         P06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pRJUv4Af109BXxtrK4wMc67RTrV/uyq58nOXmhRNoGE=;
        b=beVIioTCZu3scrYI3/P+qCSip5MGeAdkaaYdqIA6hUXkOyGTZSjmI7ZsApjSq9Ukm0
         K98BVrQdnd2G54OD1o7/i9F6MOwbbGsiqLZsG9fTTb6FtlRucSETZK6OT7oOT9rezhEf
         TgEac0mzq14BEdENQOW63+3sLmhC3l3NEZ2ftpL2ng7i9wADuAec/F8GP6tnksOw2n02
         1kkVjTlDAooITKFOAD07PD+qQSRqjIvKAGGsAC5YkKxJAPfYjBLhX7Bvs9c8G2J0fErG
         kj9Uwj+7qtYV0heftfYpqg5ak1KHH8W3NvWPsTZb/qzANfuL/LEbFtOfo1V8FEK82CnI
         a2lw==
X-Gm-Message-State: AHYfb5iDS3qPHX9ekClZoqaQCh89gJS967QGDfdhYFq5iAFjwY0Xmjkr
        nqoVL2aEHQo83/UmD86ShA==
X-Received: by 10.223.149.65 with SMTP id 59mr5330645wrs.292.1503070432830;
        Fri, 18 Aug 2017 08:33:52 -0700 (PDT)
Received: from void.lan (93-44-201-58.ip98.fastwebnet.it. [93.44.201.58])
        by smtp.gmail.com with ESMTPSA id k29sm5167624wrk.56.2017.08.18.08.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Aug 2017 08:33:52 -0700 (PDT)
From:   Rocco Folino <rocco.folino@gmail.com>
To:     ralf@linux-mips.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rocco Folino <rocco.folino@gmail.com>
Subject: [PATCH] MIPS: ath79: support devicetree selection
Date:   Fri, 18 Aug 2017 17:32:42 +0200
Message-Id: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
X-Mailer: git-send-email 2.13.5
Return-Path: <rocco.folino@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rocco.folino@gmail.com
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

Allow to choose devicetrees from Kconfig.

Signed-off-by: Rocco Folino <rocco.folino@gmail.com>
---
 arch/mips/ath79/Kconfig         | 44 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/qca/Makefile | 10 +++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index dfc60209dc63..b43d116187af 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -1,5 +1,49 @@
 if ATH79
 
+menu "Atheros AR71XX/AR724X/AR913X devicetree selection"
+
+config DTB_ATH_DPT_MODULE
+	bool "DPTechnics DPT-Module"
+	select SOC_933X
+	select BUILTIN_DTB
+	help
+	  Say 'Y' if you want your kernel to support the
+	  DPTechnics DPT-Module board.
+
+config DTB_ATH_DRAGINO_MS14
+	bool "Dragino MS14 (Dragino 2)"
+	select SOC_AR933X
+	select BUILTIN_DTB
+	help
+	  Say 'Y' if you want your kernel to support the
+	  Dragino MS14 board.
+
+config DTB_ATH_OMEGA
+	bool "Onion Omega"
+	select SOC_AR933X
+	select BUILTIN_DTB
+	help
+	  Say 'Y' if you want your kernel to support the
+	  Onion Omega board.
+
+config DTB_ATH_TL_MR3020
+	bool "TP-Link TL-MR3020"
+	select SOC_AR933X
+	select BUILTIN_DTB
+	help
+	  Say 'Y' if you want your kernel to support the
+	  TP-Link TL-MR3020 board.
+
+config DTB_ATH_TL_WR1043ND_V1
+	bool "TP-Link TL-WR1043ND v1"
+	select SOC_AR913X
+	select BUILTIN_DTB
+	help
+	  Say 'Y' if you want your kernel to support the
+	  TP-Link TL-WR1043ND v1 board.
+
+endmenu
+
 menu "Atheros AR71XX/AR724X/AR913X machine selection"
 
 config ATH79_MACH_AP121
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 63a9ddf048c9..acaf448e4516 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,9 +1,9 @@
 # All DTBs
-dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
-dtb-$(CONFIG_ATH79)			+= ar9331_dpt_module.dtb
-dtb-$(CONFIG_ATH79)			+= ar9331_dragino_ms14.dtb
-dtb-$(CONFIG_ATH79)			+= ar9331_omega.dtb
-dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
+dtb-$(CONFIG_DTB_ATH_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_ATH_DPT_MODULE)	+= ar9331_dpt_module.dtb
+dtb-$(CONFIG_DTB_ATH_DRAGINO_MS14)	+= ar9331_dragino_ms14.dtb
+dtb-$(CONFIG_DTB_ATH_OMEGA)		+= ar9331_omega.dtb
+dtb-$(CONFIG_DTB_ATH_TL_MR3020)		+= ar9331_tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-- 
2.13.5
