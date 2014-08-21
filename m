Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:52:24 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:37975 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVwXHwuvR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:52:23 +0200
Received: by mail-ig0-f202.google.com with SMTP id r2so60445igi.1
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WTyfWfvGt4ooMCF4RylxTBO+1F+nIXQpirmP1d57B8=;
        b=GJ4B5CHbxSv+7bVmBR+fjTh5WmYHR+LhIMxqBWcrfEVMjLGZHL0TXCF8jbgiA25C4Y
         p4D5svtP+VjrD1SsFk5khngr4KVLRu6Q+q4XlUBP2RMxlYhxxCadIKeTmdMjI+mvt4Ds
         fR03Z1hMjMT+zTVD/XDyDrpgdnpVlFspNbo+6quf/1rYji9EOFiY4lGCjsjrJem94LY6
         WmVXRl9WdsNYW/db0UE5f0i166LyPLE/7IO4z1x7P1Ds/7YJIVFZdDe4rKIxONmN41Bh
         Q4OrXvrkzcL6t93oi77rU9jxtmVdA0FjDoyrXdhS8dwOV43o/Yn/6JNdo8j8D5VE55Rk
         hHLw==
X-Gm-Message-State: ALoCoQlkjdEqZpH3kzzfltVpKQ52zpZE3XS5jZF7q9ER+cP67yH9czPRlqkyWWK+P9IIhzO/jpo6
X-Received: by 10.182.251.135 with SMTP id zk7mr620977obc.14.1408651486933;
        Thu, 21 Aug 2014 13:04:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si883590yhe.2.2014.08.21.13.04.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:46 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B17B231C5D0;
        Thu, 21 Aug 2014 13:04:46 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 73B44220378; Thu, 21 Aug 2014 13:04:46 -0700 (PDT)
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
Subject: [PATCH 1/7] MIPS: Create common infrastructure for building built-in device-trees
Date:   Thu, 21 Aug 2014 13:04:20 -0700
Message-Id: <1408651466-8334-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42182
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

In preparation for moving the device-trees to a common location,
introduce the config option BUILTIN_DTB, which can be selected by
platforms that use a device-tree built into the kernel image, and
create a Makefile to build the device-trees in arch/mips/boot/dts/.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig           | 3 +++
 arch/mips/Makefile          | 6 ++++++
 arch/mips/boot/dts/Makefile | 3 +++
 3 files changed, 12 insertions(+)
 create mode 100644 arch/mips/boot/dts/Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index df51e78..19b8aac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2481,6 +2481,9 @@ config USE_OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 
+config BUILTIN_DTB
+	bool
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9336509..72cdd6a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -324,6 +324,12 @@ endif
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
+# device-trees
+core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
+
+%.dtb %.dtb.S %.dtb.o: | scripts
+	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
new file mode 100644
index 0000000..6bb41df
--- /dev/null
+++ b/arch/mips/boot/dts/Makefile
@@ -0,0 +1,3 @@
+obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+clean-files	+= *.dtb.S
-- 
2.1.0.rc2.206.gedb03e5
