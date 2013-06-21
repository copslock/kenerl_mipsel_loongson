Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 13:13:27 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51152 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3FULNUADhC- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 13:13:20 +0200
Received: by mail-pb0-f51.google.com with SMTP id um15so7616718pbc.38
        for <multiple recipients>; Fri, 21 Jun 2013 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=q8mYNbUZg0JP5Zim7LzXhREyuqz93kAU8F/gbI+6wIE=;
        b=pcUEHnXijdL2FIs//S9cRgP7RtESiIVJBeh+44S/+89lJfg2qkWUPcEPJDoUDwfEFR
         cl5Vq6cCH39YD68JxoGY8Zso++8OXHuu+UTWHtDSCBabmSaJolEyX25K9rXK1u7ZObDI
         zaJa4cvP/Gc5cYGzY0XefQvwuVHZKE/YU7/K0r6rRXH8AVZAK1i1jePORwbGbVbBBJJS
         3aT5pSeSwEh9GCKOPr8jrDR7rNCkAul+ShKjydcJ1rsTfWwE3PwYe/wRUxGkKjsrDFXb
         1hrhncu4hWwIB9ikwqXX+IBLsHzw5DbQGfy4pDQjpbVSe7ta3lvkURyEWpd5pjy2LtjE
         oHfQ==
X-Received: by 10.66.159.234 with SMTP id xf10mr15781866pab.203.1371813193518;
        Fri, 21 Jun 2013 04:13:13 -0700 (PDT)
Received: from hades.local (111-243-154-157.dynamic.hinet.net. [111.243.154.157])
        by mx.google.com with ESMTPSA id p2sm5235048pag.22.2013.06.21.04.13.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:13:12 -0700 (PDT)
Date:   Fri, 21 Jun 2013 19:13:08 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix gic_set_affinity infinite loop
Message-ID: <20130621111308.GC23231@hades.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

There is an infinite loop in gic_set_affinity. When irq_set_affinity
gets called on gic controller, it blocks forever.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/irq-gic.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index c01b307..5b5ddb2 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -219,16 +219,15 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
-	for (;;) {
-		/* Re-route this IRQ */
-		GIC_SH_MAP_TO_VPE_SMASK(irq, first_cpu(tmp));
 
-		/* Update the pcpu_masks */
-		for (i = 0; i < NR_CPUS; i++)
-			clear_bit(irq, pcpu_masks[i].pcpu_mask);
-		set_bit(irq, pcpu_masks[first_cpu(tmp)].pcpu_mask);
+	/* Re-route this IRQ */
+	GIC_SH_MAP_TO_VPE_SMASK(irq, first_cpu(tmp));
+
+	/* Update the pcpu_masks */
+	for (i = 0; i < NR_CPUS; i++)
+		clear_bit(irq, pcpu_masks[i].pcpu_mask);
+	set_bit(irq, pcpu_masks[first_cpu(tmp)].pcpu_mask);
 
-	}
 	cpumask_copy(d->affinity, cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
-- 
1.7.10.2
