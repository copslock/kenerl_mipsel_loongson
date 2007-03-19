Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:52:34 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.239]:60645 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021925AbXCSPw3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 15:52:29 +0000
Received: by hu-out-0506.google.com with SMTP id 22so6019734hug
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 08:51:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=lVTZoqdq3Xx73urGBUMqOZlj/ta0dIL1EF/AticoFCkJdiVP8C8ifObXX69r1YcBFG4+2Fy9ixq9261VxVibSSy6hfS20K1620IxjpQuU2CvQe1YQg+3FiEOOJ0vV6XGCArrJ6NKzseAp3DZ4B51sDtkU9hrl40o9k6mM5m1COc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=PszqflCUtO6xqWyH6g2HiBE7hNb3JStpN3DlxGB8zb6xR0gMdantyxTSw/HyawLhs+Fh2UchMv1AS5BYgSlwSvapppGqiSvQtCZKTkg6m6hG5yZavQ24KrL1Nq3em33qJnlJc40Vo+ME3CgZseHpKnY93BVXpOu9bMr37wy8MTI=
Received: by 10.82.167.5 with SMTP id p5mr10240038bue.1174319488822;
        Mon, 19 Mar 2007 08:51:28 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id y34sm12786874iky.2007.03.19.08.51.27;
        Mon, 19 Mar 2007 08:51:28 -0700 (PDT)
Message-ID: <45FEB179.4070904@innova-card.com>
Date:	Mon, 19 Mar 2007 16:51:21 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	post@pfrst.de, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] __pa_page_offset(): fix physical offset for kernel linked
 in CKSEG0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: peter fuerst <post@pfrst.de>

This patch fixes commit 6f284a2ce7b8bc49cb8455b1763357897a899abb
for 64 bits kernel linked in CKSEG0.

Signed-off-by: peter fuerst <post@pfrst.de>
Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..76cb88c 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -150,7 +150,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  * __pa()/__va() should be used only during mem init.
  */
 #if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
-#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
+#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0 + PHYS_OFFSET)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
 #endif
-- 
1.4.4.3.ge6d4
