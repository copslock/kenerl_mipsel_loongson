Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:48:41 +0200 (CEST)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:60620 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009230AbaIRVrnqVtRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:43 +0200
Received: by mail-ob0-f202.google.com with SMTP id vb8so310632obc.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0AdZfv5trkKVtQLL4biy5QPNDp3LylGfrVFFSrNXII=;
        b=P6dRHssFVD8uAxCLUKBnAU5m+khwC/Zg6LneGnoLJFl/yK0iOhwVtUaFhWOrV2lcew
         yS9yTfm7wi/NVi0UJwHxj3K/Gy0yA2IRaJ89uU8bq0Yn3pDD5xJkx8ozQWsWEH5KWTn2
         lYsIgZ1t8iZW502G5RIIv7dmI7rzhqbUu6FMV+VS19ASEv//TOOWWjfvM15W6Hirh1JI
         b7v4sh9U4YHR5k/p0ajZ9wRrwoIx50yFGNFcwA20h9igPE7ad6LQ74z+TlecPQPkI4F+
         ceghSxwr+DL3VZjqSx5Dq2CS2ss4OiIfgqKrONPIQhACVWcUi2tS7m+3X+UcH2f4dK7h
         YboA==
X-Gm-Message-State: ALoCoQkIz/Zi0RQJr/q7dORvoX/MDxj4TpDEsEua9/9UdIHUgzAhnZRxI+iCWHWV/H55DRNtywfA
X-Received: by 10.42.212.207 with SMTP id gt15mr7350730icb.31.1411076857801;
        Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si3540yhe.3.2014.09.18.14.47.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.1; Thu, 18 Sep 2014 14:47:37 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 7A809220D21; Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/24] MIPS: Provide a generic plat_irq_dispatch
Date:   Thu, 18 Sep 2014 14:47:09 -0700
Message-Id: <1411076851-28242-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

For platforms which boot with device-tree or have correctly chained
all external interrupt controllers, a generic plat_irq_dispatch() can
be used.  Implement a plat_irq_dispatch() which simply handles all the
pending interrupts as reported by C0_Cause.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
Changes from v1:
 - handle interrupts in descending order
---
 arch/mips/kernel/irq_cpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index ca98a9f..531b11c 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -94,6 +94,24 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_eoi	= unmask_mips_irq,
 };
 
+asmlinkage void __weak plat_irq_dispatch(void)
+{
+	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	pending >>= CAUSEB_IP;
+	while (pending) {
+		irq = fls(pending) - 1;
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		pending &= ~BIT(irq);
+	}
+}
+
 static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 			     irq_hw_number_t hw)
 {
-- 
2.1.0.rc2.206.gedb03e5
