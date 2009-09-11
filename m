Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 18:21:14 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:57401 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492847AbZIKQVF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Sep 2009 18:21:05 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id D506F19BB8C;
	Fri, 11 Sep 2009 18:21:01 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24481-14; Fri, 11 Sep 2009 18:21:00 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id B883019BB8B;
	Fri, 11 Sep 2009 18:21:00 +0200 (CEST)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EBC596DF84F; Fri, 11 Sep 2009 18:19:13 +0200 (CEST)
Received: by pc-004.diku.dk (Postfix, from userid 3767)
	id A1E69383C5; Fri, 11 Sep 2009 18:21:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id 9BE003830C;
	Fri, 11 Sep 2009 18:21:00 +0200 (CEST)
Date:	Fri, 11 Sep 2009 18:21:00 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
Message-ID: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Error handling code following a kzalloc should free the allocated data.
Error handling code following an ioremap should iounmap the allocated data.

The semantic match that finds the first problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
statement S;
expression E;
identifier f,f1,l;
position p1,p2;
expression *ptr != NULL;
@@

x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...x...+> }
(
x->f1 = E
|
 (x->f1 == NULL || ...)
|
 f(...,x->f1,...)
)
...>
(
 return \(0\|<+...x...+>\|ptr\);
|
 return@p2 ...;
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---
 arch/mips/txx9/generic/setup.c      |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index a205e2b..5744af2 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -781,8 +781,10 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 	if (!iocled)
 		return;
 	iocled->mmioaddr = ioremap(baseaddr, 1);
-	if (!iocled->mmioaddr)
+	if (!iocled->mmioaddr) {
+		kfree(iocled);
 		return;
+	}
 	iocled->chip.get = txx9_iocled_get;
 	iocled->chip.set = txx9_iocled_set;
 	iocled->chip.direction_input = txx9_iocled_dir_in;
@@ -790,8 +792,11 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 	iocled->chip.label = "iocled";
 	iocled->chip.base = basenum;
 	iocled->chip.ngpio = num;
-	if (gpiochip_add(&iocled->chip))
+	if (gpiochip_add(&iocled->chip)) {
+		iounmap(iocled->mmioaddr);
+		kfree(iocled);
 		return;
+	}
 	if (basenum < 0)
 		basenum = iocled->chip.base;
 
