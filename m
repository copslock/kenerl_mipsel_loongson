Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 22:15:35 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:56420 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009442AbaLUVPSkL08L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Dec 2014 22:15:18 +0100
Received: from p4fe24560.dip0.t-ipconnect.de ([79.226.69.96]:51066 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y2nqQ-0007RR-0K; Sun, 21 Dec 2014 22:15:18 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 03/28] mips: pci: drop owner assignment from platform_drivers
Date:   Sun, 21 Dec 2014 22:14:24 +0100
Message-Id: <1419196495-9626-4-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 arch/mips/pci/pci-ar2315.c | 1 -
 arch/mips/pci/pci-rt2880.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index bd2b3b60da83..07a18228e63a 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -488,7 +488,6 @@ static struct platform_driver ar2315_pci_driver = {
 	.probe = ar2315_pci_probe,
 	.driver = {
 		.name = "ar2315-pci",
-		.owner = THIS_MODULE,
 	},
 };
 
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index a4574947e698..8a978022630b 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -267,7 +267,6 @@ static struct platform_driver rt288x_pci_driver = {
 	.probe = rt288x_pci_probe,
 	.driver = {
 		.name = "rt288x-pci",
-		.owner = THIS_MODULE,
 		.of_match_table = rt288x_pci_match,
 	},
 };
-- 
2.1.3
