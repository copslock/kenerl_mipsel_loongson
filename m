Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2009 08:05:51 +0100 (CET)
Received: from mail-gx0-f212.google.com ([209.85.217.212]:42511 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492130AbZKMHFo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2009 08:05:44 +0100
Received: by gxk4 with SMTP id 4so3834948gxk.8
        for <multiple recipients>; Thu, 12 Nov 2009 23:05:38 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hWaoejo14piY+iDKXTWpNDXA3HKlR9nR8fuo3SIggJs=;
        b=R6WnxyS5PxS5Ld0hW3yQBjFEpC2Ul8eQXoCrr5xaQJ5sX/mvMyxRQQvkNEwFixVlXm
         Tc95JlSfgkW0LPsaZ5qcPBlMBFNkibmY+3Mc+oXELooDb/tLdxY5rnKZrUMfo/ncf5w8
         5uos99EdrgwKqGxKOyeyF9+jJ9EUuoQYF5P1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nWEjhFXs4kk+fZQEn5M76YhPE0C2Hc4SWLZ0l65s6f0RAOzzpjJPzF/hYiQ5H3cEZW
         fuStu1JlMMRthzbSps5PWHjQbv7Rbj63bOPK5a/VkT/YKyzp8nX//V5sAm0emBjL4/bz
         uDKfAp72HTp2O/Rr45EDcMVt5xZyP9ErLK+mI=
Received: by 10.150.112.17 with SMTP id k17mr5836349ybc.257.1258095935597;
        Thu, 12 Nov 2009 23:05:35 -0800 (PST)
Received: from localhost ([220.110.185.192])
        by mx.google.com with ESMTPS id 4sm257349ywi.42.2009.11.12.23.05.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 23:05:34 -0800 (PST)
From:	Akinobu Mita <akinobu.mita@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Akinobu Mita <akinobu.mita@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mips: Use hweight8
Date:	Fri, 13 Nov 2009 16:04:53 +0900
Message-Id: <1258095893-13338-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 1.6.5.1
Return-Path: <akinobu.mita@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akinobu.mita@gmail.com
Precedence: bulk
X-list: linux-mips

Use hweight8 instead of counting for each bit

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/cerr-sb1.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
index 1bd1f18..3571090 100644
--- a/arch/mips/mm/cerr-sb1.c
+++ b/arch/mips/mm/cerr-sb1.c
@@ -567,13 +567,10 @@ static uint32_t extract_dc(unsigned short addr, int data)
 				datalo = ((unsigned long long)datalohi << 32) | datalolo;
 				ecc = dc_ecc(datalo);
 				if (ecc != datahi) {
-					int bits = 0;
+					int bits;
 					bad_ecc |= 1 << (3-offset);
 					ecc ^= datahi;
-					while (ecc) {
-						if (ecc & 1) bits++;
-						ecc >>= 1;
-					}
+					bits = hweight8(ecc);
 					res |= (bits == 1) ? CP0_CERRD_DATA_SBE : CP0_CERRD_DATA_DBE;
 				}
 				printk("  %02X-%016llX", datahi, datalo);
-- 
1.6.5.1
