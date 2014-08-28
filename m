Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 04:10:38 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:56015 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007139AbaH1CKWi8nLJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 04:10:22 +0200
Received: by mail-oa0-f73.google.com with SMTP id g18so197779oah.4
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ocB5Lc2uh+EIwDE16mNxJD1THKfPNEE9E9060gcJIJY=;
        b=HT/OsSkb6NDBlQsVno6N5RiZfaL5NEW1XSUjoLv5vGf2k/iUPncyoe2oGfhxVs7imP
         Gl5jcu0m+wL+F3Ds8vWrmM01IMVuCq1v5JIb0YPWIe/qWtC0SkByVI9+4v72PzyJobU1
         n/zErpP8LTDAgAngKnDq78NNctaUmnToqcMKelivBWECGyumgT2FWYdXVBpPkpX9Xhx5
         Cx2axaR3Gzgw6FnQfM3Li58xBm/skMF66AlLhJc312ohR4WA91MUx6HVqlbq9HrmsipS
         VDi2nFwqpg8f6qQyUpkK6IVGqyrgaIqNu+gvEnAFHiWi8BS1BcXdh/rvyZnZ0jFTT9ub
         l9yg==
X-Gm-Message-State: ALoCoQnYgcWTPMlZlkC4hc81Ehlu+3LTvnW9BRMj/PiRQWnRW8zhfdChuv4NDeRG4SXqZrui1JEc
X-Received: by 10.42.152.201 with SMTP id j9mr1225767icw.5.1409191816209;
        Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t28si145066yhb.4.2014.08.27.19.10.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 08A7D31C33A;
        Wed, 27 Aug 2014 19:10:16 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id BE1DC2211E2; Wed, 27 Aug 2014 19:10:15 -0700 (PDT)
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
Subject: [PATCH v2 1/7] MIPS: Create common infrastructure for building built-in device-trees
Date:   Wed, 27 Aug 2014 19:10:06 -0700
Message-Id: <1409191812-23697-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42293
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
index 0000000..0fef69d
--- /dev/null
+++ b/arch/mips/boot/dts/Makefile
@@ -0,0 +1,3 @@
+obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+clean-files	+= */*.dtb.S
-- 
2.1.0.rc2.206.gedb03e5
