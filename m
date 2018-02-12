Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 03:18:40 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:37145
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeBLCSdYhg9U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 03:18:33 +0100
Received: by mail-pg0-x242.google.com with SMTP id o1so6558758pgn.4
        for <linux-mips@linux-mips.org>; Sun, 11 Feb 2018 18:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wn0O4741S0zqDxbsHgsXFDN0SjcHs8gzzT/Y3hlLL/U=;
        b=rL4ZUwUsBZgH9vjQr1Q5m+W1T5exmBzYJw+OgPfDnsUcVxnzzJqLQ+dQjue4GcwThe
         67BHLt/0RdI0c75wpkUVBn1AlIJUIdP46yX/e//HDGx/k2mK7tzjQCTjzpXs1yIT5fh9
         oWLkUEzk0i0qVfgMZ+UWMYc22f0v3YNnv48aJ0LsKbFW7QrnxKpsQhdRVZKK2IiHKSdn
         NrnFro0M7MM0ewY1UINKkcqqTXkPUn42edAfd5oWPEN6yTFjQwxpEXnHyaBmu+PzL4Xm
         0VpTp+fhlYwHi+Dc42h1lVx/FTxd+RmKpSceKcSDF+RJTXlJlwCjyZ2PtJAkR3JJofsH
         W5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wn0O4741S0zqDxbsHgsXFDN0SjcHs8gzzT/Y3hlLL/U=;
        b=KTXn7wh7Fyn9AdCCxexa8RW6wFIuw8U00DbAE9sClX8/u4/cbGQwNMmbHLXdofdnSX
         6p0XS0jD4VU8YKmZiVNN61Chl48GSVgD7Ld1YmJ/WOqXKEOEpJ+KTxZPomO3YQLCnxJF
         fdKZzKnpj5gXiT+HQ6sCPUWd0kV7vebKZo+/W7ibdigm7VXvkKgc7ihB6t0XFugBHdW9
         YWl+ThAQumm1m0c4FV2zFLqal1v3n9IRm4R16DH8zlfH0e/BnwWIA/IFJdQe+kLjxmmt
         jZa8h6aztDFXmh8oy1lMC8QqomBJDVxaVvcekYX/OF5LXVoc/rGKjkW2p27cEP8ChQXw
         +Ahw==
X-Gm-Message-State: APf1xPAF07nTp0T0+tJdojPq6TS8hr9gO8cqqxKDcs0ezzYc0Hg79kEv
        4AsZi21EHnhEK9ugN08Eg9w=
X-Google-Smtp-Source: AH8x224Ce/pKfn4YLCJxW/08H8Fs1A7ihUljcjWEt6tZJqP++Kc2H3UJKUqjx9p9Z7Mr9xPJdI18VQ==
X-Received: by 10.99.177.4 with SMTP id r4mr8158568pgf.245.1518401906705;
        Sun, 11 Feb 2018 18:18:26 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q14sm18713554pgt.53.2018.02.11.18.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2018 18:18:26 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] irqchip: Remove hashed address printing
Date:   Mon, 12 Feb 2018 11:18:12 +0900
Message-Id: <20180212021812.3882-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62495
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
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful. so delete the prints.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 3 ---
 drivers/irqchip/irq-bcm7120-l2.c | 3 ---
 drivers/irqchip/irq-brcmstb-l2.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 55cfb986225b..faf734ff4cf3 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -339,9 +339,6 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
-	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
-		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
-
 	return 0;
 
 out_unmap:
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640eba418..8968e5e93fcb 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,9 +318,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
-	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
-			intc_name, data->map_base[0], data->num_parent_irqs);
-
 	return 0;
 
 out_free_domain:
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 691d20eb0bec..0e65f609352e 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -262,9 +262,6 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
-	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
-			base, parent_irq);
-
 	return 0;
 
 out_free_domain:
-- 
2.16.1
