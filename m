Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 03:30:54 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:43156 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492143Ab0ELBar (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 May 2010 03:30:47 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id o4C1UYvH030096
        for <linux-mips@linux-mips.org>; Tue, 11 May 2010 18:30:39 -0700
Received: from linux-chris2 ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 11 May 2010 18:29:50 -0700
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by linux-chris2 with esmtp (Exim 4.69)
        (envelope-from <chris@mips.com>)
        id 1OC0mQ-0001hC-8R; Tue, 11 May 2010 18:30:34 -0700
From:   Chris Dearman <chris@mips.com>
Subject: [PATCH] Restore signalling NaN behaviour for abs.[sd]
To:     linux-mips@linux-mips.org
Date:   Tue, 11 May 2010 18:30:34 -0700
Message-ID: <20100512013034.6493.20675.stgit@localhost.localdomain>
In-Reply-To: <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
References: <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2010 01:29:51.0016 (UTC) FILETIME=[9DD70280:01CAF172]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto <anemo@mba.ocn.ne.jp> spotted that this had been
incorrectly removed in a previous patch

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/math-emu/dp_simple.c |    1 +
 arch/mips/math-emu/sp_simple.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
index d9ae1db..b909742 100644
--- a/arch/mips/math-emu/dp_simple.c
+++ b/arch/mips/math-emu/dp_simple.c
@@ -78,6 +78,7 @@ ieee754dp ieee754dp_abs(ieee754dp x)
 	DPSIGN(x) = 0;
 
 	if (xc == IEEE754_CLASS_SNAN) {
+		SETCX(IEEE754_INVALID_OPERATION);
 		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
 	}
 
diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
index 3175477..2fd53c9 100644
--- a/arch/mips/math-emu/sp_simple.c
+++ b/arch/mips/math-emu/sp_simple.c
@@ -78,6 +78,7 @@ ieee754sp ieee754sp_abs(ieee754sp x)
 	SPSIGN(x) = 0;
 
 	if (xc == IEEE754_CLASS_SNAN) {
+		SETCX(IEEE754_INVALID_OPERATION);
 		return ieee754sp_nanxcpt(ieee754sp_indef(), "abs");
 	}
 
