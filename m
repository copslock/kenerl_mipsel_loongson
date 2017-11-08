Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:54:11 +0100 (CET)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5573 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993908AbdKHUxEZA-gC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174384; x=1541710384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=LjgpQL91jMnpaQ7hcb97Ici6cSUt6S+QswsnwLhQB+IMeTM2WHw4gOjR
   h3VlrelxJqNaABLPrUewV2DH9UGiyfHKI8wkte1ZmBSlIJ5cGPWLTF6gm
   fiYncAg01zAm5kDj8FGQhEsU01XqfRC7hxZOIND4Wu122OtOhWgfkm77B
   w=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 08 Nov 2017 20:52:54 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174344; x=1541710344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=tcoBVjt8JSGUT2DCznend3N0Go0WcMDiRbZL8y3lAlNnlqfTPr2tuE/3
   yWGdtDBUQTd1BRbmeE+3bsG+Nh0dZ2mr+HHJPFRvVoj1iXNR7WaVAhmaM
   0nDXQNQYoTtca/cBfI92HC2neyY2/f6bw4SZT3CrlrL6ZPxCri3ZMdAH1
   c=;
Received: from surveyor.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.83])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174344; x=1541710344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=tcoBVjt8JSGUT2DCznend3N0Go0WcMDiRbZL8y3lAlNnlqfTPr2tuE/3
   yWGdtDBUQTd1BRbmeE+3bsG+Nh0dZ2mr+HHJPFRvVoj1iXNR7WaVAhmaM
   0nDXQNQYoTtca/cBfI92HC2neyY2/f6bw4SZT3CrlrL6ZPxCri3ZMdAH1
   c=;
X-Host: surveyor.tdc.vzwcorp.com
Received: from ohtwi1exh001.uswin.ad.vzwcorp.com ([10.144.218.43])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:52:24 +0000
Received: from tbwexch25apd.uswin.ad.vzwcorp.com (153.114.162.49) by
 OHTWI1EXH001.uswin.ad.vzwcorp.com (10.144.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:52:24 -0500
Received: from OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) by
 tbwexch25apd.uswin.ad.vzwcorp.com (153.114.162.49) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:52:23 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:52:22 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:52:22 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.4 39/39] MIPS: Use Makefile.postlink to insert
 relocations into vmlinux
Thread-Topic: [PATCH AUTOSEL for-4.4 39/39] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
Thread-Index: AQHTWNM+uKnh1XQhTUW3lZKZsrMQnQ==
Date:   Wed, 8 Nov 2017 20:50:43 +0000
Message-ID: <20171108205027.27525-39-alexander.levin@verizon.com>
References: <20171108205027.27525-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205027.27525-1-alexander.levin@verizon.com>
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
X-archive-position: 60764
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
 arch/mips/Makefile.postlink | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/mips/Makefile.postlink

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
