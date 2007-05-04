Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2007 16:36:23 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:43674 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022135AbXEDPgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 May 2007 16:36:22 +0100
Received: by ug-out-1314.google.com with SMTP id 40so585614uga
        for <linux-mips@linux-mips.org>; Fri, 04 May 2007 08:35:16 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=c+OqXXqjikgZbmhYCXb5vFf6/QV1ldL0zAXokz+7A9YcU1zA9uujCeskm2YzTXoZXgBfls22B9udk+eOGS17ihWbI1vgv48lNC2VmrqDRz5gIacV6Z1aqi3tECda3qnfFNfK/BYIE/ug7uEyUHzLhlD+6V73jTk/u89ArGBBzYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=kI9p8vj36AjKwUJ0Ax7ywHXrgADxazPPgKl3YPdmaNYvClQxn/BwL8ntHiHlA8571NpB1PCmtySz2GgwWnl4D5TVGJ9b2TLXxFaEtQRGoOcspzDmhTfIvUzTHu/TsF40exwh5ADoqaMkgV0crZwpGl0biIqg8nWPjraevJz9kX8=
Received: by 10.82.145.7 with SMTP id s7mr6745753bud.1178292916323;
        Fri, 04 May 2007 08:35:16 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y37sm149313iky.2007.05.04.08.35.13;
        Fri, 04 May 2007 08:35:15 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6D82323F76E; Fri,  4 May 2007 17:36:46 +0200 (CEST)
To:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 1/3] clocksource: use CLOCKSOURCE_MASK() macro
Date:	Fri,  4 May 2007 17:36:44 +0200
Message-Id: <1178293006633-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index e5e56bd..751b4a1 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -306,7 +306,7 @@ static unsigned int __init calibrate_hpt(void)
 
 struct clocksource clocksource_mips = {
 	.name		= "MIPS",
-	.mask		= 0xffffffff,
+	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-- 
1.5.1.3
