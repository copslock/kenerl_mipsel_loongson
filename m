Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:51:19 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:34002 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491932AbZGJIvL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:51:11 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8p5uu024090
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:51:05 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:51:04 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8p4ov021812;
	Fri, 10 Jul 2009 01:51:04 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] Fix absd emulation
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:50:58 -0700
Message-ID: <20090710085057.25841.33067.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:51:04.0949 (UTC) FILETIME=[8F211A50:01CA013B]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Robin Randhawa <robin@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/math-emu/dp_simple.c |   11 ++++-------
 arch/mips/math-emu/sp_simple.c |    3 ---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
index 1c555e6..6ff4655 100644
--- a/arch/mips/math-emu/dp_simple.c
+++ b/arch/mips/math-emu/dp_simple.c
@@ -76,15 +76,12 @@ ieee754dp ieee754dp_abs(ieee754dp x)
 	CLEARCX;
 	FLUSHXDP;
 
+	/* Clear sign ALWAYS, irrespective of NaN */
+	DPSIGN(x) = 0;
+
 	if (xc == IEEE754_CLASS_SNAN) {
 		SETCX(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
+		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
 	}
-
-	if (ieee754dp_isnan(x))	/* but not infinity */
-		return ieee754dp_nanxcpt(x, "abs", x);
-
-	/* quick fix up */
-	DPSIGN(x) = 0;
 	return x;
 }
diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
index 770f0f4..cdec1a2 100644
--- a/arch/mips/math-emu/sp_simple.c
+++ b/arch/mips/math-emu/sp_simple.c
@@ -61,9 +61,6 @@ ieee754sp ieee754sp_neg(ieee754sp x)
 		SPSIGN(y) = SPSIGN(x);
 		return ieee754sp_nanxcpt(y, "neg");
 	}
-
-	if (ieee754sp_isnan(x))	/* but not infinity */
-		return ieee754sp_nanxcpt(x, "neg", x);
 	return x;
 }
 
