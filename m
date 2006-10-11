Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 13:11:06 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:23669 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037694AbWJKMI4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 13:08:56 +0100
Received: by nf-out-0910.google.com with SMTP id a25so165412nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 05:08:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=mczQAP/M3bpTricEPwu22Z25mB2cTFzuWekOs3jgtItKizsrVrRkP3zeEt+qrBjxggzeJvPJU/kwBf1uKT7HC0q/arcWiQV7xgHadFWPeq1rFVT6axFFgInB7qjVUOhaLqys7t96cCSj8sx92kAf5slaadxQYUi9Xi7UV/qNPYU=
Received: by 10.49.8.4 with SMTP id l4mr3028176nfi;
        Wed, 11 Oct 2006 05:08:54 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c10sm4269353nfb.2006.10.11.05.08.53;
        Wed, 11 Oct 2006 05:08:53 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 2B55F23F76F; Wed, 11 Oct 2006 14:08:45 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
Date:	Wed, 11 Oct 2006 14:08:41 +0200
Message-Id: <11605685251014-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1160568525897-git-send-email-fbuihuu@gmail.com>
References: <1160568525897-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

During early boot mem init, some configs can't use __pa() to
convert virtual into physical addresses. This patch make __pa()
uses CPHYSADDR() for these configs only, others don't need this
hack. This will allow to not use anymore CPHYSADDR() in generic
code.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 32e5625..b4851ac 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -131,7 +131,11 @@ #endif /* !__ASSEMBLY__ */
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
+#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
+#define __pa(x)			CPHYSADDR(x)
+#else
+#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
+#endif
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
1.4.2.3
