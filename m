Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 11:21:12 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:32382 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021712AbXC0KUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 11:20:48 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2049670uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=j1Mp++a3ycJqQaEeQJwYh/2Q1+ksKveP/qshsw226+rTzU5NPdq+EN1xFc7FJi/cEm0xS1z14V27+subx8Q5kJX9Jl+gYIACKTJtNsg56Y46qVP5MzsM6d8Qqher6o6qXqmeuutB9DdDglilBLwZetChw8uvK95vk6paz0z99yY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=C6B7yvZ3YHoc1bnS9AFpgKlkr0stLD8sh0X8+rAIAp6Uf1vJzqEbQMnxhspf1wMSFGeloTqMNaxG1JkajcJqiMHo+CTQDfOMPorLZg6BfrvP+u2OAlVJ2xghlLnjFMvxNmqr1ZThHa4cMW3IcFbiv7Z1U4LgY7VUlU5tAx7S4aI=
Received: by 10.67.97.7 with SMTP id z7mr710915ugl.1174990787282;
        Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id 30sm1538611ugf.2007.03.27.03.19.45;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 54A4923F770; Tue, 27 Mar 2007 11:19:41 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/4] Make PAGE_OFFSET aware of PHYS_OFFSET
Date:	Tue, 27 Mar 2007 11:19:38 +0200
Message-Id: <11749871811667-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <11749871802730-git-send-email-fbuihuu@gmail.com>
References: <11749871802730-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

For platforms that use PHYS_OFFSET and do not use a mapped kernel,
this patch automatically adds PHYS_OFFSET into PAGE_OFFSET.
Therefore there are no more needs for them to redefine PAGE_OFFSET.

For mapped kernel, they need to redefine PAGE_OFFSET anyways.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 9a3c521..512bca5 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -26,7 +26,7 @@
  * We handle pages at KSEG0 for kernels with 32 bit address space.
  */
 #ifndef PAGE_OFFSET
-#define PAGE_OFFSET		0x80000000UL
+#define PAGE_OFFSET		(0x80000000UL + PHYS_OFFSET)
 #endif
 
 /*
@@ -45,9 +45,9 @@
  */
 #ifndef PAGE_OFFSET
 #ifdef CONFIG_DMA_NONCOHERENT
-#define PAGE_OFFSET	0x9800000000000000UL
+#define PAGE_OFFSET		(0x9800000000000000UL + PHYS_OFFSET)
 #else
-#define PAGE_OFFSET	0xa800000000000000UL
+#define PAGE_OFFSET		(0xa800000000000000UL + PHYS_OFFSET)
 #endif
 #endif
 
-- 
1.5.1.rc1.27.g1d848
