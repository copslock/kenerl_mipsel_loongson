Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:18:16 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:50309 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S22850108AbYJaRyT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 17:54:19 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id E692BC800F;
	Fri, 31 Oct 2008 19:54:11 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id xvtwddtesi+t; Fri, 31 Oct 2008 19:54:11 +0200 (EET)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id C42F8C8001;
	Fri, 31 Oct 2008 19:54:11 +0200 (EET)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 997E8110031; Fri, 31 Oct 2008 19:54:11 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH] IP22: make indy_sc_ops variable static
Date:	Fri, 31 Oct 2008 19:54:11 +0200
Message-Id: <1225475651-8502-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The indy_sc_ops variable in arch/mips/mm/sc-ip22.c is needlessly
defined global, and this patch makes it static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/mm/sc-ip22.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/sc-ip22.c b/arch/mips/mm/sc-ip22.c
index 1f602a1..13adb57 100644
--- a/arch/mips/mm/sc-ip22.c
+++ b/arch/mips/mm/sc-ip22.c
@@ -161,7 +161,7 @@ static inline int __init indy_sc_probe(void)
 
 /* XXX Check with wje if the Indy caches can differenciate between
    writeback + invalidate and just invalidate.  */
-struct bcache_ops indy_sc_ops = {
+static struct bcache_ops indy_sc_ops = {
 	.bc_enable = indy_sc_enable,
 	.bc_disable = indy_sc_disable,
 	.bc_wback_inv = indy_sc_wback_invalidate,
-- 
1.5.4.3
