Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB73Rhd10264
	for linux-mips-outgoing; Thu, 6 Dec 2001 19:27:43 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB73Rbo10255;
	Thu, 6 Dec 2001 19:27:37 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fB72RtB30096;
	Thu, 6 Dec 2001 18:27:55 -0800
Message-ID: <3C102913.EDBD2EB@mvista.com>
Date: Thu, 06 Dec 2001 18:27:31 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com,
   ralf@oss.sgi.com
Subject: Re: [PATCH] pci_auto handles better when no IO/MEM behind P2P bridge
References: <3C1024A2.F3603F6A@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------A437717BFF4D7DA85C567418"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------A437717BFF4D7DA85C567418
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Perhaps this one is better.

It wastes a little PCI space, but looks more elegant...  Is elegance still
worth anything? :-)

Jun
--------------A437717BFF4D7DA85C567418
Content-Type: text/plain; charset=us-ascii;
 name="pci-auto-p2p-bridge-noiomem.011205.011206.b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-auto-p2p-bridge-noiomem.011205.011206.b.patch"

diff -Nru linux-2.4.16/arch/mips/kernel/pci_auto.c.orig linux-2.4.16/arch/mips/kernel/pci_auto.c
--- linux-2.4.16/arch/mips/kernel/pci_auto.c.orig	Mon Nov 26 18:22:58 2001
+++ linux-2.4.16/arch/mips/kernel/pci_auto.c	Thu Dec  6 18:24:00 2001
@@ -256,6 +256,14 @@
 {
 	u32 temp;
 
+	/* 
+	 * [jsun] we always bump up baselines a little, so that if there 
+	 * nothing behind P2P bridge, we don't wind up overlapping IO/MEM 
+	 * spaces.
+	 */
+	pciauto_lower_memspc += 1;
+	pciauto_lower_iospc += 1;
+
 	/* Configure bus number registers */
 	early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
 				PCI_SUBORDINATE_BUS, sub_bus);

--------------A437717BFF4D7DA85C567418--
