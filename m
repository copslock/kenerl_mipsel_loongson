Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 06:48:36 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:22553
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbVJTFsS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 06:48:18 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K5mGZe001275;
	Wed, 19 Oct 2005 22:48:16 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K5mFUP001272;
	Wed, 19 Oct 2005 22:48:15 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.12191.789743.351629@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 22:48:15 -0700
To:	linux-mips@linux-mips.org
CC:	linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 1/11 Allow PCI resources to be overridden
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the first part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

The Xilleon's (32bit MIPS SOC) PCU resides on the PCI bus, but is
non-standard in that it has several apertures that should not be
mapped into the standard PCI aperture.

The idea behind the patch is that ports that define
CONFIG_PCIBIOS_OVERRIDE_RESOURCE supply a hook in their pcibios
(pcibios_override_resource()) that gets a chance to handle a mapping
before the default pci setup code tries to do it.

For ports that don't define CONFIG_PCIBIOS_OVERRIDE_RESOURCE
(i.e. everything except Xilleon) there should be no change.

patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

pcibios_override_resource infrastructure.  Initially for use with
xilleon port.

---
commit d559c11c9fecd8ec2a952982083e3a1fe118ab09
tree ee2da62d9441f3d829f79a9ff9912ba279b290fc
parent 8817d129d5d5fc662858925aa39ddda0cb3b73a0
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:32:14 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:32:14 -0700

 drivers/pci/setup-res.c |   10 ++++++----
 include/linux/pci.h     |    9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -127,10 +127,12 @@ int pci_assign_resource(struct pci_dev *
 	   required alignment in the "start" field. */
 	align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
 
-	/* First, try exact prefetching match.. */
-	ret = pci_bus_alloc_resource(bus, res, size, align, min,
-				     IORESOURCE_PREFETCH,
-				     pcibios_align_resource, dev);
+        ret = pcibios_override_resource(dev, resno);
+        if (ret)
+            /* First, try exact prefetching match.. */
+            ret = pci_bus_alloc_resource(bus, res, size, align, min,
+                                         IORESOURCE_PREFETCH,
+                                         pcibios_align_resource, dev);
 
 	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
 		/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -293,6 +293,15 @@ extern struct bus_type pci_bus_type;
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
+#ifdef CONFIG_PCIBIOS_OVERRIDE_RESOURCE
+int pcibios_override_resource(struct pci_dev *dev, int resno);
+#else
+static inline int pcibios_override_resource(struct pci_dev *dev, int resno)
+{
+    return 1;
+}
+#endif
+
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);
