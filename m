Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jul 2004 16:09:40 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:57826 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225367AbUGBPJf>; Fri, 2 Jul 2004 16:09:35 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7FD6547777; Fri,  2 Jul 2004 17:09:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 6D5994762F; Fri,  2 Jul 2004 17:09:28 +0200 (CEST)
Date: Fri, 2 Jul 2004 17:09:28 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <20040629150316.GB23741@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0407021645080.8992@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
 <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>
 <20040629150316.GB23741@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jun 2004, Ralf Baechle wrote:

> How about you leave CONFIG_HAVE_STD_PC_SERIAL_PORT disabled for Malta then
> and supply your own MALTA_SERIAL_PORT_DEFNS instead then?  That would
> require some small changes to no longer nest the CONFIG_SERIAL_MANY_PORTS
> ifdef inside CONFIG_HAVE_STD_PC_SERIAL_PORT - about as below.

 I couldn't care less about CONFIG_SERIAL_MANY_PORTS for Malta -- the
ports it adds are AFAIK all ISA boards.  While in theory one can have a
PCI-ISA bridge and a bus extender on an option card (such devices exist,
I'm told), I don't think it's possible to use one with Malta as it already
includes a PCI-ISA bridge onboard.  If there's a need for such stuff in
the future, it can be added then.  After a brief look at the sources I
think the option itself might actually depend on CONFIG_ISA.

 So I propose the following simpler patch instead.  I'd like to have the
comment included so that no one tries to "fix" the order in the future
without a careful consideration.  It works for me.

 OK to apply?

  Maciej

patch-mips-2.4.26-20040531-mips-serial-2
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips/serial.h linux-mips-2.4.26-20040531/include/asm-mips/serial.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips/serial.h	2004-06-13 23:16:56.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips/serial.h	2004-07-02 00:40:52.000000000 +0000
@@ -410,14 +410,23 @@
 #define DDB5477_SERIAL_PORT_DEFNS
 #endif
 
+/*
+ * The order matters here and should be as follows:
+ *
+ * 1. board-specific ports (please keep sorted)
+ * 2. STD_SERIAL_PORT_DEFNS
+ * 3. EXTRA_SERIAL_PORT_DEFNS
+ * 4. HUB6_SERIAL_PORT_DFNS
+ *
+ * otherwise serial line numbers may change across
+ * kernel builds if configuration changes. --macro
+ */
 #define SERIAL_PORT_DFNS			\
 	ATLAS_SERIAL_PORT_DEFNS			\
 	AU1000_SERIAL_PORT_DEFNS		\
 	COBALT_SERIAL_PORT_DEFNS		\
 	DDB5477_SERIAL_PORT_DEFNS		\
 	EV96100_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS			\
-	HUB6_SERIAL_PORT_DFNS			\
 	ITE_SERIAL_PORT_DEFNS           	\
 	IVR_SERIAL_PORT_DEFNS           	\
 	JAZZ_SERIAL_PORT_DEFNS			\
@@ -426,8 +435,11 @@
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
+	HUB6_SERIAL_PORT_DFNS
 
 #endif /* _ASM_SERIAL_H */
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips64/serial.h linux-mips-2.4.26-20040531/include/asm-mips64/serial.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips64/serial.h	2003-12-18 03:57:25.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips64/serial.h	2004-07-02 00:41:05.000000000 +0000
@@ -146,13 +146,23 @@
 #define IP27_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SGI_IP27 */
 
+/*
+ * The order matters here and should be as follows:
+ *
+ * 1. board-specific ports (please keep sorted)
+ * 2. STD_SERIAL_PORT_DEFNS
+ *
+ * otherwise serial line numbers may change across
+ * kernel builds if configuration changes. --macro
+ */
 #define SERIAL_PORT_DFNS				\
 	IP27_SERIAL_PORT_DEFNS				\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS		\
 	SEAD_SERIAL_PORT_DEFNS				\
-	STD_SERIAL_PORT_DEFNS				\
-	TITAN_SERIAL_PORT_DEFNS
+	TITAN_SERIAL_PORT_DEFNS				\
+							\
+	STD_SERIAL_PORT_DEFNS
 
 #define RS_TABLE_SIZE	64
 
