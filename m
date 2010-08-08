Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Aug 2010 21:58:12 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:58649 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491855Ab0HHT6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Aug 2010 21:58:09 +0200
Received: by pxi13 with SMTP id 13so3974339pxi.36
        for <multiple recipients>; Sun, 08 Aug 2010 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5xuStoK5steW+0AhGPQfh17VvJVIIF6bWJ2Ule4q4LA=;
        b=RWFAS18P76CmhyyJaihIlt+V6e3d/kHu4WSmkn1cn7f0Qqoy/QmcqOAkuR/6fW/0SL
         eq2km4M1Db8Q7uczjr7k3fuVphZ+A2GEt2kP2IliN6bExgUJl7D4Yl6kWsLrh+S6dvap
         x+eolbK1V/+jWDmrhK2qjrThp9qI8j082xbt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QSsXA1DBtF9BdVsgX3Rn8ZlNzdAdscwe6PYoICFUghlD8JBEhNLxgQFciatTyldVCc
         caBo/aqT5tvw4VxRvjgs4ndPI44qZ0V4Q6jViM2Ku7VL9JQSbjc5QiUjMvxVlW0G1Djb
         4epTBEL6sH7b21ybWJxnO8mgxbCtfWUcP+RWQ=
Received: by 10.142.141.8 with SMTP id o8mr12980329wfd.53.1281297482567;
        Sun, 08 Aug 2010 12:58:02 -0700 (PDT)
Received: from localhost.localdomain ([211.178.117.190])
        by mx.google.com with ESMTPS id w8sm5494853wfd.19.2010.08.08.12.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 12:58:02 -0700 (PDT)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: remove RELOC_HIDE on __pa_symbol
Date:   Mon,  9 Aug 2010 04:57:36 +0900
Message-Id: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

remove unneccessary use of RELOC_HIDE(). It does simple addition of ptr and
offset and in this case (offset 0) does practically nothing. It does NOT do
anything with linker relocation.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/mips/include/asm/page.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index a16beaf..f7e2684 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -150,7 +150,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
     ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
 #endif
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
-#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_symbol(x)	__pa(x)
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-- 
1.7.0.4
