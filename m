Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:33:31 +0200 (CEST)
Received: from mail-qa0-f74.google.com ([209.85.216.74]:38706 "EHLO
        mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025930AbaHVUdaOx5LQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:33:30 +0200
Received: by mail-qa0-f74.google.com with SMTP id j15so1320779qaq.3
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XlQiU8AuvMq0EmuGG1btNICyp8nrYskpUIkjwph4xTg=;
        b=KT1et5DwE4U4DSwO4uuSbj0RD2s5ppP3BENPUX9IqFDtbqXnRew2TaPAB63Jxv3dCm
         gzhbc+i6/xKB+bngRsYIXOrICqUsaK08dftEYg1lHYJy0Sj2GgTPWxsav84ZoHJO034F
         qNXaEgO5a984zF1ogjAiTlN4ecXrJ9TGy0qEqpqI6b/CBez15m2I/ChH7+W3ihybInLA
         GbXGAqhZVvHw5tuS8bxpHy0H7kOH2/LFxewPQHmjsxCs09m8nYo15mcyJ5pWsiEWk+7y
         dueerOZFyF58sVVZmOOIfDYWPw1Iy+QPforyK4ZOAfY7eT4ZMvAyBvxDDwTfEMII7JYp
         ioFw==
X-Gm-Message-State: ALoCoQkZOkuiGp4lpQz57xydtSKlGIbPBwcvQsH/DwN5wwquNlSLA/pOPqGNBCmWScf0xOvaN6dE
X-Received: by 10.236.38.9 with SMTP id z9mr1242952yha.23.1408651487788;
        Thu, 21 Aug 2014 13:04:47 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si883487yhg.7.2014.08.21.13.04.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 99EE731C5D0;
        Thu, 21 Aug 2014 13:04:47 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 595E2220378; Thu, 21 Aug 2014 13:04:47 -0700 (PDT)
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
Subject: [PATCH 2/7] MIPS: Add support for building device-tree binaries
Date:   Thu, 21 Aug 2014 13:04:21 -0700
Message-Id: <1408651466-8334-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42171
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
index 6bb41df..9b3da1f 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,3 +1,8 @@
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
-clean-files	+= *.dtb.S
+targets		+= dtbs
+targets		+= $(dtb-y)
+
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+
+clean-files	+= *.dtb *.dtb.S
-- 
2.1.0.rc2.206.gedb03e5
