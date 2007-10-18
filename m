Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 22:14:57 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.229]:264 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20043415AbXJRVOB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 22:14:01 +0100
Received: by hu-out-0506.google.com with SMTP id 31so415547huc
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 14:14:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8NtUPCwZHlM/NcI42ztGXlM2Ql6cWK9C+3iUGXkKtaw=;
        b=lIC17PqXiDPBtOHhbsPD2y3MVFwRHiGnJQ/bdpCMAs85P0ONWBcTRIXwPdYgGXJZUtzL82EUuDVU/iDCCBdGTyKSlxFPEwNrhu1ruIvOtXucYPF1nEWIEaVgewXLrcOp2Khrd8dFN9sQqPAfjtxH3UwqCtntBzeZf2BLk3PQuRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wltjf0P5ycyouOziTfu3JFbxZLS/RMrA+BxiWG7/yHnlyNljgKyI1ncT5NpPHWV1q71wXk0UC/zepYwzXBea7OWD83NBLl4Z4Y3Be4xklE4A6aLkL5YLK9d/LR9QZe68rRc/faXQAZz4CLM2j6LXiGDNqQnpxLdpBxEMb6F7x0w=
Received: by 10.86.97.7 with SMTP id u7mr765771fgb.1192742040848;
        Thu, 18 Oct 2007 14:14:00 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id g8sm2978529muf.2007.10.18.14.13.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 14:14:00 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: [PATCH 3/4] vmlinux.ld.S: correctly indent .data section
Date:	Thu, 18 Oct 2007 23:12:32 +0200
Message-Id: <1192741953-7040-4-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
References: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/vmlinux.lds.S |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index e0a4dc0..2f6c225 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -55,21 +55,23 @@ SECTIONS
 
 	/* writeable */
 	.data : {	/* Data */
-	  . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
-	  /*
-	   * This ALIGN is needed as a workaround for a bug a gcc bug upto 4.1 which
-	   * limits the maximum alignment to at most 32kB and results in the following
-	   * warning:
-	   *
-	   *  CC      arch/mips/kernel/init_task.o
-	   * arch/mips/kernel/init_task.c:30: warning: alignment of ‘init_thread_union’
-	   * is greater than maximum object file alignment.  Using 32768
-	   */
-	  . = ALIGN(_PAGE_SIZE);
-	  *(.data.init_task)
-
-	  DATA_DATA
-	  CONSTRUCTORS
+		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
+		/*
+		 * This ALIGN is needed as a workaround for a bug a
+		 * gcc bug upto 4.1 which limits the maximum alignment
+		 * to at most 32kB and results in the following
+		 * warning:
+		 *
+		 *  CC      arch/mips/kernel/init_task.o
+		 * arch/mips/kernel/init_task.c:30: warning: alignment
+		 * of ‘init_thread_union’ is greater than maximum
+		 * object file alignment.  Using 32768
+		 */
+		. = ALIGN(_PAGE_SIZE);
+		*(.data.init_task)
+		
+		DATA_DATA
+		CONSTRUCTORS
 	}
 	_gp = . + 0x8000;
 	.lit8 : {
-- 
1.5.3.4
