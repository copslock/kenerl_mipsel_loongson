Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 12:51:40 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:42149 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825910Ab2KOLvjNSfbG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2012 12:51:39 +0100
Received: by mail-we0-f177.google.com with SMTP id u50so497110wey.36
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2012 03:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=IOi2iYW6Hm4HogdVdJI1guxId252kYt7VSgPrOvNMXw=;
        b=Il5rzVB5vev54Dl6JIk646YGBl3kNqJntU2DLwgUFzXwLAvnIbCxNleoyV1jFzDy4g
         MIPHBwW7241oWe87ox6u5r6t6pUpmxMWaQF0NUEMe3f6bxoLTfIXqD8/f50UzMuBIQ3R
         gVkQcxnnew+oqJ5maI38Kpz0isPorSsNDSuAzLYOj5vCJnn4iqqICbbp0IsNeTUD0QtG
         BkOqBrm3W4rzZOwxk8Ud0ByIs/XAyQ58oFEI91bU6EI7Inf7KEpPgklyPwu0iW8q4AKy
         qgAv58v/35GUJ5Ay49nQ0xMfZXGrlfQ9GsPVURj/osfd27UY7cOGITKS5qwjH4EmXY9u
         i0/Q==
Received: by 10.216.214.90 with SMTP id b68mr434576wep.194.1352980293552;
        Thu, 15 Nov 2012 03:51:33 -0800 (PST)
Received: from localhost (host86-182-21-215.range86-182.btcentralplus.com. [86.182.21.215])
        by mx.google.com with ESMTPS id dm3sm6982501wib.3.2012.11.15.03.51.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 03:51:32 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 71DDD3E09BB; Thu, 15 Nov 2012 11:51:30 +0000 (GMT)
From:   Grant Likely <grant.likely@secretlab.ca>
Cc:     linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Stephen Warren <swarren@nvidia.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Date:   Thu, 15 Nov 2012 11:51:24 +0000
Message-Id: <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmfHAxMuUvJRg29gvCp8CM10lmIK7xWK4g7u/69rf63UNT/oyZkqXXOFLx/2mIxf6gkTwr9
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 35012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Grant Likely wrote:
> Or how about: I could pick up the patch with only the MIPS hunk and
> every other user can be fixed up independently to use the new rule.

Here's a trial patch to fix up ARM. Does this look correct? This patch
depends on the generic dtb build rule already being applied.

g.

---

arm/of: Change .dtb build rules to build in dts directory

The current rules have the .dtb files build in a different directory
from the .dts files. The only reason for this is that it was what
PowerPC has done historically. This patch changes ARM to use the generic
dtb rule which builds .dtb files in the same directory as the source .dts.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/arm/Makefile          |    4 ++--
 arch/arm/boot/Makefile     |   12 ------------
 arch/arm/boot/dts/Makefile |    4 ++++
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5f914fc..c35baf1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -292,10 +292,10 @@ zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
 %.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
 dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index f2aa09e..801b92c 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -15,8 +15,6 @@ ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
-include $(srctree)/arch/arm/boot/dts/Makefile
-
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
@@ -59,16 +57,6 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 
 endif
 
-targets += $(dtb-y)
-
-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
-
-clean-files := *.dtb
-
 ifneq ($(LOADADDR),)
   UIMAGE_LOADADDR=$(LOADADDR)
 else
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..2aef042 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -104,4 +104,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 	wm8505-ref.dtb \
 	wm8650-mid.dtb
 
+targets += dtbs
 endif
+
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+clean-files := *.dtb
-- 
1.7.10.4
