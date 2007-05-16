Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 17:33:46 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:4419 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023306AbXEPQdp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2007 17:33:45 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5BBA83EC9; Wed, 16 May 2007 09:33:41 -0700 (PDT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] EMMA2RH: remove dead KGDB code
Date:	Wed, 16 May 2007 20:35:13 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705162035.13910.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Get rid of the cross-arch KGDB specific code which shouldn't have been there in
the first place...

Signed-off-by: Sergey Shtylyov <sshtylyov@ru.mvista.com>

---

 arch/mips/emma2rh/markeins/setup.c |   24 ------------------------
 1 files changed, 24 deletions(-)

Index: linux-mips/arch/mips/emma2rh/markeins/setup.c
===================================================================
--- linux-mips.orig/arch/mips/emma2rh/markeins/setup.c
+++ linux-mips/arch/mips/emma2rh/markeins/setup.c
@@ -115,30 +115,6 @@ extern void markeins_irq_setup(void);
 
 static void inline __init markeins_sio_setup(void)
 {
-#ifdef CONFIG_KGDB_8250
-	struct uart_port emma_port;
-
-	memset(&emma_port, 0, sizeof(emma_port));
-
-	emma_port.flags =
-	    UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	emma_port.iotype = UPIO_MEM;
-	emma_port.regshift = 4;	/* I/O addresses are every 8 bytes */
-	emma_port.uartclk = 18544000;	/* Clock rate of the chip */
-
-	emma_port.line = 0;
-	emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3);
-	emma_port.membase = (u8*)emma_port.mapbase;
-	early_serial_setup(&emma_port);
-
-	emma_port.line = 1;
-	emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3);
-	emma_port.membase = (u8*)emma_port.mapbase;
-	early_serial_setup(&emma_port);
-
-	emma_port.irq = EMMA2RH_IRQ_PFUR1;
-	kgdb8250_add_port(1, &emma_port);
-#endif
 }
 
 void __init plat_mem_setup(void)
