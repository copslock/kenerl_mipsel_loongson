Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2009 17:09:10 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:41751 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492960AbZIUPJC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Sep 2009 17:09:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 24AD052C387;
	Mon, 21 Sep 2009 17:08:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHWAUhsW9HQg; Mon, 21 Sep 2009 17:08:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id CF7A652C3D6;
	Mon, 21 Sep 2009 17:08:55 +0200 (CEST)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 89D1B6DF893; Mon, 21 Sep 2009 17:06:55 +0200 (CEST)
Received: by pc-004.diku.dk (Postfix, from userid 3767)
	id B1FE83841D; Mon, 21 Sep 2009 17:08:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id AC6A93830C;
	Mon, 21 Sep 2009 17:08:55 +0200 (CEST)
Date:	Mon, 21 Sep 2009 17:08:55 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	dmitri.vorobiev@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] arch/mips: remove duplicate structure field initialization
Message-ID: <Pine.LNX.4.64.0909211708200.8549@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

The definition of the irq_ipi structure has two initializations of the
flags field.  This combines them.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier I, s, fld;
position p0,p;
expression E;
@@

struct I s =@p0 { ... .fld@p = E, ...};

@s@
identifier I, s, r.fld;
position r.p0,p;
expression E;
@@

struct I s =@p0 { ... .fld@p = E, ...};

@script:python@
p0 << r.p0;
fld << r.fld;
ps << s.p;
pr << r.p;
@@

if int(ps[0].line)!=int(pr[0].line) or int(ps[0].column)!=int(pr[0].column):
  cocci.print_main(fld,p0)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/kernel/smtc.c             |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 67153a0..4d181df 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -1098,9 +1098,8 @@ static void ipi_irq_dispatch(void)
 
 static struct irqaction irq_ipi = {
 	.handler	= ipi_interrupt,
-	.flags		= IRQF_DISABLED,
-	.name		= "SMTC_IPI",
-	.flags		= IRQF_PERCPU
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "SMTC_IPI"
 };
 
 static void setup_cross_vpe_interrupts(unsigned int nvpe)
