Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 03:11:10 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35922
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeBICLD1YNvm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Feb 2018 03:11:03 +0100
Received: by mail-pg0-x244.google.com with SMTP id j9so1578192pgv.3
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2018 18:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=465ADEDqd6gnMa+m44C7Iat5vnXRvIOYZZWHJapYBE4=;
        b=Tm/zsTOrcdy725k2QGzQlaOupfOZrFaDNDP5Z6BpJ6L6pF+ZUqwXz0BBAbF2h7NCyt
         6Kg0vRxL8l092LcZjlyHWzACeKwUAqLcLKTkO2t6qaSwvYFbcNXD//p6keTWS6yg5S/X
         yna7XhNIFuGZyKewhsmRcidSWN4b5UlY86Odj4h0sp9k+apgBtwhKfGVOuWQFRfFdKdP
         2ovT/DWummeZUdEltwynlA0AIP3UzjmLW8glTk+J2SIi4wcVqui+T97DWTv0kU49OaS3
         DQc7yk/Ju38n4ZadJnqak+F2Cz1zJzCdpSDjvCXd0GWydJewwCK5783lS5kDrPUfyHce
         lHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=465ADEDqd6gnMa+m44C7Iat5vnXRvIOYZZWHJapYBE4=;
        b=R4qqCDvG4g9sQOVxBfeg/ojc9Phn3DljhatvzXcb15QP3i70XDEykncSbV2Otvi2iv
         ssZ9zpqFL04GH7pKETQFbRGk5kADKOOy30N12RirHj+GufApRpe5qYOydGudRq7jTZeG
         woiFytzIJ0bS/6PWoOoYbrC0S1GfLxyXD+qn109E3co7RAm/LN/yrA8LnhkOLQcu4UJv
         +VEBSxyPKSflqv3s5lt+ER3aNVY6/jQ7X1r6YZ2dplF7fmjs6jMlI7pzezvFf0bqSkv8
         cphrN9bEKEWsAwqA9GqsWy/LL7lAOiI3xS0nABce+U0iEpwOMlgez4uk2b/RqMvrMcOa
         CLsw==
X-Gm-Message-State: APf1xPBqiU+g5TmN7H0r1BR8l7lVew0H1UyxFziL47oA2WDFJMy6HBpK
        fQFbA5mYrJXNo+gEZFFfDwk=
X-Google-Smtp-Source: AH8x225+0a4woUk1KBd7b3+yeCbliUYP2Ncz76I8OMKbHyV0UYEaO866Le41XWOCmNyQWtBu38kk+w==
X-Received: by 10.98.141.208 with SMTP id p77mr1099514pfk.5.1518142256837;
        Thu, 08 Feb 2018 18:10:56 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id e9sm2240413pgv.14.2018.02.08.18.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 18:10:56 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] irqchip: Use %px to print pointer value
Date:   Fri,  9 Feb 2018 11:10:31 +0900
Message-Id: <20180209021031.20631-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers printed with %p are hashed. Use %px instead of %p to print
pointer value.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 drivers/irqchip/irq-brcmstb-l2.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 55cfb986225b..f604c1d89b3b 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
-	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
+	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
 		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
 
 	return 0;
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640eba418..1cc4dd1d584a 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
-	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
+	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
 			intc_name, data->map_base[0], data->num_parent_irqs);
 
 	return 0;
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 691d20eb0bec..6760edeeb666 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
-	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
+	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
 			base, parent_irq);
 
 	return 0;
-- 
2.16.1
