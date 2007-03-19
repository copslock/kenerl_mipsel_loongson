Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 16:00:28 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.229]:59999 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021913AbXCSQAX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 16:00:23 +0000
Received: by qb-out-0506.google.com with SMTP id e12so4824201qba
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 08:59:22 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=cjfbWzGUJpjUUiSQaA18RQnRfZtufYz8QQKcMUgsrjEHZkWLmqlZwVcCbthqoZmJfWc9tLM0nQ+6Mv+g/Kj8pFm2bMjP+bQ14ahdyCUKIxf+h0DffxqgQAhJ6j9gbGWEu8x9AAjRn7h+OUY9fCV+JOSt+xbqCGNzX/D1fy5uK/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=cu4Z33OQL65AwK2bA2N0iUmgCmPjDQMC6n+Qlm9A3hYYrOPPNnpE5B/Da/IPdLUA44lCRrUsBuuKKKB3tYRJ7eWZVUxE9nCWDs2Z+YOGSbfcttRos/aOlVwVOTW/dKeugtHVdTmshRluMvydo64/cSWwBppCTpLYedKNbItoewk=
Received: by 10.65.253.6 with SMTP id f6mr8014765qbs.1174319962076;
        Mon, 19 Mar 2007 08:59:22 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k24sm14455320nfc.2007.03.19.08.59.20;
        Mon, 19 Mar 2007 08:59:21 -0700 (PDT)
Message-ID: <45FEB353.5020001@innova-card.com>
Date:	Mon, 19 Mar 2007 16:59:15 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	mbizon@freebox.fr, post@pfrst.de,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Always include PHYS_OFFSET in PAGE_OFFSET
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

For platforms that use PHYS_OFFSET and do not use a mapped kernel,
this patch automatically adds PHYS_OFFSET into PAGE_OFFSET.
Therefore for these platforms there are no more needs to change
PAGE_OFFSET.

For mapped kernel, they need to redefine PAGE_OFFSET anyways.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Maxime,

 Could you give a try to this patch ? It removes the need to
 change your PAGE_OFFSET. If I remember correctly it's now
 0x90000000, and you should be able to restore back to
 0x80000000.

		Franck

 include/asm-mips/mach-generic/spaces.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 0ae9997..600561f 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -22,7 +22,7 @@
  * This handles the memory map.
  * We handle pages at KSEG0 for kernels with 32 bit address space.
  */
-#define PAGE_OFFSET		0x80000000UL
+#define PAGE_OFFSET		(0x80000000UL + PHYS_OFFSET)
 
 /*
  * Memory above this physical address will be considered highmem.
@@ -39,9 +39,9 @@
  * This handles the memory map.
  */
 #ifdef CONFIG_DMA_NONCOHERENT
-#define PAGE_OFFSET	0x9800000000000000UL
+#define PAGE_OFFSET	(0x9800000000000000UL + PHYS_OFFSET)
 #else
-#define PAGE_OFFSET	0xa800000000000000UL
+#define PAGE_OFFSET	(0xa800000000000000UL + PHYS_OFFSET)
 #endif
 
 /*
-- 
1.4.4.3.ge6d4
