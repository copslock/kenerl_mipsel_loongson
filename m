Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 13:08:56 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:14963 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037661AbWJKMIy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 13:08:54 +0100
Received: by nf-out-0910.google.com with SMTP id a25so165411nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 05:08:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=CVi67oAwsLijqW7eahi69TG9k8F8D7mBK1gCP4BhXcGaKDqLx3NatGGXDIooCm8enff67fAnbSmqRuy3x3G6WeWogDj+G4qu7nHqBcGxeXFqtJwEmAnYxBHjq0idSuK8DQ4zzjXpe8autwjT89SK8qPJxhll6VNxrQU90t6Idv0=
Received: by 10.49.90.4 with SMTP id s4mr3032728nfl;
        Wed, 11 Oct 2006 05:08:54 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p43sm2911294nfa.2006.10.11.05.08.53;
        Wed, 11 Oct 2006 05:08:54 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5F86C23F76E; Wed, 11 Oct 2006 14:08:46 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 4/5] Introduce __pa_symbol()
Date:	Wed, 11 Oct 2006 14:08:44 +0200
Message-Id: <11605685254080-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1160568525897-git-send-email-fbuihuu@gmail.com>
References: <1160568525897-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch introduces __pa_symbol() macro which should be used to
calculate the physical address of kernel symbols. It also relies
on RELOC_HIDE() to avoid any compiler's oddities when doing
arithmetics on symbols.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index b4851ac..2bf101f 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -136,6 +136,7 @@ #define __pa(x)			CPHYSADDR(x)
 #else
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 #endif
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
1.4.2.3
