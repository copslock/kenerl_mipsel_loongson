Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2003 01:05:49 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7154 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224772AbTHEAFh>;
	Tue, 5 Aug 2003 01:05:37 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA22611
	for <linux-mips@linux-mips.org>; Mon, 4 Aug 2003 17:05:35 -0700
Message-ID: <3F2EF4CE.5D5BBC1E@mvista.com>
Date: Mon, 04 Aug 2003 18:05:34 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.4:makefile/vmlinux.srec
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips


This patch allows an srec kernel to be built directly.

cvs diff -uN arch/mips/Makefile arch/mips/boot/Makefile
Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.78.2.36
diff -u -r1.78.2.36 Makefile
--- arch/mips/Makefile  5 Jul 2003 13:17:03 -0000       1.78.2.36
+++ arch/mips/Makefile  4 Aug 2003 23:53:38 -0000
@@ -627,6 +627,9 @@
 vmlinux.ecoff: vmlinux
        @$(MAKEBOOT) $@
 
+vmlinux.srec: vmlinux
+       @$(MAKEBOOT) $@
+
 archclean:
        @$(MAKEBOOT) clean
        rm -f arch/$(ARCH)/ld.script
Index: arch/mips/boot/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/boot/Makefile,v
retrieving revision 1.13.2.2
diff -u -r1.13.2.2 Makefile
--- arch/mips/boot/Makefile     1 Aug 2002 18:20:59 -0000       1.13.2.2
+++ arch/mips/boot/Makefile     4 Aug 2003 23:53:38 -0000
@@ -24,7 +24,7 @@
 drop-sections  = .reginfo .mdebug
 strip-flags    = $(addprefix --remove-section=,$(drop-sections))
 
-all: vmlinux.ecoff addinitrd
+all: vmlinux.ecoff vmlinux.srec addinitrd
 
 vmlinux.ecoff: $(CONFIGURE) elf2ecoff $(TOPDIR)/vmlinux
        ./elf2ecoff $(TOPDIR)/vmlinux vmlinux.ecoff $(E2EFLAGS)
@@ -32,6 +32,9 @@
 elf2ecoff: elf2ecoff.c
        $(HOSTCC) -o $@ $^
 
+vmlinux.srec: $(CONFIGURE) $(TOPDIR)/vmlinux
+       $(OBJCOPY) -S -O srec $(strip-flags) $(TOPDIR)/vmlinux vmlinux.srec
+
 addinitrd: addinitrd.c
        $(HOSTCC) -o $@ $^
 
@@ -40,10 +43,12 @@
 
 clean:
        rm -f vmlinux.ecoff
+       rm -f vmlinux.srec
        rm -f zImage zImage.tmp
 
 mrproper:
        rm -f vmlinux.ecoff
+       rm -f vmlinux.srec
        rm -f addinitrd
        rm -f elf2ecoff
