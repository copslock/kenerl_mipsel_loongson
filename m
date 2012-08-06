Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2012 00:29:57 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53340 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903734Ab2HFW3x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2012 00:29:53 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SyVnt-0004qU-EN; Mon, 06 Aug 2012 17:29:37 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] usb: host: mips: sead3: Update for EHCI register structure.
Date:   Mon,  6 Aug 2012 17:29:31 -0500
Message-Id: <1344292171-3111-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 34066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

One line fix after 'struct ehci_regs' definition was changed
in commit a46af4ebf9ffec35eea0390e89935197b833dc61.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 drivers/usb/host/ehci-sead3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
index 58c96bd..0c9e43c 100644
--- a/drivers/usb/host/ehci-sead3.c
+++ b/drivers/usb/host/ehci-sead3.c
@@ -40,7 +40,7 @@ static int ehci_sead3_setup(struct usb_hcd *hcd)
 	ehci->need_io_watchdog = 0;
 
 	/* Set burst length to 16 words. */
-	ehci_writel(ehci, 0x1010, &ehci->regs->reserved[1]);
+	ehci_writel(ehci, 0x1010, &ehci->regs->reserved1[1]);
 
 	return ret;
 }
-- 
1.7.11.1
