Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 22:08:53 +0100 (CET)
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36950 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014216AbcCQVIvom7AE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 22:08:51 +0100
Received: by mail-wm0-f45.google.com with SMTP id p65so11480317wmp.0;
        Thu, 17 Mar 2016 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kDzcmDUFcUzqCnaNPneHV3fCza97UJhhdL23prUZg08=;
        b=yjybtANpv9zKIdPBflVZaKLIU8Vlt/AWFj7k6J9X97mih6LHzbi5UD+ImF9UjOsr96
         PSCci6pmu2DJ/+ea8xKVKuvrUOKAYXfRzfUbcLzBYEzgY+Y7FQvGP9xqesg3qK93AOhJ
         jU8NjWs3z4aBBnXG7xeuOmBTvYmntGliu1f5j2wDVmi0pzot2H2wlH5ArZVN8mHN+Xzv
         +wp8ckz6EnBxqSWt2ZnKRFc7aCqf4vKh8mX3oYf2yFuvfn19ERYDoQGZe4ov6P3D82+c
         PK83m5lc8eLhJprlrW0rbD9/jtMvuV6Nkmq6Q3zPQwQJbrl+2JstDiW7L4oLZfxBj/JU
         RK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDzcmDUFcUzqCnaNPneHV3fCza97UJhhdL23prUZg08=;
        b=DgZKPEKr9yKL6EBu11GhQyOw6Sl0TXZ3/RyoJnpa7P4AI/K2Y/PzVX+tBuAPqaeEig
         ebsgyVZRcmZWgbtpxPN9iC7R2OGYVZYSaw/RXG/BjWP5UdvijZVVkOmJmns+6A/zGuEJ
         jlyYqj0VKwP5tdXDz/IHv5uNUSJ7ezCRejLvIgqP+cLb3gnRD9ZnDnnalB+fYJKJvm/O
         K3IMhTwftu2z9Sm1nT4m6aoOA+gqWaFzjHCAdJBreEj7DJ6oicXc2kfXSzmMvzW0jiHN
         E5Eh3nrMxpOMer/g4fajNeXvQ5PTvkx9f64wvj3fwuD00ll86a/P/FWB2ue3HfcZEcHz
         30+Q==
X-Gm-Message-State: AD7BkJLqZLX/JeNQG7qLluj6dlnbaXkhtCaZhlp/9o8hL+J0pNGiDJK8icdp1NePw6etiw==
X-Received: by 10.194.58.169 with SMTP id s9mr12372810wjq.52.1458248926477;
        Thu, 17 Mar 2016 14:08:46 -0700 (PDT)
Received: from localhost.localdomain (host81-157-242-128.range81-157.btcentralplus.com. [81.157.242.128])
        by smtp.gmail.com with ESMTPSA id i2sm9358470wje.22.2016.03.17.14.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 14:08:45 -0700 (PDT)
From:   Qais Yousef <qsyousef@gmail.com>
To:     ralf@linux-mips.org
Cc:     Qais Yousef <qsyousef@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix broken malta qemu
Date:   Thu, 17 Mar 2016 21:08:09 +0000
Message-Id: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
X-Mailer: git-send-email 2.7.3
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qsyousef@gmail.com
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

Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
new IPI code to be activated. But on qemu malta there's no GIC causing a
BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().

Since in that configuration one can only run a single core SMP (!), skip IPI
initialisation if we detect that this is the case. It is a sensible behaviour
to introduce and should keep such possible configuration to run rather than die
hard unnecessarily.

Signed-off-by: Qais Yousef <qsyousef@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/smp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 37708d9..27cb638 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -243,6 +243,18 @@ static int __init mips_smp_ipi_init(void)
 	struct irq_domain *ipidomain;
 	struct device_node *node;
 
+	/*
+	 * In some cases like qemu-malta, it is desired to try SMP with
+	 * a single core. Qemu-malta has no GIC, so an attempt to set any IPIs
+	 * would cause a BUG_ON() to be triggered since there's no ipidomain.
+	 *
+	 * Since for a single core system IPIs aren't required really, skip the
+	 * initialisation which should generally keep any such configurations
+	 * happy and only fail hard when trying to truely run SMP.
+	 */
+	if (cpumask_weight(cpu_possible_mask) == 1)
+		return 0;
+
 	node = of_irq_find_parent(of_root);
 	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
 
-- 
2.7.3
