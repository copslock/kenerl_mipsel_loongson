Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2007 21:14:37 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.184]:42665 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025999AbXLAVNh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Dec 2007 21:13:37 +0000
Received: by mu-out-0910.google.com with SMTP id g7so1556351muf
        for <linux-mips@linux-mips.org>; Sat, 01 Dec 2007 13:13:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VoR5l8cqb6l44ze3jC00m6EsJ+7Hr4kjBiio300nvdA=;
        b=t3Y5tu+Mco9zBdrGwSLMhldk5nDZFoznR8numhYl8Ip35dGE8PIWXRg+95FMgxs2npsyQp3JLINi1xMVMt4+XrdCIWWwA9Y8QoFBBSNIvnNFPav+309gs9FjazhJCT0SklR6SFpsJSBeW8DK37shuyYY5ISpGsCY6sLcQEEwDCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dyieupMvVkLEIzG7X/PmfWslcTqjqcfdTZyecPW9OkCMbzlwZtv9GZTWlHq5ZydxWfXNxRGgkEZyJtjQ6Q725SndQ3AFJq7Hjnw+lIMNvJRapKAq4b3G9Q6V+QnMr+rWTvnYvgR1fEh7hUoU2SHZDuveGlARG0oIRtRLg8maPZo=
Received: by 10.86.1.1 with SMTP id 1mr8773799fga.1196543615833;
        Sat, 01 Dec 2007 13:13:35 -0800 (PST)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id l12sm5003187fgb.2007.12.01.13.13.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 13:13:34 -0800 (PST)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-arch@vger.kernel.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: vmlinux.lds.S: handle .{init,exit}.bss sections
Date:	Sat,  1 Dec 2007 22:13:06 +0100
Message-Id: <1196543586-6698-3-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com>
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/vmlinux.lds.S |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 5fc2398..8508d3c 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -110,7 +110,7 @@ SECTIONS
 	_edata =  .;			/* End of data section */
 
 	/* will be freed after init */
-	. = ALIGN(_PAGE_SIZE);		/* Init code and data */
+	. = ALIGN(_PAGE_SIZE);		/* Init code, data and bss */
 	__init_begin = .;
 	.init.text : {
 		_sinittext = .;
@@ -158,12 +158,23 @@ SECTIONS
 	}
 #endif
 	PERCPU(_PAGE_SIZE)
-	. = ALIGN(_PAGE_SIZE);
-	__init_end = .;
-	/* freed after init ends here */
 
+	/*
+	 * We keep init/exit bss sections here to have only one
+	 * segment to load. Note that .bss.exit is also discarded
+	 * at runtime for the same reason as above.
+	 */
+	.exit.bss : {
+		*(.bss.exit)
+	}
 	__bss_start = .;	/* BSS */
-	.sbss  : {
+	.init.bss : {
+		*(.bss.init)
+	}
+	. = ALIGN(_PAGE_SIZE);
+	__init_end = .;		/* freed after init ends here */
+
+	.sbss : {
 		*(.sbss)
 		*(.scommon)
 	}
-- 
1.5.3.5
