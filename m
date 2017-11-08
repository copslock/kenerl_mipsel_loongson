Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:56:26 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993921AbdKHUxlGPXRC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174421; x=1541710421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhCi18v7NBA+SSx8FBMM35EpSkq5+GMEIO0HH2dLRQ0=;
  b=VO+lDOSgYVDDdtjLYM0ymgmIO4iv4RqOuzqKbGKfy0jA4VpliOFNbxzg
   +z15AOPM/WVlXwqMkY7TXbafjJwHFUBA8KSH2v0wE2b8otnVGGzXZtrT1
   SrXyOWLW58KytLf8ZZF01G7YRwCYcBYzaYHGR2RVtMezCkuEot6yCjcwt
   4=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:32 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174259; x=1541710259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhCi18v7NBA+SSx8FBMM35EpSkq5+GMEIO0HH2dLRQ0=;
  b=iNYiqji2LaUUcDS7s9VUASvYZnvbILldzaCFncjLSt4BNCLVySlpeHd4
   vUu3tlx35DUCdOwN+QczScehEBZK3egRlFQHfDMuC6IaPZUbXjuWW3gJ1
   7n4+DQ+/WYwFx+TunPaEMkkS9lPJmn2NmBFdFDw6anpXTx0m7Mljs5Spg
   Y=;
Received: from surveyor.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.83])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174259; x=1541710259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhCi18v7NBA+SSx8FBMM35EpSkq5+GMEIO0HH2dLRQ0=;
  b=iNYiqji2LaUUcDS7s9VUASvYZnvbILldzaCFncjLSt4BNCLVySlpeHd4
   vUu3tlx35DUCdOwN+QczScehEBZK3egRlFQHfDMuC6IaPZUbXjuWW3gJ1
   7n4+DQ+/WYwFx+TunPaEMkkS9lPJmn2NmBFdFDw6anpXTx0m7Mljs5Spg
   Y=;
X-Host: surveyor.tdc.vzwcorp.com
Received: from ohtwi1exh002.uswin.ad.vzwcorp.com ([10.144.218.44])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:50:59 +0000
Received: from OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) by
 OHTWI1EXH002.uswin.ad.vzwcorp.com (10.144.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:50:58 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:50:57 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:50:57 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.9 53/53] MIPS: Use Makefile.postlink to insert
 relocations into vmlinux
Thread-Topic: [PATCH AUTOSEL for-4.9 53/53] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
Thread-Index: AQHTWNMpd3T01Uvin0u6mNl3lwYW3g==
Date:   Wed, 8 Nov 2017 20:50:07 +0000
Message-ID: <20171108204940.27321-53-alexander.levin@verizon.com>
References: <20171108204940.27321-1-alexander.levin@verizon.com>
In-Reply-To: <20171108204940.27321-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@one.verizon.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Matt Redfearn <matt.redfearn@imgtec.com>

[ Upstream commit 44079d3509aee89c58f3e4fd929fa53ab2299019 ]

When relocatable support for MIPS was merged, there was no support for
an architecture to add a postlink step for vmlinux. This meant that only
invoking a target within the boot directory, such as uImage, caused the
relocations to be inserted into vmlinux. Building just the vmlinux
target would result in a relocatable kernel with no relocation
information present.

Commit fbe6e37dab97 ("kbuild: add arch specific post-link Makefile")
recified this situation, so MIPS can now define a postlink step to add
relocation information into vmlinux, and remove the additional steps
tacked onto boot targets.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Tested-by: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14554/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/Makefile          | 12 ------------
 arch/mips/Makefile.postlink | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/Makefile.postlink

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7b076f..fb7664c31259 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -327,10 +327,6 @@ rom.bin rom.sw: vmlinux
 		$(bootvars-y) $@
 endif
 
-CMD_RELOCS = arch/mips/boot/tools/relocs
-quiet_cmd_relocs = RELOCS  $<
-      cmd_relocs = $(CMD_RELOCS) $<
-
 #
 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
@@ -339,11 +335,6 @@ quiet_cmd_relocs = RELOCS  $<
 quiet_cmd_32 = OBJCOPY $@
 	cmd_32 = $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.32: vmlinux
-ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_64BIT),yy)
-# Currently, objcopy fails to handle the relocations in the elf64
-# So the relocs tool must be run here to remove them first
-	$(call cmd,relocs)
-endif
 	$(call cmd,32)
 
 #
@@ -359,9 +350,6 @@ all:	$(all-y)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE
-ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_32BIT),yy)
-	$(call cmd,relocs)
-endif
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
 		$(bootvars-y) arch/mips/boot/$@
 
diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
new file mode 100644
index 000000000000..b0ddf0701a31
--- /dev/null
+++ b/arch/mips/Makefile.postlink
@@ -0,0 +1,35 @@
+# ===========================================================================
+# Post-link MIPS pass
+# ===========================================================================
+#
+# 1. Insert relocations into vmlinux
+
+PHONY := __archpost
+__archpost:
+
+include include/config/auto.conf
+include scripts/Kbuild.include
+
+CMD_RELOCS = arch/mips/boot/tools/relocs
+quiet_cmd_relocs = RELOCS $@
+      cmd_relocs = $(CMD_RELOCS) $@
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifeq ($(CONFIG_RELOCATABLE),y)
+	$(call if_changed,relocs)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@true
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.11.0
