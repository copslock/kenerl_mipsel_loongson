Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 12:42:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18895 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030917AbcEXKmoe46OM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 12:42:44 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id D93B0ED0ABAB0;
        Tue, 24 May 2016 11:42:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 11:42:38 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 11:42:34 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] genirq: Fix missing return value in irq_destroy_ipi()
Date:   Tue, 24 May 2016 11:42:30 +0100
Message-ID: <1464086550-24734-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit 7cec18a3906b ("genirq: Add error code reporting to
irq_{reserve,destroy}_ipi") changed the return type of irq_destroy_ipi
to int, but missed adding a value to one return statement. Fix this to
silence the resultant compiler warning:

kernel/irq/ipi.c In function ‘irq_destroy_ipi’:
kernel/irq/ipi.c:128:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]
  return;
  ^
Fixes: 7cec18a3906b ("genirq: Add error code reporting to
irq_{reserve,destroy}_ipi")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 kernel/irq/ipi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index c42742208e5e..89b49f6773f0 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -125,7 +125,7 @@ int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 
 	domain = data->domain;
 	if (WARN_ON(domain == NULL))
-		return;
+		return -EINVAL;
 
 	if (!irq_domain_is_ipi(domain)) {
 		pr_warn("Trying to destroy a non IPI domain!\n");
-- 
2.5.0
