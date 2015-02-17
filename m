Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 03:10:08 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43539 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013083AbbBQCJgSt1V1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 03:09:36 +0100
Received: by pdev10 with SMTP id v10so40193657pde.10
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 18:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3B3u0v+smChWPGM9qthaXd3y4+xutFuwc84mxCfqCJk=;
        b=EMoPNkuivXrgLJcYeSPMoJdFliZY1OtD51m9j4Ko8CPfmzxviyd6xwclIUmER4NPLC
         DwTD/J8XBoGAlWWV3WiA9fKMs4UQZ8YmF9SUUWDPWDK570yxu/P53nwnTKITxuvSbfUz
         J3kmS+Q4q/ol2utqOQFyPSTZOXOAX4inDiXF5Ul9I9c4LcVjQM/HLRvTd85l+pF5gArb
         Ui6yikrTHAsmyQMwTyIhCTwzD2NZC6N68CSsGfDyFWjGFG3N/9kAHehAcpmj8Jn0mtJ6
         skJw0xiNhWoboOQuQZl47BC4RhxNbmklQZ5hDtXOe8qtli+1PFH9F4AcWykX+Q1vpyC4
         ewiQ==
X-Received: by 10.68.132.67 with SMTP id os3mr45473738pbb.1.1424138970965;
        Mon, 16 Feb 2015 18:09:30 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cq5sm13624562pbc.79.2015.02.16.18.09.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Feb 2015 18:09:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/4] hw_random: bcm63xx-rng: move register definitions to driver
Date:   Mon, 16 Feb 2015 18:09:14 -0800
Message-Id: <1424138956-11563-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h contains the register
definitions for this random number generator block, incorporate these
register definitions directly into the bcm63xx-rng driver so we do not
rely on this header to be provided.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm63xx-rng.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index ed9b28b35a39..c7f3af852599 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -13,7 +13,15 @@
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 
-#include <bcm63xx_regs.h>
+#define RNG_CTRL			0x00
+#define RNG_EN				(1 << 0)
+
+#define RNG_STAT			0x04
+#define RNG_AVAIL_MASK			(0xff000000)
+
+#define RNG_DATA			0x08
+#define RNG_THRES			0x0c
+#define RNG_MASK			0x10
 
 struct bcm63xx_rng_priv {
 	struct clk *clk;
-- 
2.1.0
