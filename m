Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 15:00:14 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:16257 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225756AbVBTO77>; Sun, 20 Feb 2005 14:59:59 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2sYv-0006wr-00; Sun, 20 Feb 2005 14:59:57 +0000
Date:	Sun, 20 Feb 2005 14:59:57 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalt fixes [4 of 6]
Message-ID: <20050220145957.GE26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Tulip fixes for Qube/RaQ in 2.6

P.

--- linux-cvs/drivers/net/tulip/eeprom.c	2004-12-04 18:16:05.000000000 +0000
+++ linux-wip/drivers/net/tulip/eeprom.c	2005-02-20 13:48:22.000000000 +0000
@@ -63,6 +63,22 @@ static struct eeprom_fixup eeprom_fixups
 	 */
 	{ 0x1e00, 0x0000, 0x000b, 0x8f01, 0x0103, 0x0300, 0x0821, 0x000, 0x0001, 0x0000, 0x01e1 }
   },
+  {"Cobalt Microserver", 0, 0x10, 0xE0, {0x1e00, /* 0 == controller #, 1e == offset	*/
+					 0x0000, /* 0 == high offset, 0 == gap		*/
+					 0x0800, /* Default Autoselect			*/
+					 0x8001, /* 1 leaf, extended type, bogus len	*/
+					 0x0003, /* Type 3 (MII), PHY #0		*/
+					 0x0400, /* 0 init instr, 4 reset instr		*/
+					 0x0801, /* Set control mode, GP0 output	*/
+					 0x0000, /* Drive GP0 Low (RST is active low)	*/
+					 0x0800, /* control mode, GP0 input (undriven)	*/
+					 0x0000, /* clear control mode			*/
+					 0x7800, /* 100TX FDX + HDX, 10bT FDX + HDX	*/
+					 0x01e0, /* Advertise all above			*/
+					 0x5000, /* FDX all above			*/
+					 0x1800, /* Set fast TTM in 100bt modes		*/
+					 0x0000, /* PHY cannot be unplugged		*/
+  }},
   {NULL}};
 
 
--- linux-cvs/drivers/net/tulip/media.c	2005-01-13 14:06:15.000000000 +0000
+++ linux-wip/drivers/net/tulip/media.c	2005-02-20 13:48:22.000000000 +0000
@@ -399,6 +399,9 @@ void tulip_select_media(struct net_devic
 	}
 
 	tp->csr6 = new_csr6 | (tp->csr6 & 0xfdff) | (tp->full_duplex ? 0x0200 : 0);
+
+	udelay(1000);
+
 	return;
 }
 
--- linux-cvs/drivers/net/tulip/tulip_core.c	2005-01-25 04:28:36.000000000 +0000
+++ linux-wip/drivers/net/tulip/tulip_core.c	2005-02-20 13:48:22.000000000 +0000
@@ -1511,8 +1511,8 @@ static int __devinit tulip_init_one (str
                     (PCI_SLOT(pdev->devfn) == 12))) {
                        /* Cobalt MAC address in first EEPROM locations. */
                        sa_offset = 0;
-                       /* No media table either */
-                       tp->flags &= ~HAS_MEDIA_TABLE;
+		       /* Ensure our media table fixup get's applied */
+		       memcpy(ee_data + 16, ee_data, 8);
                }
 #endif
 #ifdef CONFIG_GSC
