Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 22:17:32 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:52713 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493388Ab0HEURZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 22:17:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id CFF6219BF02;
        Thu,  5 Aug 2010 22:17:23 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29930-20; Thu,  5 Aug 2010 22:17:22 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id 9703219BF01;
        Thu,  5 Aug 2010 22:17:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id 3CD5B6DFBB6; Thu,  5 Aug 2010 22:16:13 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id 7CA2D200C3; Thu,  5 Aug 2010 22:17:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id 72E07200BD;
        Thu,  5 Aug 2010 22:17:22 +0200 (CEST)
Date:   Thu, 5 Aug 2010 22:17:22 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/42] arch/mips/kernel: Adjust confusing if indentation
Message-ID: <Pine.LNX.4.64.1008052217010.31692@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Indent the branch of an if.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable braces4@
position p1,p2;
statement S1,S2;
@@

(
if (...) { ... }
|
if (...) S1@p1 S2@p2
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

if (p1[0].column == p2[0].column):
  cocci.print_main("branch",p1)
  cocci.print_secs("after",p2)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/kernel/kspd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/kspd.c b/arch/mips/kernel/kspd.c
index 80e2ba6..29811f0 100644
--- a/arch/mips/kernel/kspd.c
+++ b/arch/mips/kernel/kspd.c
@@ -251,7 +251,7 @@ void sp_work_handle_request(void)
  		memset(&tz, 0, sizeof(tz));
  		if ((ret.retval = sp_syscall(__NR_gettimeofday, (int)&tv,
 					     (int)&tz, 0, 0)) == 0)
-		ret.retval = tv.tv_sec;
+			ret.retval = tv.tv_sec;
 		break;
 
  	case MTSP_SYSCALL_EXIT:
