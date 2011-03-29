Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 08:55:18 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:40230 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1C2Gyz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2011 08:54:55 +0200
Received: by iwn36 with SMTP id 36so5154503iwn.36
        for <multiple recipients>; Mon, 28 Mar 2011 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :in-reply-to:references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=tPvgZAGv2INzUvmCy4u7Qj9NSq/pHScTqq5bKmRRYdg=;
        b=yEUukDsQh9QVeLpXd6Gj5aH+IL1G3dNSbBQPAITtmmUrPzmVGdx8po7R1EvbGNruvo
         tKPHtZgOlxf6sc0mk6dGhpEOEt+P4KDxtDPuJn+K/tXvwrl2Mu9cVYshoQtjq5dLXPMw
         uGjYq3S+LK3drtb1wIEHRcWCgQgnjXceipx4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kjgOObCn2BnxXGZ9mnZXn94Yyk8VnDfiN1b8tGgJ+UlqjJ1PoWZHv/xFaBXzVvjutW
         vdaEsqAch6rW8qOOHpOqATCAcSAWhdEFIpsG8/XXCGUeE9e4Mp7SvOHHPKIvbSRKES0L
         jzqPZCwfqXQBR/vqwGPT1hkafgJjT1jiJroG4=
Received: by 10.42.156.131 with SMTP id z3mr8417782icw.305.1301381689122;
        Mon, 28 Mar 2011 23:54:49 -0700 (PDT)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id gx2sm3455568ibb.60.2011.03.28.23.54.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 23:54:48 -0700 (PDT)
Date:   Tue, 29 Mar 2011 15:53:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: msp71xx: fix typo in msp_per_irq_controller
Message-Id: <20110329155356.bda3c255.yuasa@linux-mips.org>
In-Reply-To: <20110329155223.08fbef97.yuasa@linux-mips.org>
References: <20110329155223.08fbef97.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

  CC      arch/mips/pmc-sierra/msp71xx/msp_irq_per.o
arch/mips/pmc-sierra/msp71xx/msp_irq_per.c:101:2: error: expected identifier before '.' token
make[2]: *** [arch/mips/pmc-sierra/msp71xx/msp_irq_per.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
index f9b9dcd..98fd009 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
@@ -97,7 +97,7 @@ static int msp_per_irq_set_affinity(struct irq_data *d,
 
 static struct irq_chip msp_per_irq_controller = {
 	.name = "MSP_PER",
-	.irq_enable = unmask_per_irq.
+	.irq_enable = unmask_per_irq,
 	.irq_disable = mask_per_irq,
 	.irq_ack = msp_per_irq_ack,
 #ifdef CONFIG_SMP
-- 
1.7.3.4
