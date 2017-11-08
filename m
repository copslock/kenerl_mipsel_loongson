Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:55:41 +0100 (CET)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5573 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993913AbdKHUxHclRgC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174387; x=1541710387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=l8FLobqpATkEX0rl9HLD2G4sm7GdJVn+n7cResbC17qK1KqBd4sKmVAU
   X6XkVjuMPS+zxzmtikw/q6HDcQuiKKe7j/+m6sGSfDk4L1yqPL7GK5y7d
   n8wanjXsYR/eH/LjAjwlTd+7IFNLLZn3NQPoNZ9u3V20NtYoJtfx/aY9p
   4=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 08 Nov 2017 20:52:55 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174361; x=1541710361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=Yx8VUR+tcQam2E7VTj26lBCZk0/NEF6wbu7if8Fh07vgmFJh+8wXSUe8
   fCToOR0Erkb1q2AC3kz+hgYaPUgCc9AxGxapZTYq3FVDnBdswPXClyDqc
   nmK0EJXlnjHRIN2iaSLJxMS9YnRzzHf+r/eKw7oMGH6MSeAQ71M9YARLE
   Y=;
Received: from pioneer.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.34])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174360; x=1541710360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSCak13Jqpev54b+1N9IL/5Xfvg15AQcH4tQgdXJSX4=;
  b=q9hXX55wiTJkNqU2aJp/7Gr0t4t2NK9+EdmsvR6/n1EhAwlByWpVrnMt
   /1GSNM/Ny49cj3AbimsnYAP7nO+qTxCkjf/3ZWjiWl/JAa0OJmosgYEx5
   Uobjjbm6TGou+2Zx3LNbaE1qiSmXcc4jvBx0ddv9end7MxwrTYkyf7rYA
   c=;
X-Host: pioneer.tdc.vzwcorp.com
Received: from ohtwi1exh002.uswin.ad.vzwcorp.com ([10.144.218.44])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:52:40 +0000
Received: from tbwexch26apd.uswin.ad.vzwcorp.com (153.114.162.50) by
 OHTWI1EXH002.uswin.ad.vzwcorp.com (10.144.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:52:40 -0500
Received: from OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) by
 tbwexch26apd.uswin.ad.vzwcorp.com (153.114.162.50) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:52:40 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:52:39 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:52:39 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-3.18 27/27] MIPS: Use Makefile.postlink to insert
 relocations into vmlinux
Thread-Topic: [PATCH AUTOSEL for-3.18 27/27] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
Thread-Index: AQHTWNNJkYmCjg/KXUe7KgYob30wSQ==
Date:   Wed, 8 Nov 2017 20:51:01 +0000
Message-ID: <20171108205049.27612-27-alexander.levin@verizon.com>
References: <20171108205049.27612-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205049.27612-1-alexander.levin@verizon.com>
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
X-archive-position: 60768
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
