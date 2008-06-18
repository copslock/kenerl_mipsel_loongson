Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:18:24 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:9142 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025228AbYFRHRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:14 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 1FECAC80D7;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id zLQAnzJA2YX0; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 03AE7C801D;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A61FFB4043; Wed, 18 Jun 2008 10:18:23 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 4/5] [MIPS] Make gcmp_probe() static
Date:	Wed, 18 Jun 2008 10:18:22 +0300
Message-Id: <1213773503-23536-5-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The gcmp_probe() function is needlessly defined global, and
this patch makes it static.

Tested by booting a Malta 4Kc board up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/mips-boards/malta/malta_int.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index b393982..ea17611 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -400,7 +400,7 @@ static struct gic_intr_map gic_intr_map[] = {
 /*
  * GCMP needs to be detected before any SMP initialisation
  */
-int __init gcmp_probe(unsigned long addr, unsigned long size)
+static int __init gcmp_probe(unsigned long addr, unsigned long size)
 {
 	if (gcmp_present >= 0)
 		return gcmp_present;
-- 
1.5.5.GIT
