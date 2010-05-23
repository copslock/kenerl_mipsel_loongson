Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:53:47 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:49186 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491948Ab0EWTwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:22 +0200
Received: by fg-out-1718.google.com with SMTP id 16so812537fgg.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0rOL7s4EiuEqh5EHjQ6JoJY7VCuvn3pW78EJTVnh8FI=;
        b=VnCzggam2bIYyLf4sZChjTflBWOxp0pbyBxaVAqrZbNPTJ0BNGnHWqE8ia0GnjsUs8
         TDBWQ9awLLYMBklJs3zWvU/muYp6GuNP2W15xrdTMio0RQcsc1OG67mpedsDdj80lBrD
         gH13CPrEFSQWbm1mdtS2J712f0RcsXtCLDioI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=VgEnRRSohan9fqFMrGbgehWclrRc4PX6DEcu5zWq93WStYRbd8p05zrEAahL3cA3ny
         AN6K8BWQwS8gv/zs4DUsDMB5AJrs6OCdvoybK/+H/CNd1qDJphUl3VB0s1VUA3opRT7z
         l7CRVznSMxnqngvMOkECiLmK9z4n6/jqhQt7s=
Received: by 10.87.74.17 with SMTP id b17mr7165402fgl.59.1274644342278;
        Sun, 23 May 2010 12:52:22 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:21 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 165/199] arch/mips/math-emu/dp_tint.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:06 +0200
Message-Id: <1274644332-23964-5-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/dp_tint.c:73: ERROR: else should follow close brace '}'

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/dp_tint.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_tint.c b/arch/mips/math-emu/dp_tint.c
index 77b2b7c..2447862 100644
--- a/arch/mips/math-emu/dp_tint.c
+++ b/arch/mips/math-emu/dp_tint.c
@@ -69,8 +69,7 @@ int ieee754dp_tint(ieee754dp x)
 			round = 0;
 			sticky = residue != 0;
 			xm = 0;
-		}
-		else {
+		} else {
 			residue = xm << (64 - DP_MBITS + xe);
 			round = (residue >> 63) != 0;
 			sticky = (residue << 1) != 0;
-- 
1.7.1.251.gf80a2
