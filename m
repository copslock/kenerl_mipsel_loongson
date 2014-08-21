Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:16:57 +0200 (CEST)
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62176 "EHLO
        mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025257AbaHVUQ4xnUuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:16:56 +0200
Received: by mail-vc0-f202.google.com with SMTP id hq11so1316135vcb.3
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIcALrgevVET+FhKL7bRhj6SzihIooA0DyF50OMIaTU=;
        b=lhQ85O9qPr8FIT2vp/lN+tYOjtG+s0CJ/GXRsD98f77EreyEqE6ccT6nUCG90/wgmc
         Rglx9ahv57cZyyloEI0WhR8UdjD3JMib01T+0Ivc1UmFW2S9VGEtd6wvrH7koVUqvQzJ
         NKd6YAawzpvMQZUrBa0Nn+b5uIKU/UoQ86uFUXv6X2gyXfSuB/MoJ+/P4xFNqib4C4r5
         FsMHgeBPLFqK+REyAJCr3zcOU37F2Z+DwFBVqyDZ6OUc5KRNtu0ViLpzb0Uw1t93gjSl
         mAcFDlwpR/LU5c+LVrXGFQ9R8in4kOI89q0GBmZSMHzY4uYu3NOUEK81Wqv+b97tiIJX
         3b4g==
X-Gm-Message-State: ALoCoQk4yuelnVzksQZe0Rxi+JibUF1zh5WTkmfzLthC+qZhSqi6UMb8y/Y5vgHb1p/rSIDC52pN
X-Received: by 10.236.201.108 with SMTP id a72mr26877132yho.39.1408651490838;
        Thu, 21 Aug 2014 13:04:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si883599yhe.2.2014.08.21.13.04.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:50 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A746F5A48EB;
        Thu, 21 Aug 2014 13:04:50 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 68166220378; Thu, 21 Aug 2014 13:04:50 -0700 (PDT)
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
Subject: [PATCH 5/7] MIPS: sead3: Move device-trees to arch/mips/boot/dts/
Date:   Thu, 21 Aug 2014 13:04:24 -0700
Message-Id: <1408651466-8334-6-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42169
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

Move the SEAD-3 device-tree to arch/mips/boot/dts/ and update the
Makefiles accordingly.  Since SEAD-3 requires the device-tree to be
built into the kernel, select BUILTIN_DTB when building for SEAD-3.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig                           | 1 +
 arch/mips/boot/dts/Makefile                 | 1 +
 arch/mips/{mti-sead3 => boot/dts}/sead3.dts | 0
 arch/mips/mti-sead3/Makefile                | 4 ----
 4 files changed, 2 insertions(+), 4 deletions(-)
 rename arch/mips/{mti-sead3 => boot/dts}/sead3.dts (100%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dbfcf35..a72c7c9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -353,6 +353,7 @@ config MIPS_SEAD3
 	bool "MIPS SEAD3 board"
 	select BOOT_ELF32
 	select BOOT_RAW
+	select BUILTIN_DTB
 	select CEVT_R4K
 	select CSRC_R4K
 	select CSRC_GIC
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 4f265ec..8df3d3e 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
 dtb-$(CONFIG_DT_EASY50712)		+= easy50712.dtb
+dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/mti-sead3/sead3.dts b/arch/mips/boot/dts/sead3.dts
similarity index 100%
rename from arch/mips/mti-sead3/sead3.dts
rename to arch/mips/boot/dts/sead3.dts
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 071786f..febf433 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -19,9 +19,5 @@ obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
-obj-$(CONFIG_OF)		+= sead3.dtb.o
 
 CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
-
-$(obj)/%.dtb: $(obj)/%.dts
-	$(call if_changed,dtc)
-- 
2.1.0.rc2.206.gedb03e5
