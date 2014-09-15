Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 19:54:46 +0200 (CEST)
Received: from mail-oa0-f74.google.com ([209.85.219.74]:33290 "EHLO
        mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008986AbaIORyJ6pBYr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 19:54:09 +0200
Received: by mail-oa0-f74.google.com with SMTP id g18so444101oah.1
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KVAcyEjYab1mtVgYaIKM+pWILvpcTRsqRQcf7iFSM8Q=;
        b=U1dXoMRRammXDXpgRswleRVY2/+Gx9FuBiiK58YqWuwpyRFUBHVfRap4cVDp+jZj78
         x7pcxS3h8j6HxPv3J2/xeu5K7xRGvijvVrKFgCWq33uiZbXDOnkN1zl2lifFBDgisp8I
         C3Mg33ryiFgKzottW8Xda+3YL9sJevqJTAsahW4C0K5BN7K1B6A4BEQ6YRzGo6ujQJPs
         WAywIBkXbhCdq+LWTIDmMrhgevYK/LKeMiFtNxCvHmfgOkVaCe1ffj641F2+qKFNSvzD
         BX9amvHtvYALavixVLzEw7rt8/9e+ap+6ocqc4+JPYxFjqB3Eo1Gwhx1hgxZAvTIpnJd
         f1IQ==
X-Gm-Message-State: ALoCoQlMJRhtmxLHUqoJbq5DkJd824YKsoDA4XhO8JWUmpxxs9KO7IEUEGUkGHJFkRLb/nRfH+PK
X-Received: by 10.42.118.200 with SMTP id y8mr17011848icq.4.1410803643754;
        Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si575736yha.6.2014.09.15.10.54.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id SoSUYnNV.1; Mon, 15 Sep 2014 10:54:03 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C56D0220E4E; Mon, 15 Sep 2014 10:54:01 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] MIPS: Add support for building and installing device-tree binaries
Date:   Mon, 15 Sep 2014 10:53:58 -0700
Message-Id: <1410803639-3159-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410803639-3159-1-git-send-email-abrestic@chromium.org>
References: <1410803639-3159-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add 'dtbs' and 'dtbs_install" Makefile targets that build and install
the device-tree binaries enabled by the configuration.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v2:
 - added 'dtbs_install' target
 - removed 'dtbs' target from dts makefile
No changes from v1.
---
 arch/mips/Makefile        | 10 ++++++++++
 arch/mips/boot/.gitignore |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 72cdd6a..434c834 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -330,6 +330,14 @@ core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
 %.dtb %.dtb.S %.dtb.o: | scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
 
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
+
+dtbs_install:
+	$(Q)$(MAKE) $(dtbinst)=arch/mips/boot/dts
+
+PHONY += dtbs dtbs_install
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
@@ -364,6 +372,8 @@ define archhelp
 	echo '  vmlinuz.srec         - SREC zboot image'
 	echo '  uImage               - U-Boot image'
 	echo '  uImage.gz            - U-Boot image (gzip)'
+	echo '  dtbs                 - Device-tree blobs for enabled boards'
+	echo '  dtbs_install         - Install dtbs into $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 endef
diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
index a73d6e2..d3962cd 100644
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -5,3 +5,4 @@ zImage
 zImage.tmp
 calc_vmlinuz_load_addr
 uImage
+*.dtb
-- 
2.1.0.rc2.206.gedb03e5
