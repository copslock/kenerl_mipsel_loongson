Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2018 18:42:29 +0100 (CET)
Received: from mx2.mailbox.org ([80.241.60.215]:22302 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993004AbeCKRluHEHZW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Mar 2018 18:41:50 +0100
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B3B0740F74;
        Sun, 11 Mar 2018 18:41:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id YxfsnBDGjXgW; Sun, 11 Mar 2018 18:41:44 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
Date:   Sun, 11 Mar 2018 18:41:23 +0100
Message-Id: <20180311174123.2578-3-hauke@hauke-m.de>
In-Reply-To: <20180311174123.2578-1-hauke@hauke-m.de>
References: <20180311174123.2578-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Mathias Kresin <dev@kresin.me>

Enable syscon to use it for the RCU MFD on Amazon SE as well.

Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/lantiq/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 692ae85a3e3d..8e3a1fc2bc39 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -13,6 +13,8 @@ choice
 config SOC_AMAZON_SE
 	bool "Amazon SE"
 	select SOC_TYPE_XWAY
+	select MFD_SYSCON
+	select MFD_CORE
 
 config SOC_XWAY
 	bool "XWAY"
-- 
2.11.0
