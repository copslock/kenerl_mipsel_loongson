Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2004 22:38:33 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:2892
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225459AbUDGVic>; Wed, 7 Apr 2004 22:38:32 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 1BBKkc-0001WY-00; Wed, 07 Apr 2004 23:38:26 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] LASAT updates
Cc: linux-mips@linux-mips.org
Message-Id: <E1BBKkc-0001WY-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Wed, 07 Apr 2004 23:38:26 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf, 
	this is a small patch to make the Lasat rom image build again
after some LDFLAGS changes which broke it.

/Brian

Index: arch/mips/lasat/image/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/image/Makefile,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 Makefile
--- arch/mips/lasat/image/Makefile	24 Feb 2003 21:26:19 -0000	1.1.2.3
+++ arch/mips/lasat/image/Makefile	30 Jan 2004 11:30:03 -0000
@@ -24,12 +24,13 @@
 
 LDSCRIPT= -Tromscript.normal
 
-AFLAGS_head.o = -D_kernel_start=0x$(KERNEL_START) \
+HEAD_DEFINES = -D_kernel_start=0x$(KERNEL_START) \
 		-D_kernel_entry=0x$(KERNEL_ENTRY) \
 		-D VERSION="\"$(Version)\"" \
 		-D TIMESTAMP=$(shell date +%s) 
 
-head.o: $(KERNEL_IMAGE)
+head.o: head.S $(KERNEL_IMAGE)
+	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
 
 OBJECTS= head.o kImage.o
 
@@ -44,7 +45,7 @@
 	$(LD) $(LDFLAGS) $(LDSCRIPT) -o rom $(OBJECTS) 
 
 %.o: %.gz
-	$(LD) -r -o $@ -b binary $<
+	$(LD) $(LDFLAGS) -r -o $@ -b binary $<
 
 %.gz: %.bin
 	gzip -cf -9 $< > $@
