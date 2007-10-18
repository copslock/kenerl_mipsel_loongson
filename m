Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 22:14:28 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.231]:63751 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20043395AbXJRVN6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 22:13:58 +0100
Received: by hu-out-0506.google.com with SMTP id 31so415546huc
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 14:13:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=j6CZUNFUlYxeJ8VeNMAU+w2QvTdScPurkP9IFGBBBa8=;
        b=Y3Z4QrFkEXjaCgYKcb7JV9X04Z1aeDrez1eIwP1uPiC58IJYanQjtCuv3TywJq8X79YPMXc3HuH+p8d2Xxn5e8iYgxuj6HstgwjHoSdPx1oDZO/kqG4oJKAbld1LeY6jlmuONUS2kF/baYvpUxjXMYxlVz6XyBDyq9wUipmpdxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uHWI0yYKGrtHflvS+uxgkASCWQYplwmOsYgReSTMvDSS66H8HtAOAtHbiLvbhzTsjGneibb9np0V/XjwvJ4qHDHuwx8tzMWQlwAvpuWKb+Dhlu7rZp5p4o36xZzOnJ94MzB7KyexLw9ltlD/GyqT7vxqkwVR9+8z7mdTtYifuIA=
Received: by 10.86.4.2 with SMTP id 2mr736961fgd.1192742037287;
        Thu, 18 Oct 2007 14:13:57 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id d13sm2439875fka.2007.10.18.14.13.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 14:13:56 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: [PATCH 2/4] Add .init.bss section for MIPS
Date:	Thu, 18 Oct 2007 23:12:31 +0200
Message-Id: <1192741953-7040-3-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
References: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/vmlinux.lds.S |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 84f9a4c..e0a4dc0 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -100,7 +100,7 @@ SECTIONS
 	_edata =  .;			/* End of data section */
 
 	/* will be freed after init */
-	. = ALIGN(_PAGE_SIZE);		/* Init code and data */
+	. = ALIGN(_PAGE_SIZE);		/* Init code, data and bss */
 	__init_begin = .;
 	.init.text : {
 		_sinittext = .;
@@ -148,19 +148,27 @@ SECTIONS
 	}
 #endif
 	PERCPU(_PAGE_SIZE)
-	. = ALIGN(_PAGE_SIZE);
-	__init_end = .;
-	/* freed after init ends here */
 
-	__bss_start = .;	/* BSS */
-	.sbss  : {
-		*(.sbss)
-		*(.scommon)
+	/*
+	 * Note that .bss.exit is also discarded at runtime for the
+	 * same reason as above.
+	 */
+	.bss.exit : {
+		*(.bss.exit)
 	}
+	__bss_start = .;	/* BSS */
 	.bss : {
+		*(.bss.init)
+		. = ALIGN(_PAGE_SIZE);
+		__init_end = .;		/* freed after init ends here */
+
 		*(.bss)
 		*(COMMON)
 	}
+	.sbss : {
+		*(.sbss)
+		*(.scommon)
+	}
 	__bss_stop = .;
 
 	_end = . ;
-- 
1.5.3.4
