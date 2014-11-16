Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:20:21 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56661 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013761AbaKPAT3xvfgA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:29 +0100
Received: by mail-pd0-f174.google.com with SMTP id w10so122920pde.5
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bXcYVh2gLxFwZWcXASdSCFGdyNlV4k0e3S1jw4xlBvs=;
        b=K9ZQNnNGXqPN3l0sOdUX/lPZ442G4wwdqYnj9zfoI+SAG0Dq5CZ+aRFUjghI+dan9W
         nm8GCEpm6uwk0OiXvEX/gfSdURbFm5zclDi6Wz4B44O1/lvaUYwRBIV3N23Qa0JxiG+3
         4wPO9sXvmGJ5SG8xNqC3lCUvhUDE3IWfPbDEl7O99aHnYUKv93AAcJYltJgYijGYXjjf
         NKmr6gChgZZ8JmDfBqfvLSrX5PGYU4N3B6K4kqEbTAdaL8gIXSghefepEg5gcEn57HiW
         uU0JJNVO7pctFEjD4rAhulCD6V41CSKBbHiOzpxTii5R3hUVlhWU7GlO+Op381fwMH/t
         msjA==
X-Received: by 10.70.130.111 with SMTP id od15mr19628642pdb.47.1416097164080;
        Sat, 15 Nov 2014 16:19:24 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:23 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/22] irqchip: bcm7120-l2: fix error handling of irq_of_parse_and_map
Date:   Sat, 15 Nov 2014 16:17:27 -0800
Message-Id: <1416097066-20452-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44194
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
index e7c6155..8eec8e1 100644
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
