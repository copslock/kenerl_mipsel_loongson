Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 23:50:23 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1522 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225281AbTHFWuV>;
	Wed, 6 Aug 2003 23:50:21 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA21379
	for <linux-mips@linux-mips.org>; Wed, 6 Aug 2003 15:50:19 -0700
Message-ID: <3F31862A.F2162035@mvista.com>
Date: Wed, 06 Aug 2003 16:50:18 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.6:makefile/vmlinux.srec
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> the make srec patch looks good to me.  I will take care of it.
> Also, please post patches for both branches whenever possible.

Here is the 2.6 version of the 2.4 srec build patch:

cvs diff -uN arch/mips/Makefile arch/mips/boot/Makefile
Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.131
diff -u -r1.131 Makefile
--- arch/mips/Makefile  30 Jul 2003 12:32:17 -0000      1.131
+++ arch/mips/Makefile  4 Aug 2003 23:59:12 -0000
@@ -531,6 +531,9 @@
 vmlinux.ecoff vmlinux.rm200: vmlinux
        +@$(call makeboot,$@)
 
+vmlinux.srec: vmlinux
+       +@$(call makeboot,$@)
+
 CLEAN_FILES += vmlinux.ecoff \
               vmlinux.rm200.tmp \
               vmlinux.rm200
Index: arch/mips/boot/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/boot/Makefile,v
retrieving revision 1.22
diff -u -r1.22 Makefile
--- arch/mips/boot/Makefile     9 Mar 2003 13:58:13 -0000       1.22
+++ arch/mips/boot/Makefile     4 Aug 2003 23:59:12 -0000
@@ -22,7 +22,7 @@
 drop-sections  = .reginfo .mdebug .comment .note
 strip-flags    = $(addprefix --remove-section=,$(drop-sections))
 
-all: vmlinux.ecoff addinitrd
+all: vmlinux.ecoff vmlinux.srec addinitrd
 
 vmlinux.rm200: vmlinux
        $(OBJCOPY) \
@@ -37,6 +37,9 @@
 $(obj)/elf2ecoff: $(obj)/elf2ecoff.c
        $(HOSTCC) -o $@ $^
 
+vmlinux.srec:  vmlinux
+       $(OBJCOPY) -S -O srec $(strip-flags) vmlinux $(obj)/vmlinux.srec
+
 $(obj)/addinitrd: $(obj)/addinitrd.c
        $(HOSTCC) -o $@ $^
 
@@ -47,5 +50,6 @@
               elf2ecoff \
               vmlinux.ecoff \
               vmlinux.rm200 \
+              vmlinux.srec \
               zImage.tmp \
               zImage
