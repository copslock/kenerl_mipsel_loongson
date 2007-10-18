Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 22:15:26 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.229]:264 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20043409AbXJRVOE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 22:14:04 +0100
Received: by hu-out-0506.google.com with SMTP id 31so415547huc
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 14:14:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nGN0aW98KUhFa04vMpcgKVqN+YvQN1DKCd/sxGnKUzk=;
        b=C4K/JRzGF4eYToI5TGnB83rVngXKMTbfuEcGdZpRzCoa/RvVBQMuxiD/CXr5c/VNqMEnRd3pEgROki1T7qxSl0e/UEgDH51iCcIR2DWCzWJ21Xv/dLmvrg3h2Mcn2dQ9id/XxRvGrzGV5SaTKmOejEZuVim8tep//cjRQcCOhsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HEMGSCJJUYngEuyKUWFDyvuwbIK18hQSV0hXEVwXISXI6HZE8MVpT4g0xl8FiYWS4N2LJWX+4Uu3pIebJ4qrBrUs5qo1+1j4GuN4x2jX4l3nDBjwRcpSu1HQpmaiOWiwJTWY+dyPr4h1TyGIdCeSokidDVa4p9NUeiiAzf4Y7vc=
Received: by 10.86.77.5 with SMTP id z5mr753043fga.1192742044590;
        Thu, 18 Oct 2007 14:14:04 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id e8sm2994942muf.2007.10.18.14.14.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 14:14:03 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: [PATCH 4/4] Use __bzero to clear .bss
Date:	Thu, 18 Oct 2007 23:12:33 +0200
Message-Id: <1192741953-7040-5-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
References: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/head.S |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index e46782b..330eec1 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -175,13 +175,10 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	mtc0	t0, CP0_STATUS
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	PTR_LA		t0, __bss_start		# clear .bss
-	LONG_S		zero, (t0)
-	PTR_LA		t1, __bss_stop - LONGSIZE
-1:
-	PTR_ADDIU	t0, LONGSIZE
-	LONG_S		zero, (t0)
-	bne		t0, t1, 1b
+	PTR_LA		a0, __bss_start		# clear .bss
+	PTR_LA		a1, __bss_stop
+	PTR_SUBU	a1, a0
+	jal		__bzero
 
 	LONG_S		a0, fw_arg0		# firmware arguments
 	LONG_S		a1, fw_arg1
-- 
1.5.3.4
