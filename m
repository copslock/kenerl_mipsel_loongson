Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 18:58:00 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33463 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009753AbaLYR5J2HWlK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:09 +0100
Received: by mail-pd0-f172.google.com with SMTP id y13so11864941pdi.31;
        Thu, 25 Dec 2014 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cqv7JwmAiTTbraCDZgHHdLoqtKR1qvx8g40PnPrYsZ8=;
        b=KVIjQuaudTVHYXvkxRfx/sv1H8MYzcWKpDo5dlMd0nC0JjJKjis+zotf93fb+Qs2wL
         vk3Ue6g9+bBU/3cZo/LOmcxYmo0EyPEhSSRqMg/fYqxlLJ2UkM2pg8RQQUsTo2S1SyD7
         q0JhMZUxNkIfn9KuQY6lGKYAUbOOMOwSppOfF6MZbrGY+o6xowOYtEbPpkLz5r6YDUzC
         lS3p2GCD/QRp2WwdF0BFOFaYImLnlkOif3Znc1TOxQcRVCKdfSDpWvV4v/AgUY59ilbY
         xLTELoy4SNqApUC8I5LCEGT7ySp0RQS8agHHyR+mjMNqvzmMrmpfxNnV9rCFGD0tUY6e
         G/1w==
X-Received: by 10.70.56.72 with SMTP id y8mr62175862pdp.45.1419530223854;
        Thu, 25 Dec 2014 09:57:03 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:03 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 03/25] MIPS: Add dtbs_install target
Date:   Thu, 25 Dec 2014 09:48:58 -0800
Message-Id: <1419529760-9520-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

From: Andrew Bresticker <abrestic@chromium.org>

Add the dtbs_install Makefile target to install the dtb files into
$INSTALL_DTBS_PATH.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Tested-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 269db7e..6aadefb 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -352,6 +352,10 @@ PHONY += dtbs
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
 
+PHONY += dtbs_install
+dtbs_install:
+	$(Q)$(MAKE) $(dtbinst)=arch/mips/boot/dts
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
@@ -388,6 +392,7 @@ define archhelp
 	echo '  uImage               - U-Boot image'
 	echo '  uImage.gz            - U-Boot image (gzip)'
 	echo '  dtbs                 - Device-tree blobs for enabled boards'
+	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 endef
-- 
2.1.1
