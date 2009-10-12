Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 23:58:00 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:50554 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493527AbZJLV52 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 23:57:28 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n9CLvI8J029175
	for <linux-mips@linux-mips.org>; Mon, 12 Oct 2009 14:57:18 -0700
Received: from linux-chris2 ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Oct 2009 14:57:18 -0700
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by linux-chris2 with esmtp (Exim 4.69)
	(envelope-from <chris@mips.com>)
	id 1MxStK-0007ul-Hf; Mon, 12 Oct 2009 14:57:18 -0700
From:	Chris Dearman <chris@mips.com>
Subject: [PATCH] Fix abs.[sd] and neg.[sd] emulation for NaN operands
To:	linux-mips@linux-mips.org
Date:	Mon, 12 Oct 2009 14:57:18 -0700
Message-ID: <20091012215718.30362.67068.stgit@localhost.localdomain>
In-Reply-To: <20091012215522.30362.49399.stgit@localhost.localdomain>
References: <20091012215522.30362.49399.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2009 21:57:18.0413 (UTC) FILETIME=[F788F7D0:01CA4B86]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

From: Nigel Stephens <nigel@mips.com>

This patch ensures that the sign bit is always updated
for NaN operands.

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/math-emu/dp_simple.c |   13 ++++---------
 arch/mips/math-emu/sp_simple.c |   11 +++--------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
index 1c555e6..d9ae1db 100644
--- a/arch/mips/math-emu/dp_simple.c
+++ b/arch/mips/math-emu/dp_simple.c
@@ -62,8 +62,6 @@ ieee754dp ieee754dp_neg(ieee754dp x)
 		return ieee754dp_nanxcpt(y, "neg");
 	}
 
-	if (ieee754dp_isnan(x))	/* but not infinity */
-		return ieee754dp_nanxcpt(x, "neg", x);
 	return x;
 }
 
@@ -76,15 +74,12 @@ ieee754dp ieee754dp_abs(ieee754dp x)
 	CLEARCX;
 	FLUSHXDP;
 
+	/* Clear sign ALWAYS, irrespective of NaN */
+	DPSIGN(x) = 0;
+
 	if (xc == IEEE754_CLASS_SNAN) {
-		SETCX(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
+		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
 	}
 
-	if (ieee754dp_isnan(x))	/* but not infinity */
-		return ieee754dp_nanxcpt(x, "abs", x);
-
-	/* quick fix up */
-	DPSIGN(x) = 0;
 	return x;
 }
diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
index 770f0f4..3175477 100644
--- a/arch/mips/math-emu/sp_simple.c
+++ b/arch/mips/math-emu/sp_simple.c
@@ -62,8 +62,6 @@ ieee754sp ieee754sp_neg(ieee754sp x)
 		return ieee754sp_nanxcpt(y, "neg");
 	}
 
-	if (ieee754sp_isnan(x))	/* but not infinity */
-		return ieee754sp_nanxcpt(x, "neg", x);
 	return x;
 }
 
@@ -76,15 +74,12 @@ ieee754sp ieee754sp_abs(ieee754sp x)
 	CLEARCX;
 	FLUSHXSP;
 
+	/* Clear sign ALWAYS, irrespective of NaN */
+	SPSIGN(x) = 0;
+
 	if (xc == IEEE754_CLASS_SNAN) {
-		SETCX(IEEE754_INVALID_OPERATION);
 		return ieee754sp_nanxcpt(ieee754sp_indef(), "abs");
 	}
 
-	if (ieee754sp_isnan(x))	/* but not infinity */
-		return ieee754sp_nanxcpt(x, "abs", x);
-
-	/* quick fix up */
-	SPSIGN(x) = 0;
 	return x;
 }
