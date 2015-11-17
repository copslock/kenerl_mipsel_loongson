Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 17:23:27 +0100 (CET)
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:53606 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014040AbbKRQXZY8cmv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 17:23:25 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 1D011D8BE35;
        Tue, 17 Nov 2015 21:52:27 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 4B24CA624F;
        Tue, 17 Nov 2015 21:52:13 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Felix Fietkau <nbd@openwrt.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: ath79: Add a machine entry for booting OF machines
Date:   Tue, 17 Nov 2015 21:52:00 +0100
Message-Id: <1447793523-19430-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

As I'm using a board with a broken old bootloader I hardcoded the
mips_machtype and did't noticed that the machine entry was still
missing.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 9a00137..8755d61 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -281,3 +281,8 @@ MIPS_MACHINE(ATH79_MACH_GENERIC,
 	     "Generic",
 	     "Generic AR71XX/AR724X/AR913X based board",
 	     ath79_generic_init);
+
+MIPS_MACHINE(ATH79_MACH_GENERIC_OF,
+	     "DTB",
+	     "Generic AR71XX/AR724X/AR913X based board (DT)",
+	     NULL);
-- 
2.0.0
