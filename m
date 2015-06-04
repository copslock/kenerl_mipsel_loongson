Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 23:50:08 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:32896 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008283AbbFDVuG2aDWZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 23:50:06 +0200
Received: by obbea3 with SMTP id ea3so42174924obb.0
        for <linux-mips@linux-mips.org>; Thu, 04 Jun 2015 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=PKT8h0RfCTYhRP3Pdsu7T100L31LBkplpTtjOyHSN7g=;
        b=GgaSdM5uLIEIkZTzVGXqXvn20TxEabIq8/LC8kTqu2mGRMzgTM26Lk0vrGCggAqNdw
         1VCd81uC6j6ADhuQzT0jJc7bXlKUY8uHlECyKU6a+AwPglp8bfPmtwPRR1maDylMa4YY
         2pxxyhzcU3tf8/EX0ROHJ53SNp7mFbmIoeEpX+RGTIiuSEHry+FQMsCh2wyPu4PJRspx
         fERloUUR5/CBobqAPOkCP524opv3coJC+wtG5fFlalXhF5vkewSlnjiUnxQXldtotQJ1
         xx8KgLKQCfEJvs/k+vC9DsY+XCWKGUm3kb0da3rN/o530GTzUa4L9avUGXF1enilOynR
         b0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=PKT8h0RfCTYhRP3Pdsu7T100L31LBkplpTtjOyHSN7g=;
        b=l1wSzVIfMN0YpwuXhDbnAmts80lGxzwn4guEV6Wf+7AEmOnH1KkaPor8VBcwpQ3xiv
         OM8N68s2F2mooS6p9r8avhn14qcpuoIPoy9FTAzD1feHClR/2qxkhN7LrRhikyqV4PPj
         r4MqiZ2MFdtB/T/snPPipKrCnfG2avj0vjQvrTsRMazAyK/U7LbgLVRd9ROAEeX42WEy
         n85RtWv3k5ZYVw2pvSCRNEeStfhLdV2zPjfOgNg/7YEq05eWPpO+Bw6qz4aIeC6252ZR
         hCxmOVtjrbnIJyPhTVMDn6mQ5FZfwjUaX0NNQt6BUNbQx59tfxAPTQZKWGfissdIJqfJ
         cNXg==
X-Gm-Message-State: ALoCoQmCK+lvo1LEaEyu3fEZeqNZLhexRKvDyidZeDTeN4RFi5AvvSUolkeIYeu18sO90zFQJR4X
X-Received: by 10.202.48.194 with SMTP id w185mr71501oiw.95.1433454600523;
        Thu, 04 Jun 2015 14:50:00 -0700 (PDT)
Received: from localhost (172-9-203-140.lightspeed.spfdmo.sbcglobal.net. [172.9.203.140])
        by mx.google.com with ESMTPSA id og8sm2199567obb.6.2015.06.04.14.49.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 14:49:59 -0700 (PDT)
Subject: [PATCH 5/7] PCI: Remove unnecessary #includes of <asm/pci.h>
To:     linux-pci@vger.kernel.org
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-alpha@vger.kernel.org
Date:   Thu, 04 Jun 2015 16:49:57 -0500
Message-ID: <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

In include/linux/pci.h, we already #include <asm/pci.h>, so we don't need
to include <asm/pci.h> directly.

Remove the unnecessary includes.  All the files here already include
<linux/pci.h>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-alpha@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-sh@vger.kernel.org
CC: x86@kernel.org
---
 arch/alpha/kernel/core_irongate.c |    1 -
 arch/alpha/kernel/sys_eiger.c     |    1 -
 arch/alpha/kernel/sys_nautilus.c  |    1 -
 arch/mips/pci/fixup-cobalt.c      |    1 -
 arch/mips/pci/ops-mace.c          |    1 -
 arch/mips/pci/pci-lantiq.c        |    1 -
 arch/powerpc/kernel/prom.c        |    1 -
 arch/powerpc/kernel/prom_init.c   |    1 -
 arch/sh/drivers/pci/ops-sh5.c     |    1 -
 arch/sh/drivers/pci/pci-sh5.c     |    1 -
 arch/x86/kernel/x86_init.c        |    1 -
 11 files changed, 11 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 00096df..83d0a35 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -22,7 +22,6 @@
 #include <linux/bootmem.h>
 
 #include <asm/ptrace.h>
-#include <asm/pci.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 79d69d7..15f4208 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -22,7 +22,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/pgtable.h>
 #include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 700686d..2cfaa0e 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -39,7 +39,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/pgtable.h>
 #include <asm/core_irongate.h>
 #include <asm/hwrpb.h>
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index a138e8e..b3ab593 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/pci.h>
 #include <asm/io.h>
 #include <asm/gt64120.h>
 
diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 6b5821f..951d807 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <asm/pci.h>
 #include <asm/ip32/mace.h>
 
 #if 0
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 8b117e6..c5347d9 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -20,7 +20,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 
-#include <asm/pci.h>
 #include <asm/gpio.h>
 #include <asm/addrspace.h>
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 308c5e1..00fdea2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -46,7 +46,6 @@
 #include <asm/mmu.h>
 #include <asm/paca.h>
 #include <asm/pgtable.h>
-#include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index fd1fe4c..fcca807 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -37,7 +37,6 @@
 #include <asm/smp.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
diff --git a/arch/sh/drivers/pci/ops-sh5.c b/arch/sh/drivers/pci/ops-sh5.c
index 4ce95a0..4536194 100644
--- a/arch/sh/drivers/pci/ops-sh5.c
+++ b/arch/sh/drivers/pci/ops-sh5.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/irq.h>
-#include <asm/pci.h>
 #include <asm/io.h>
 #include "pci-sh5.h"
 
diff --git a/arch/sh/drivers/pci/pci-sh5.c b/arch/sh/drivers/pci/pci-sh5.c
index 16c1e72..8229114 100644
--- a/arch/sh/drivers/pci/pci-sh5.c
+++ b/arch/sh/drivers/pci/pci-sh5.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 #include <linux/irq.h>
 #include <cpu/irq.h>
-#include <asm/pci.h>
 #include <asm/io.h>
 #include "pci-sh5.h"
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 234b072..eed5625 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -11,7 +11,6 @@
 #include <asm/bios_ebda.h>
 #include <asm/paravirt.h>
 #include <asm/pci_x86.h>
-#include <asm/pci.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
 #include <asm/apic.h>
