Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:42:08 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51144 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006773AbaKXClCAeRpo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:02 +0100
Received: by mail-pa0-f46.google.com with SMTP id lj1so8626228pab.33
        for <multiple recipients>; Sun, 23 Nov 2014 18:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8tguyiAJ/ryKNEiuNivHK+2RB1cO2ZeEtVIMb/loKQ=;
        b=ach0/9hvI2gQsWZlCGJoYPTCCewXczFyfxHIYsNwbDfMcOhL13BphaHfmPwlS/c1V1
         MH55RrGUzPp13y5tpMVR9eqdB4dxGBoiNYdIsWQQRK+12FR3PSv2yzKMdOOG+EFACz1h
         4xtqog9iER9RsdrMMLrEr7PR1l5HbRC2VcbN5PEhyDyl5+ALZbOS9XI9NqD4L1O2nW/c
         VON/8nTWqzboUQ5t4yXjClalnrANx4PkjQakLv8Nsmn208c11mztYcuScwlGk8z/59rj
         2y+gLkSvMW8RXXJ0D5knKWQ1nOvoYsVdMJjaIIScOMqP/XFm+oFPzgUoxohJVG/svZDM
         KdBA==
X-Received: by 10.66.159.3 with SMTP id wy3mr28233081pab.98.1416796856366;
        Sun, 23 Nov 2014 18:40:56 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.40.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:40:55 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 04/11] irqchip: bcm7120-l2: fix error handling of irq_of_parse_and_map
Date:   Sun, 23 Nov 2014 18:40:39 -0800
Message-Id: <1416796846-28149-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44357
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

From: Dmitry Torokhov <dtor@chromium.org>

Return value of irq_of_parse_and_map() is unsigned int, with 0
indicating failure, so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e7c6155b23b8..8eec8e1201d9 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -102,9 +102,9 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	unsigned int idx;
 
 	parent_irq = irq_of_parse_and_map(dn, irq);
-	if (parent_irq < 0) {
+	if (!parent_irq) {
 		pr_err("failed to map interrupt %d\n", irq);
-		return parent_irq;
+		return -EINVAL;
 	}
 
 	/* For multiple parent IRQs with multiple words, this looks like:
-- 
2.1.1
