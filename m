Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:14:46 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39024 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835249Ab3FGXEBxI8XJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:01 +0200
Received: by mail-ie0-f174.google.com with SMTP id aq17so12143553iec.33
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fP+VQz4k9Zjtk9l8ILsJwE+i52mAT4qhfYLkgIMqpGM=;
        b=sLvCkmCOsLs9shpSiboRobxWTMnrGu9u/oGX0iBNBA2freBFv4au7w9OF7/5+e1FmP
         3QYhD8CayiDrV7TgaZ80a5gmHvN81MyUWKnEpFrV5PNpn0FybqKJw4NcHeqymU63Jecr
         7rERoLTqSibQwR5JDK5RZmU9Yl9ti/uM3fcihionoiD1InlL3QszTFGpwJEyyf26sHmu
         9UqmzhyBIWttGDP3BDudXyc1ZeeBzB2vnxiF1wLBOIxoD3/eAhx54LOmL0gUdbRpZlEP
         piGoALURMm7dTUc9k1sxqPyUb2lYYE24qjYiSHxZ+80nd5uLXJf+05cy+A7kHHcuCMV8
         45CA==
X-Received: by 10.50.72.2 with SMTP id z2mr396901igu.84.1370646235757;
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id it3sm235729igb.0.2013.06.07.16.03.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3rOP006731;
        Fri, 7 Jun 2013 16:03:53 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3ra1006730;
        Fri, 7 Jun 2013 16:03:53 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 30/31] mips/kvm: Enable MIPSVZ in Kconfig/Makefile
Date:   Fri,  7 Jun 2013 16:03:34 -0700
Message-Id: <1370646215-6543-31-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Also let CPU_CAVIUM_OCTEON select KVM.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig      | 1 +
 arch/mips/kvm/Kconfig  | 9 +++++++++
 arch/mips/kvm/Makefile | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..16e3d22 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1426,6 +1426,7 @@ config CPU_CAVIUM_OCTEON
 	select LIBFDT
 	select USE_OF
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select HAVE_KVM
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 95c0d22..32a5016 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -48,6 +48,15 @@ config KVM_MIPS_DEBUG_COP0_COUNTERS
 
 	  If unsure, say N.
 
+config KVM_MIPSVZ
+	bool "Kernel-based Virtual Machine (KVM) using hardware MIPS-VZ support"
+	depends on HAVE_KVM
+	select KVM
+	---help---
+	  Support for hosting Guest kernels on hardware with the
+	  MIPS-VZ hardware module.
+
+
 source drivers/vhost/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 3377197..595358f 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -13,3 +13,4 @@ kvm_mipste-objs		:= kvm_mips_emul.o kvm_locore.o kvm_mips_int.o \
 
 obj-$(CONFIG_KVM)		+= $(common-objs) kvm_mips.o
 obj-$(CONFIG_KVM_MIPSTE)	+= kvm_mipste.o
+obj-$(CONFIG_KVM_MIPSVZ)	+= kvm_mipsvz.o kvm_mipsvz_guest.o
-- 
1.7.11.7
