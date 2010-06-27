Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2010 15:52:17 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491898Ab0F0NwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jun 2010 15:52:09 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD6B0B097F;
        Sun, 27 Jun 2010 09:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; s=sasl; bh=oZgv6YAERmHRchoaE9nB0NuuS
        Nk=; b=WR5QX9Wt+xbuwtbd/e0qTWFs+AyB78MvpRQmp8oyWihadvxNxh4u0TQFX
        Y2lQdOPt/2rw5hd2KWwhJjh4cE1AUyn3BA9gnfWH2bhGwyCuimnYBSO1a6MMaUgY
        KE6PQZ546T5uworBEdCdwB8xT2DyIFSP61+EcaSf4Loo8hpAZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=A5B3Nc/cdANt5G7p1HF
        XvQdDgP4gx0ZKavU5xLJGouG5NPD88U4KaDY0NLacLQzb0yBAfNqlXcNpV63p0fq
        VFHMGwufAC41blREEfR2chyw7S5HI0JkhQ0VximRgujdrm6NTaeHohxzq/1exOT6
        7D/ptObnNuz7HkASGHkgaRFU=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1EAB097D;
        Sun, 27 Jun 2010 09:52:04 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2ACEB0978; Sun, 27 Jun
 2010 09:52:02 -0400 (EDT)
Message-ID: <4C275781.8000904@pobox.com>
Date:   Sun, 27 Jun 2010 22:52:01 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9)
 Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: irq.c: Misc cleanups
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 2B3B3DD8-81F3-11DF-AAE0-2AC9016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
X-archive-position: 27258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18170

* Remove unnecessary 'if (int_status & (1 <<10))' statement
* s/if (foo != 0)/if (foo)/
* Remove unused 'inst_status &= ~(1 << i);' line

Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
---
 Noticed while I'm reworking on interrupt code for EMMA2RH.
 This is not for inclusion, but just for letting Wu-san know.

 arch/mips/loongson/common/irq.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index 20e7328..25a11df 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -21,19 +21,16 @@ void bonito_irqdispatch(void)
 
 	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
 	int_status = LOONGSON_INTISR;
-	if (int_status & (1 << 10)) {
-		while (int_status & (1 << 10)) {
-			udelay(1);
-			int_status = LOONGSON_INTISR;
-		}
+	while (int_status & (1 << 10)) {
+		udelay(1);
+		int_status = LOONGSON_INTISR;
 	}
 
 	/* Get pending sources, masked by current enables */
 	int_status = LOONGSON_INTISR & LOONGSON_INTEN;
 
-	if (int_status != 0) {
+	if (int_status) {
 		i = __ffs(int_status);
-		int_status &= ~(1 << i);
 		do_IRQ(LOONGSON_IRQ_BASE + i);
 	}
 }
-- 
1.7.1
