Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 16:03:26 +0100 (BST)
Received: from p508B7BFA.dip.t-dialin.net ([IPv6:::ffff:80.139.123.250]:8992
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225733AbUF2PDV>; Tue, 29 Jun 2004 16:03:21 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5TF3I8T026014;
	Tue, 29 Jun 2004 17:03:18 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5TF3H4M026013;
	Tue, 29 Jun 2004 17:03:17 +0200
Date: Tue, 29 Jun 2004 17:03:16 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
Message-ID: <20040629150316.GB23741@linux-mips.org>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl> <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl> <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be> <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 29, 2004 at 03:49:11PM +0200, Maciej W. Rozycki wrote:
> Date: Tue, 29 Jun 2004 15:49:11 +0200 (CEST)
> From: "Maciej W. Rozycki" <macro@linux-mips.org>
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>,
> 	Linux/MIPS Development <linux-mips@linux-mips.org>
> Subject: Re: [patch] Incorrect mapping of serial ports to lines
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Tue, 29 Jun 2004, Geert Uytterhoeven wrote:
> 
> > The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
> > serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.
> > 
> > To me it sounds the most logical if the one in the Nile 4 is ttyS0.
> 
>  Then we need to find a way to make the order configurable somehow.

How about you leave CONFIG_HAVE_STD_PC_SERIAL_PORT disabled for Malta then
and supply your own MALTA_SERIAL_PORT_DEFNS instead then?  That would
require some small changes to no longer nest the CONFIG_SERIAL_MANY_PORTS
ifdef inside CONFIG_HAVE_STD_PC_SERIAL_PORT - about as below.

  Ralf

Index: include/asm-mips/serial.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/serial.h,v
retrieving revision 1.23.2.18
diff -u -r1.23.2.18 serial.h
--- include/asm-mips/serial.h	18 Dec 2003 01:51:37 -0000	1.23.2.18
+++ include/asm-mips/serial.h	29 Jun 2004 14:56:06 -0000
@@ -184,6 +184,18 @@
 #define TXX927_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_MIPS_MALTA
+#define MALTA_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
+	{ ...  extra Malta blurb goes here },		/* ttyS2 */	\
+	{ ...  extra Malta blurb goes here },		/* ttyS3 */	\
+
+#else /* CONFIG_MIPS_MALTA */
+#define MALTA_SERIAL_PORT_DEFNS
+#endif /* CONFIG_MIPS_MALTA */
+
 #ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
@@ -192,6 +204,10 @@
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
 
+#else /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
+#define STD_SERIAL_PORT_DEFNS
+#endif /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
+
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define EXTRA_SERIAL_PORT_DEFNS			\
 	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
@@ -226,11 +242,6 @@
 #define EXTRA_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SERIAL_MANY_PORTS */
 
-#else /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
-#define STD_SERIAL_PORT_DEFNS
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
-
 /* You can have up to four HUB6's in the system, but I've only
  * included two cards here for a total of twelve ports.
  */
@@ -416,18 +427,20 @@
 	COBALT_SERIAL_PORT_DEFNS		\
 	DDB5477_SERIAL_PORT_DEFNS		\
 	EV96100_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS			\
-	HUB6_SERIAL_PORT_DFNS			\
 	ITE_SERIAL_PORT_DEFNS           	\
 	IVR_SERIAL_PORT_DEFNS           	\
 	JAZZ_SERIAL_PORT_DEFNS			\
+	MALTA_SERIAL_PORT_DEFNS			\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS	\
 	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS	\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS	\
 	MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS	\
 	SEAD_SERIAL_PORT_DEFNS			\
-	STD_SERIAL_PORT_DEFNS			\
 	TITAN_SERIAL_PORT_DEFNS			\
-	TXX927_SERIAL_PORT_DEFNS
+	TXX927_SERIAL_PORT_DEFNS		\
+						\
+	STD_SERIAL_PORT_DEFNS			\
+	EXTRA_SERIAL_PORT_DEFNS			\
+	HUB6_SERIAL_PORT_DFNS			\
 
 #endif /* _ASM_SERIAL_H */
