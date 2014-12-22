Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 00:28:12 +0100 (CET)
Received: from mail-oi0-f73.google.com ([209.85.218.73]:58000 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009555AbaLVX1y6sah7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 00:27:54 +0100
Received: by mail-oi0-f73.google.com with SMTP id u20so1694555oif.0
        for <linux-mips@linux-mips.org>; Mon, 22 Dec 2014 15:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahG0M7+uM9PQTG0C567/CA8t2vsXIPEAABtpH65ATg4=;
        b=ISfEdlCHBU6V4XkGeEP9ua0AkJlwm0iIGzt18wbwOKHictqEE9PiU/lbeTrlKF9BS5
         JGoBv01DU7QJEN5ljQpiimAf4cyqJ3jtPR24H1JPBk13yajvlGj8TX+5598x4eOv9H7v
         ua6Ds9fFO1/KJh03DTAStgU86unH2bN/Drm+SrKLhC5DufbrvNhJq45nLv+qu/6Ub/6q
         m4MHWygqoZrhdpKPOqVKGKbZlGozHYE/kfbdgSz7bXuOSDADBzvks7kgnnRIGrWB4QJY
         WW0f94FtVX0T1EYsT2WWUoxQ+PFq2a+pA7bXvzMk4/h1IoGFE0QuYFnEL33/QhfY7EWA
         Q3WQ==
X-Gm-Message-State: ALoCoQln/P+idEXw7EUY886kaC22TaXGTJAnpqO5eSDBHenDH09A7Nj3FgwKgkLAGN0MIdNqPcXm
X-Received: by 10.182.250.164 with SMTP id zd4mr5419040obc.19.1419290869166;
        Mon, 22 Dec 2014 15:27:49 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 26si887586yhj.7.2014.12.22.15.27.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2014 15:27:49 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id n9MuMrHK.1; Mon, 22 Dec 2014 15:27:49 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3BFAB220874; Mon, 22 Dec 2014 15:27:48 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 2/2] MIPS: Add dtbs_install target
Date:   Mon, 22 Dec 2014 15:27:43 -0800
Message-Id: <1419290863-19788-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1419290863-19788-1-git-send-email-abrestic@chromium.org>
References: <1419290863-19788-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44893
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

Add the dtbs_install Makefile target to install the dtb files into
$INSTALL_DTBS_PATH.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9c4b9c8..6ff26bc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -356,6 +356,10 @@ PHONY += dtbs
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
 
+PHONY += dtbs_install
+dtbs_install:
+	$(Q)$(MAKE) $(dtbinst)=arch/mips/boot/dts
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
@@ -392,6 +396,7 @@ define archhelp
 	echo '  uImage               - U-Boot image'
 	echo '  uImage.gz            - U-Boot image (gzip)'
 	echo '  dtbs                 - Device-tree blobs for enabled boards'
+	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 endef
-- 
2.2.0.rc0.207.ga3a616c
