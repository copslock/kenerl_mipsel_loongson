Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 09:42:28 +0100 (CET)
Received: from mgw2.diku.dk ([130.225.96.92]:46503 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491154Ab0BFImV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Feb 2010 09:42:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id 2566219BBA2;
        Sat,  6 Feb 2010 09:42:18 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07291-12; Sat,  6 Feb 2010 09:42:17 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id 0530E19BBC5;
        Sat,  6 Feb 2010 09:42:17 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id 31C5E6DF893; Sat,  6 Feb 2010 09:37:14 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id E1003200AA; Sat,  6 Feb 2010 09:42:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id D93F1200A9;
        Sat,  6 Feb 2010 09:42:16 +0100 (CET)
Date:   Sat, 6 Feb 2010 09:42:16 +0100 (CET)
From:   Julia Lawall <julia@diku.dk>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/11] arch/mips/sni: Correct NULL test
Message-ID: <Pine.LNX.4.64.1002060942010.8092@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Test the value that was just allocated rather than the previously tested one.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression *x;
expression e;
identifier l;
@@

if (x == NULL || ...) {
    ... when forall
    return ...; }
... when != goto l;
    when != x = e
    when != &x
*x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
send
---
 arch/mips/sni/rm200.c               |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index 46f0069..31e2583 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -404,7 +404,7 @@ void __init sni_rm200_i8259_irqs(void)
 	if (!rm200_pic_master)
 		return;
 	rm200_pic_slave = ioremap_nocache(0x160000a0, 4);
-	if (!rm200_pic_master) {
+	if (!rm200_pic_slave) {
 		iounmap(rm200_pic_master);
 		return;
 	}
