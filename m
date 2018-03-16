Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 21:28:37 +0100 (CET)
Received: from mx2.mailbox.org ([80.241.60.215]:46014 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeCPU1ysk9T1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Mar 2018 21:27:54 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 6D76D40EBB;
        Fri, 16 Mar 2018 21:27:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id rbGJeALXRjTS; Fri, 16 Mar 2018 21:27:38 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com,
        "# 4 . 14+" <stable@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
Date:   Fri, 16 Mar 2018 21:27:30 +0100
Message-Id: <20180316202730.598-4-hauke@hauke-m.de>
In-Reply-To: <20180316202730.598-1-hauke@hauke-m.de>
References: <20180316202730.598-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63009
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

The Amazon SE also has similar reset controller system as Danube and
XWAY and use their drivers mostly. As these drivers now need syscon also
activate the syscon subsystem for for Amazon SE.

Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
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
