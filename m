Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 02:22:56 +0100 (BST)
Received: from mta2.srv.hcvlny.cv.net ([IPv6:::ffff:167.206.5.68]:41526 "EHLO
	mta2.srv.hcvlny.cv.net") by linux-mips.org with ESMTP
	id <S8226037AbUEPBWz>; Sun, 16 May 2004 02:22:55 +0100
Received: from mcs.bigip.mine.nu
 (ool-4353cae3.dyn.optonline.net [67.83.202.227]) by mta2.srv.hcvlny.cv.net
 (iPlanet Messaging Server 5.2 HotFix 1.25 (built Mar  3 2004))
 with ESMTP id <0HXS00IHF95ZQF@mta2.srv.hcvlny.cv.net> for
 linux-mips@linux-mips.org; Sat, 15 May 2004 21:22:49 -0400 (EDT)
Received: from mcs.bigip.mine.nu (localhost.localdomain [127.0.0.1])
	by mcs.bigip.mine.nu (8.12.11/8.12.11) with ESMTP id i4G1MnK8012278; Sat,
 15 May 2004 21:22:49 -0400
Received: (from mchouque@localhost)
	by mcs.bigip.mine.nu (8.12.11/8.12.11/Submit) id i4G1MjfH012276; Sat,
 15 May 2004 21:22:45 -0400
Date: Sat, 15 May 2004 21:22:45 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: [PATCH] Fix for 2.6.6 Makefiles to get KBUILD_OUTPUT working
To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	linux-alpha@vger.kernel.org, ralf@gnu.org,
	linux-mips@linux-mips.org, akpm@osdl.org, bjornw@axis.com,
	dev-etrax@axis.com
Mail-followup-to: Mathieu Chouquet-Stringer <mchouque@online.fr>,
 linux-kernel@vger.kernel.org, rth@twiddle.net, linux-alpha@vger.kernel.org,
 ralf@gnu.org, linux-mips@linux-mips.org, akpm@osdl.org, bjornw@axis.com,
 dev-etrax@axis.com
Message-id: <20040516012245.GA11733@localhost>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mchouque@mcs.bigip.mine.nu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchouque@online.fr
Precedence: bulk
X-list: linux-mips

	Hi,

if you use O=/someotherdir or KBUILD_OUTPUT=/someotherdir on the following
architectures: alpha, mips, sh and cris, the build process is probably
going to fail at one point or another, depending on the target you used,
because make can't find scripts/Makefile.build or scripts/Makefile.clean.

The following patch (which should apply cleanly to the latest 2.6.6 bk
tree) fixes this, I greped the whole tree and these four were the only
"offenders" I found.

PS: Andrew I mailed you because I couldn't find the maintainer for the sh
    port and you're the last who touched arch/sh/Makefile

--- arch/alpha/Makefile.orig	2004-05-15 20:46:06.000000000 -0400
+++ arch/alpha/Makefile	2004-05-15 20:47:52.000000000 -0400
@@ -106,10 +106,10 @@ boot := arch/alpha/boot
 all boot: $(boot)/vmlinux.gz
 
 $(boot)/vmlinux.gz: vmlinux
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $@
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
 bootimage bootpfile bootpzfile: vmlinux
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
@@ -121,7 +121,7 @@ include/asm-$(ARCH)/asm_offsets.h: arch/
 	$(call filechk,gen-asm-offsets)
 
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=$(boot)
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
 
--- arch/mips/Makefile.orig	2004-05-15 20:48:52.000000000 -0400
+++ arch/mips/Makefile	2004-05-15 20:49:58.000000000 -0400
@@ -686,7 +686,7 @@ vmlinux.64: vmlinux
 		--change-addresses=0xa800000080000000 $< $@
 endif
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/mips/boot $(1)
+makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot $(1)
 
 ifdef CONFIG_SGI_IP27
 all:	vmlinux.64
@@ -708,9 +708,9 @@ CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.rm200
 
 archclean:
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/boot
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/baget
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/lasat
+	@$(MAKE) $(clean)=arch/mips/boot
+	@$(MAKE) $(clean)=arch/mips/baget
+	@$(MAKE) $(clean)=arch/mips/lasat
 
 # Generate <asm/offset.h 
 #
--- arch/sh/boot/Makefile.orig	2004-05-15 20:50:11.000000000 -0400
+++ arch/sh/boot/Makefile	2004-05-15 20:50:41.000000000 -0400
@@ -16,5 +16,5 @@ $(obj)/zImage: $(obj)/compressed/vmlinux
 	@echo 'Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
--- arch/cris/Makefile.orig	2004-05-15 20:59:49.000000000 -0400
+++ arch/cris/Makefile	2004-05-15 21:00:36.000000000 -0400
@@ -81,7 +81,7 @@ compressed: zImage
 
 archmrproper:
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot	
+	$(Q)$(MAKE) $(clean)=arch/$(ARCH)/boot	
 	rm -f timage vmlinux.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 

-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
