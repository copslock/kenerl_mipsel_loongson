Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 07:43:06 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:6443 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20025311AbXJLGm6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 07:42:58 +0100
Received: by ug-out-1314.google.com with SMTP id u2so647566uge
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 23:42:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=uizYwwbbqFLffixJLF5wLxQNekbs+mblddZKfu/BQYE=;
        b=p7khsECDhozcmdXmvvipbu4ZkTwjweVM5CX2l5jj423FcB2TwKA+kaxbxR3IH/X0V2Ic+WT+g8ungSyEIsy4LVyY7sC0yU6/4ZnZXOMLoleRy5ilc3EwgRE603apkNyLSnML9m3alofMZVQPRsO+UAeoCiwXgMc8i4SpipzzKFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=THj0opi2kb2Smr4pu0oB+p1vXCo7QZl1p63AvYQzpLcHdGNypImN7W6JZ92h0WgZX0apqq+O5gQIIsRKU2Ivaf0MdyJpXVnNnjglnW07bOxmegKq8edWXSG/m9HzY9nZsUTylyuBiSZ9ZM0kTxakzv6bnsMgY30yxA+YAgAUDBs=
Received: by 10.67.115.2 with SMTP id s2mr2342469ugm.1192171360382;
        Thu, 11 Oct 2007 23:42:40 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id i39sm764605ugd.2007.10.11.23.42.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 23:42:39 -0700 (PDT)
Message-ID: <470F1741.8090707@gmail.com>
Date:	Fri, 12 Oct 2007 08:42:09 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] tlbex.c: cleanup include files
References: <470F16B9.7030406@gmail.com>
In-Reply-To: <470F16B9.7030406@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 01b0961..923515e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -19,20 +19,11 @@
  * (Condolences to Napoleon XIV)
  */
 
-#include <stdarg.h>
-
-#include <linux/mm.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/init.h>
 
-#include <asm/pgtable.h>
-#include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/inst.h>
 #include <asm/elf.h>
-#include <asm/smp.h>
 #include <asm/war.h>
 
 static inline int r45k_bvahwbug(void)
-- 
1.5.3.3
