Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7H397N20133
	for linux-mips-outgoing; Thu, 16 Aug 2001 20:09:07 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7H393j20130
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 20:09:04 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 17 Aug 2001 03:09:03 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 52C1354CDB; Fri, 17 Aug 2001 12:09:01 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA72165; Fri, 17 Aug 2001 12:09:01 +0900 (JST)
Date: Fri, 17 Aug 2001 12:13:34 +0900 (JST)
Message-Id: <20010817.121334.41627251.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: patch for ide_init_hwif_ports
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Aug_17_12:13:34_2001_424)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Fri_Aug_17_12:13:34_2001_424)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There is 'ide_init_hwif_ports' member in ide_ops structure but
currently never used.  This is a patch to use this (again).

---
Atsushi Nemoto

----Next_Part(Fri_Aug_17_12:13:34_2001_424)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="ide.patch"

diff -ur linux.sgi/arch/mips/lib/ide-std.c linux/arch/mips/lib/ide-std.c
--- linux.sgi/arch/mips/lib/ide-std.c	Thu Jun 17 22:25:49 1999
+++ linux/arch/mips/lib/ide-std.c	Fri Aug 17 11:55:49 2001
@@ -60,6 +60,7 @@
 	}
 	if (irq != NULL)
 		*irq = 0;
+	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
 static int std_ide_request_irq(unsigned int irq,
diff -ur linux.sgi/include/asm-mips/ide.h linux/include/asm-mips/ide.h
--- linux.sgi/include/asm-mips/ide.h	Tue Apr 24 02:46:11 2001
+++ linux/include/asm-mips/ide.h	Fri Aug 17 11:54:36 2001
@@ -56,21 +56,7 @@
 static inline void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
                                        ide_ioreg_t ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
+	ide_ops->ide_init_hwif_ports(hw, data_port, ctrl_port, irq);
 }
 
 static __inline__ void ide_init_default_hwifs(void)

----Next_Part(Fri_Aug_17_12:13:34_2001_424)----
