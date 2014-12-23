Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 17:44:29 +0100 (CET)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:47196 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009679AbaLWQoLAzBhm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 17:44:11 +0100
Received: by mail-ig0-f202.google.com with SMTP id hn18so662418igb.3
        for <linux-mips@linux-mips.org>; Tue, 23 Dec 2014 08:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XcWp6xnv6P2lFTf1+gflsBqL2KsPNoSmf5cyp5yxtFU=;
        b=CyZ3GXTw0mrf8vxu8mc8PhuaustZoMosRcqMIX+4kjDeEFbe7ueMKUO4Q7nEClpYh5
         BBdjoAJeRLKP053yqUqtOiyFAyXwGoPbv7QwFfK4CfS6QFm8TA/Mo/oN0LW636Thm56W
         02jeNCnJROW70yXlwHROmET2t+Btr8Q91mVtQvrE/onXCMrKnD20nGUj6iTi+clT/rLM
         eTV7MzMReOm5cYQxEmf8YT1vGcMxy+Rpn+mpUZX1KJx8ms+teF+NSPGgJyTHi7tjOKAk
         u7qFM39SYCy/0F6fztQ8naOtcYgZKB/c128CP2tGOUiyvl3OlTURlpYbryl2RxM/chCF
         5MgQ==
X-Gm-Message-State: ALoCoQmOVdWNr0TSk0P7EV07rwVurSki/Urub2CxCiObpMpCoa1WgYcEqZpL8fftF6wyD5ibbTIF
X-Received: by 10.183.11.37 with SMTP id ef5mr21583190obd.6.1419353045211;
        Tue, 23 Dec 2014 08:44:05 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id u27si983844yhu.4.2014.12.23.08.44.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2014 08:44:05 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id KcaF6nqj.1; Tue, 23 Dec 2014 08:44:05 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 300C42205BC; Tue, 23 Dec 2014 08:44:04 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH V2 2/2] MIPS: Add dtbs_install target
Date:   Tue, 23 Dec 2014 08:43:52 -0800
Message-Id: <1419353032-10340-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1419353032-10340-1-git-send-email-abrestic@chromium.org>
References: <1419353032-10340-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44902
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
No changes from v1.
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
