Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 16:01:01 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:3285
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224847AbTCXQBA>; Mon, 24 Mar 2003 16:01:00 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18xUNd-0000cG-00
	for <linux-mips@linux-mips.org>; Mon, 24 Mar 2003 10:00:57 -0600
Message-ID: <3E7F2BB4.8060108@realitydiluted.com>
Date: Mon, 24 Mar 2003 11:00:52 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Proposed patch for MIPS PCI autoscanning code...
Content-Type: multipart/mixed;
 boundary="------------080607010901090009070100"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080607010901090009070100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In the PCI autoscanning code for MIPS the assumption is made that the
generic 'pci_read_XXX' and 'pci_write_XXX' will suffice when initially
autoscanning the bus. These functions are defined in the main top-level
PCI code. For one of my platforms, this simply does not hold since the
platform specific PCI functions defined in the 'pci_ops' structure for
the 'mips_pci_channel' need to be used. I propose the following patch
to fix this. Comments before I apply this?

-Steve

--------------080607010901090009070100
Content-Type: text/plain;
 name="pci_channel.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_channel.h.diff"

--- pci_channel.h	2001-08-18 10:19:34.000000000 -0400
+++ pci_channel.h.new	2003-03-24 10:54:29.000000000 -0500
@@ -11,12 +11,13 @@
 #include <linux/pci.h>
 
 /*
- * Each pci channel is a top-level PCI bus seem by CPU.  A machine  with
+ * Each pci channel is a top-level PCI bus seen by CPU.  A machine  with
  * multiple PCI channels may have multiple PCI host controllers or a
  * single controller supporting multiple channels.
  */
 struct pci_channel {
 	struct pci_ops *pci_ops;
+	struct pci_ops *early_pci_ops;
 	struct resource *io_resource;
 	struct resource *mem_resource;
 	int first_devfn;

--------------080607010901090009070100
Content-Type: text/plain;
 name="pci_auto.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_auto.c.diff"

--- pci_auto.c	2001-11-26 20:07:06.000000000 -0500
+++ pci_auto.c.new	2003-03-24 10:54:14.000000000 -0500
@@ -74,9 +74,14 @@
 int early_##rw##_config_##size(struct pci_channel *hose,		\
 	int top_bus, int bus, int devfn, int offset, type value)	\
 {									\
-	return pci_##rw##_config_##size(				\
-		fake_pci_dev(hose, top_bus, bus, devfn),		\
-		offset, value);						\
+	if (hose->early_pci_ops->rw##_##size != NULL)			\
+		return hose->early_pci_ops->rw##_##size(		\
+			fake_pci_dev(hose, top_bus, bus, devfn),	\
+			offset, value);					\
+	else								\
+		return pci_##rw##_config_##size(			\
+			fake_pci_dev(hose, top_bus, bus, devfn),	\
+			offset, value);					\
 }
 
 EARLY_PCI_OP(read, byte, u8 *)

--------------080607010901090009070100--
