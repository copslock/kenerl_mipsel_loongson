Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 14:41:17 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:45932 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491201Ab1AYNlO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 14:41:14 +0100
Received: by vws5 with SMTP id 5so2102029vws.36
        for <multiple recipients>; Tue, 25 Jan 2011 05:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=DW8T/RdUKwy6PgP8BSEsZNs+1p4c8oeg7NOs/z7b5TM=;
        b=MEpApU56FmcsnsvI/fbqIJrk6W+gjh1JPH9cMtBtN8lnHWH8vC7yteVUakznQqfXQn
         DfU+9xmxYVaTW4o15LUNqvX2KAuaMmM01A8l8UR8odADkptBvYr5S3obVU6856OEo1lm
         ycLQI9jrKZR3w9GgrQSbxCU5jkqFKFdmFIcQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZmpesXWLZt7CRmUJN5EzUuzqMUrXS5qPmD7QvQgPRhnsChMHeRC9gmVMcuyNnempyG
         iepvAkTEgH3JUGMSE2NPSC3jNnLd3lwkw8dI2J+RWZoz2JPjT8xeUoZ23+RiRKCCPbbT
         tpYnBB/SSK5VtXxdTiO/7iZkYPlhW5w5A9J6s=
Received: by 10.220.192.137 with SMTP id dq9mr1657975vcb.87.1295962868090;
        Tue, 25 Jan 2011 05:41:08 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id c4sm4567548vcc.30.2011.01.25.05.41.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 05:41:06 -0800 (PST)
Subject: [PATCH resend] ifdef gic_present variable that is used only by
 malta
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20110125132132.GA25526@linux-mips.org>
References: <1291221075.31413.24.camel@paanoop1-desktop>
         <20110125132132.GA25526@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 25 Jan 2011 19:27:26 +0530
Message-ID: <1295963846.27661.548.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

VSMP kernel build for non-malta platforms fails with following error

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/mips/built-in.o: In function `vsmp_init_secondary':
smp-mt.c:(.cpuinit.text+0x23cc): undefined reference to `gic_present'
smp-mt.c:(.cpuinit.text+0x23d0): undefined reference to `gic_present'
make: *** [.tmp_vmlinux1] Error 1

gic_present variable is declared only if IRQ_GIC is selected.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/kernel/smp-mt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index c0e8141..54235b5 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -151,6 +151,7 @@ static void vsmp_send_ipi_mask(const struct cpumask
*mask, unsigned int action)
 
 static void __cpuinit vsmp_init_secondary(void)
 {
+#ifdef CONFIG_IRQ_GIC
 	extern int gic_present;
 
 	/* This is Malta specific: IPI,performance and timer interrupts */
@@ -158,6 +159,7 @@ static void __cpuinit vsmp_init_secondary(void)
 		change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
 					 STATUSF_IP6 | STATUSF_IP7);
 	else
+#endif
 		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
 					 STATUSF_IP6 | STATUSF_IP7);
 }
-- 
1.7.0.4
