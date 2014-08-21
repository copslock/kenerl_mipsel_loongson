Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:51:32 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:46689 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006527AbaHVUvb1c5Ts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:51:31 +0200
Received: by mail-ig0-f202.google.com with SMTP id r2so48621igi.5
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tNKDjlgnF/pGiQTGQdiMAtwSQl7KtGbgAWBC6+0Nj+o=;
        b=H26tfjhw/h+LdERXHVL8813TLx/P2O6cPTbDnNiXSO8AdOYNTuVL//uP5EmBoVVB3Y
         g52guqlNbSuk6sfLJ0Q5z6CSmxDg994IrgQydwpnVdIqBGiKJZCy4UbxQHrUi5lrpv2L
         h5z1KuZ+owLu+cXSBIxenKK+On4q//50oXszZbMb7u1bbrfe+Pw+sc9ErJXsrxoVJVHC
         ASW/xaJD8wa8ytMv2e8eaTdv7BdpR511Vm5FZLQNGxgyGCzxMg79hsPXShtvD0Vj/SFd
         gVjoNnYFuwZaNLKVhnAPaSgkl2HhhNNYRPuOL8sXDtjzkv5FLfNi2RLXKfFifvWaC5kG
         MO5A==
X-Gm-Message-State: ALoCoQlBTTgL4r7ZXau+YaolxZNmVxkZuiqc15MQnF43uk5PjpDsarOzjMqEzDxb9XJsY16qCRxL
X-Received: by 10.182.32.1 with SMTP id e1mr558192obi.11.1408651489601;
        Thu, 21 Aug 2014 13:04:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si883493yhg.7.2014.08.21.13.04.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:49 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6A47F31C5D0;
        Thu, 21 Aug 2014 13:04:49 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 2AE74220378; Thu, 21 Aug 2014 13:04:49 -0700 (PDT)
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
Subject: [PATCH 4/7] MIPS: Lantiq: Move device-trees to arch/mips/boot/dts/
Date:   Thu, 21 Aug 2014 13:04:23 -0700
Message-Id: <1408651466-8334-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42173
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

Move the Lantiq device-trees to arch/mips/boot/dts/ and update the
Makefiles accordingly.  There is currently only a single Lantiq
device-tree (EASY50712), and it's required to be built into the kernel,
so select BUILTIN_DTB for it.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/boot/dts/Makefile                  | 1 +
 arch/mips/{lantiq => boot}/dts/danube.dtsi   | 0
 arch/mips/{lantiq => boot}/dts/easy50712.dts | 0
 arch/mips/lantiq/Kconfig                     | 1 +
 arch/mips/lantiq/Makefile                    | 2 --
 arch/mips/lantiq/dts/Makefile                | 1 -
 6 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/mips/{lantiq => boot}/dts/danube.dtsi (100%)
 rename arch/mips/{lantiq => boot}/dts/easy50712.dts (100%)
 delete mode 100644 arch/mips/lantiq/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 51acad6..4f265ec 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
+dtb-$(CONFIG_DT_EASY50712)		+= easy50712.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/lantiq/dts/danube.dtsi b/arch/mips/boot/dts/danube.dtsi
similarity index 100%
rename from arch/mips/lantiq/dts/danube.dtsi
rename to arch/mips/boot/dts/danube.dtsi
diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/boot/dts/easy50712.dts
similarity index 100%
rename from arch/mips/lantiq/dts/easy50712.dts
rename to arch/mips/boot/dts/easy50712.dts
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index c002191..e10d333 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -30,6 +30,7 @@ choice
 config DT_EASY50712
 	bool "Easy50712"
 	depends on SOC_XWAY
+	select BUILTIN_DTB
 endchoice
 
 config PCI_LANTIQ
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index d6bdc57..690257a 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -6,8 +6,6 @@
 
 obj-y := irq.o clk.o prom.o
 
-obj-y += dts/
-
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 obj-$(CONFIG_SOC_TYPE_XWAY) += xway/
diff --git a/arch/mips/lantiq/dts/Makefile b/arch/mips/lantiq/dts/Makefile
deleted file mode 100644
index 6fa72dd..0000000
--- a/arch/mips/lantiq/dts/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DT_EASY50712) := easy50712.dtb.o
-- 
2.1.0.rc2.206.gedb03e5
