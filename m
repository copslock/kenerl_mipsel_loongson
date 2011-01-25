Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 07:53:34 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:54682 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491129Ab1AYGxb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 07:53:31 +0100
Received: by ywf7 with SMTP id 7so1604789ywf.36
        for <multiple recipients>; Mon, 24 Jan 2011 22:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=QSc6cL9bFBw1WnwfS+Jpd+bmaeaG2fPGwDFgFZYWF7c=;
        b=Dly7NCgfUWBcztYVqDPSEa4it3sY0MhN0tTHmVoDGVAXlA9BNdacsje/nZ0+We+2Vs
         J2VrI/4rZoyD5KhvGuNkwEmRLR2fhh/h0RriRKglp++PzGmclaX2bFKupN26SarCREEp
         K/KzWgDZaEqHBrefvtf4i+U6zzgOkdDUG8QwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s4rHZNEri1m/iVgo4uf9GDrKpC+H6Ot2TAr5hX6GOZ7sPnsAYqkhNNFvKFZ+1GpqW9
         lGQHAM40O4BTMJySLpmEMT0rE26ipJDw1A77K5fAfs2KX09Vnh9Uq9BRwOJAskdHmrt8
         Sm7PCuDpGCZDzKK4ucOPOAH0Iye85Ysham+Pc=
Received: by 10.151.111.17 with SMTP id o17mr5938211ybm.294.1295938405174;
        Mon, 24 Jan 2011 22:53:25 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id q4sm3552150ybe.12.2011.01.24.22.53.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Jan 2011 22:53:22 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH] Fix build error for non-malta VSMP kernel.
Date:   Tue, 25 Jan 2011 12:39:15 +0530
Message-Id: <1295939355-7281-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

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
@@ -151,6 +151,7 @@ static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 
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
