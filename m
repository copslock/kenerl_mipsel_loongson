Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 04:15:57 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:49367 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006945AbaH1CPunzCbT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 04:15:50 +0200
Received: by mail-ig0-f202.google.com with SMTP id r2so216343igi.5
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 19:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfKouy8qhxstyDHcy7czzxS7BimV/L4O14oOBRbj0No=;
        b=BPMYHRUl8X/Tao0ioQcda9nyH6Y17dBN/jl3CoKyvhWi0cqhRaepb7Wh7FWwY6kkaa
         Sw4uksty8JswGwW+oadppcCZ2n5+U5ELydhC1v2obWGAWMmEQbG58gnvw9Op1c6r5ZDz
         U5iIaQNTnVZj37dvPAu7b/xVY14t+7riBMeQEuPV6R/HhkEhkoiZoFZb4nZBDSv+M59d
         DZGkmvEULixvfEy+dNV0OFPxMhSjZER1QtySA43pdqitBvZqGPvRD9m6MrEOL2hWuhNW
         hSmZF7pAY+XXeYOQbl4w1Xr0KYBoReAkYVog/lIvdeGr67BzHJccFW52ul1nOoiVAuaP
         srhg==
X-Gm-Message-State: ALoCoQkmXZpUk5xN71cu8qbVppJeNRyu1MrDXqLSa6sN37KVQZic0w2QWuAp5lBGwY715cH3Dq8Z
X-Received: by 10.50.80.111 with SMTP id q15mr1293164igx.0.1409192144641;
        Wed, 27 Aug 2014 19:15:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j25si147856yhb.0.2014.08.27.19.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 19:15:44 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B09632F4040;
        Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 72FF522121C; Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
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
Subject: [PATCH v2 2/7] MIPS: Add support for building device-tree binaries
Date:   Wed, 27 Aug 2014 19:10:07 -0700
Message-Id: <1409191812-23697-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42296
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

Add a 'dtbs' Makefile target that just builds the device-tree binaries
enabled by the configuration.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Makefile          | 5 +++++
 arch/mips/boot/.gitignore   | 1 +
 arch/mips/boot/dts/Makefile | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 72cdd6a..26672e1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -330,6 +330,10 @@ core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
 %.dtb %.dtb.S %.dtb.o: | scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
 
+PHONY += dtbs
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=arch/mips/boot/dts dtbs
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
@@ -364,6 +368,7 @@ define archhelp
 	echo '  vmlinuz.srec         - SREC zboot image'
 	echo '  uImage               - U-Boot image'
 	echo '  uImage.gz            - U-Boot image (gzip)'
+	echo '  dtbs                 - Device-tree blobs for enabled boards'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 endef
diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
index a73d6e2..d3962cd 100644
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -5,3 +5,4 @@ zImage
 zImage.tmp
 calc_vmlinuz_load_addr
 uImage
+*.dtb
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 0fef69d..dcb7810 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,3 +1,8 @@
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
-clean-files	+= */*.dtb.S
+targets		+= dtbs
+targets		+= $(dtb-y)
+
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+
+clean-files	+= */*.dtb */*.dtb.S
-- 
2.1.0.rc2.206.gedb03e5
