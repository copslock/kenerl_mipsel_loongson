Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2005 17:36:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:41180 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225321AbVH3Qfr>; Tue, 30 Aug 2005 17:35:47 +0100
Received: from localhost (p2237-ipad27funabasi.chiba.ocn.ne.jp [220.107.193.237])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5810584DA; Wed, 31 Aug 2005 01:41:53 +0900 (JST)
Date:	Wed, 31 Aug 2005 01:42:36 +0900 (JST)
Message-Id: <20050831.014236.122253682.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: pcibios_bus_to_resource prototype.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

MIPS lacks pcibios_bus_to_resource prototype which is new on 2.6.13.

Index: include/asm-mips/pci.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.63
diff -u -r1.63 pci.h
--- include/asm-mips/pci.h	15 Aug 2005 15:16:56 -0000	1.63
+++ include/asm-mips/pci.h	30 Aug 2005 16:31:55 -0000
@@ -143,6 +143,9 @@
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 	struct pci_bus_region *region, struct resource *res);
 
+extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+				    struct pci_bus_region *region);
+
 #ifdef CONFIG_PCI_DOMAINS
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
