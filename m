Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:52:03 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:19358 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S20023918AbZCaQvf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 17:51:35 +0100
Received: by bwz25 with SMTP id 25so2625188bwz.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:51:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9gPIVBSagBNR2zBGbW6P9HLO/ad2aF8yUZtsjkg8LFo=;
        b=pjOGGi+Lg/xu9ddWeUxKkIgVd6T3I1f4NTXPId4HGbvsKF+ynKiWNgh7RYFSKy0Owz
         QWW740/lKt8Ml5UuSHzGCp5tFP9A+5mZHo9OY4viIXg6JMLFgL9oN6LiBxVMCkptFP83
         7PD8TEHzpGLPpaoxlCtvAi0EbMMrpKgCeRLMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=pmMDTzIxNFKkjsasWNx6I/lqeiWfd+Qpi51XH8ngF67rPRRiLhKYbiVdHO+VYqAq6Q
         3+ciqpTL73NGdBi63IjY9Dh8ofrPB1qSTUwd47MGRYMA649Z7JhstnzB3xadQCONClak
         pBhAIsSKdj6YdsBw3FFKq0hNNAdBX/iWKgsdc=
Received: by 10.103.192.2 with SMTP id u2mr2361062mup.2.1238518287939;
        Tue, 31 Mar 2009 09:51:27 -0700 (PDT)
Received: from localhost.localdomain (p5496E20F.dip.t-dialin.net [84.150.226.15])
        by mx.google.com with ESMTPS id j6sm2195257mue.4.2009.03.31.09.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:51:26 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/2] Alchemy: add missing Au1200 GPIO203 interrupt
Date:	Tue, 31 Mar 2009 18:51:28 +0200
Message-Id: <1238518288-5162-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238518288-5162-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1238518288-5162-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

---
 arch/mips/include/asm/mach-au1x00/au1000.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 87a1659..854e95f 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -902,8 +902,8 @@ enum soc_au1200_ints {
 	AU1000_RTC_MATCH0_INT,
 	AU1000_RTC_MATCH1_INT,
 	AU1000_RTC_MATCH2_INT,
-
-	AU1200_NAND_INT		= AU1200_FIRST_INT + 23,
+	AU1200_GPIO_203,
+	AU1200_NAND_INT,
 	AU1200_GPIO_204,
 	AU1200_GPIO_205,
 	AU1200_GPIO_206,
-- 
1.6.2
