Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2011 16:07:15 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:39364 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491977Ab1GEOHF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2011 16:07:05 +0200
Received: by wwi18 with SMTP id 18so5060942wwi.24
        for <multiple recipients>; Tue, 05 Jul 2011 07:07:00 -0700 (PDT)
Received: by 10.216.66.149 with SMTP id h21mr6133405wed.103.1309874818764;
        Tue, 05 Jul 2011 07:06:58 -0700 (PDT)
Received: from localhost.localdomain (93-172-172-9.bb.netvision.net.il [93.172.172.9])
        by mx.google.com with ESMTPS id u64sm3685418weq.4.2011.07.05.07.06.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 07:06:57 -0700 (PDT)
From:   Ohad Ben-Cohen <ohad@wizery.com>
To:     Rusty Russell <rusty@rustcorp.com.au>,
        virtualization@lists.linux-foundation.org
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        Xiantao Zhang <xiantao.zhang@intel.com>,
        Avi Kivity <avi@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexander Graf <agraf@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Carsten Otte <cotte@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kvm-ia64@vger.kernel.org, kvm@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [RFC] virtio: expose for non-virtualization users too
Date:   Tue,  5 Jul 2011 17:06:14 +0300
Message-Id: <1309874774-31689-1-git-send-email-ohad@wizery.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 30581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ohad@wizery.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3060

virtio has been so far used only in the context of virtualization,
and the virtio Kconfig was sourced directly by the relevant arch
Kconfigs when VIRTUALIZATION was selected.

Now that we start using virtio for inter-processor communications,
we need to source the virtio Kconfig outside of the virtualization
scope too.

Moreover, some architectures might use virtio for both virtualization
and inter-processor communications, so directly sourcing virtio
might yield unexpected results due to conflicting selections.

The simple solution offered by this patch is to always source virtio's
Kconfig in drivers/Kconfig, and remove it from the appropriate arch
Kconfigs. Additionally, a virtio menu entry has been added so virtio
drivers don't show up in the general drivers menu.

This way anyone can use virtio, though it's arguably less accessible
(and neat!) for virtualization users now.

Note: some architectures (mips and sh) seem to have a VIRTUALIZATION
menu merely for sourcing virtio's Kconfig, so that menu is removed too.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
The motivation behind this patch is: https://lkml.org/lkml/2011/6/21/47

If the general approach is agreed upon, we can either merge the patch
independently, or add it to the AMP patch set.

 arch/ia64/kvm/Kconfig    |    1 -
 arch/mips/Kconfig        |   16 ----------------
 arch/powerpc/kvm/Kconfig |    1 -
 arch/s390/kvm/Kconfig    |    1 -
 arch/sh/Kconfig          |   16 ----------------
 arch/tile/kvm/Kconfig    |    1 -
 arch/x86/kvm/Kconfig     |    1 -
 drivers/Kconfig          |    2 ++
 drivers/virtio/Kconfig   |    3 +++
 9 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/arch/ia64/kvm/Kconfig b/arch/ia64/kvm/Kconfig
index fa4d1e5..9806e55 100644
--- a/arch/ia64/kvm/Kconfig
+++ b/arch/ia64/kvm/Kconfig
@@ -49,6 +49,5 @@ config KVM_INTEL
 	  extensions.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653da62..a627a2c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2489,20 +2489,4 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
-menuconfig VIRTUALIZATION
-	bool "Virtualization"
-	default n
-	---help---
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-source drivers/virtio/Kconfig
-
-endif # VIRTUALIZATION
-
 source "lib/Kconfig"
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index b7baff7..105b691 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -99,6 +99,5 @@ config KVM_E500
 	  If unsure, say N.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index f66a1bd..a216341 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -37,6 +37,5 @@ config KVM
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index bbdeb48..748ff19 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -897,20 +897,4 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
-menuconfig VIRTUALIZATION
-	bool "Virtualization"
-	default n
-	---help---
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-source drivers/virtio/Kconfig
-
-endif # VIRTUALIZATION
-
 source "lib/Kconfig"
diff --git a/arch/tile/kvm/Kconfig b/arch/tile/kvm/Kconfig
index b88f9c0..669fcdb 100644
--- a/arch/tile/kvm/Kconfig
+++ b/arch/tile/kvm/Kconfig
@@ -33,6 +33,5 @@ config KVM
 	  If unsure, say N.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 50f6364..65cf823 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -76,6 +76,5 @@ config KVM_MMU_AUDIT
 # the virtualization menu.
 source drivers/vhost/Kconfig
 source drivers/lguest/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 3bb154d..795218e 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -114,6 +114,8 @@ source "drivers/uio/Kconfig"
 
 source "drivers/vlynq/Kconfig"
 
+source "drivers/virtio/Kconfig"
+
 source "drivers/xen/Kconfig"
 
 source "drivers/staging/Kconfig"
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 3dd6294..57e493b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -7,6 +7,8 @@ config VIRTIO_RING
 	tristate
 	depends on VIRTIO
 
+menu "Virtio drivers"
+
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
@@ -33,3 +35,4 @@ config VIRTIO_BALLOON
 
 	 If unsure, say M.
 
+endmenu
-- 
1.7.1
