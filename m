Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 09:03:37 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:53391 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834872AbaEOHDSAYaVI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 May 2014 09:03:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 6CF6822C33
        for <linux-mips@linux-mips.org>; Thu, 15 May 2014 15:03:09 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JJYuP6sFL5Ak; Thu, 15 May 2014 15:02:55 +0800 (CST)
Received: from software.domain.org (unknown [222.92.8.142])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 21F1E22F10;
        Thu, 15 May 2014 15:02:54 +0800 (CST)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenj <chenj@lemote.com>
Subject: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Date:   Thu, 15 May 2014 15:09:03 +0800
Message-Id: <1400137743-8806-2-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1400137743-8806-1-git-send-email-chenj@lemote.com>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

wsbh & movn are available on loongson3 CPU.
---
 arch/mips/lib/csum_partial.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 6cea101..ed88647 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -277,9 +277,12 @@ LEAF(csum_partial)
 #endif
 
 	/* odd buffer alignment? */
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
+	.set	push
+	.set	arch=mips32r2
 	wsbh	v1, sum
 	movn	sum, v1, t7
+	.set	pop
 #else
 	beqz	t7, 1f			/* odd buffer alignment? */
 	 lui	v1, 0x00ff
@@ -726,9 +729,12 @@ LEAF(csum_partial)
 	addu	sum, v1
 #endif
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
+	.set	push
+	.set	arch=mips32r2
 	wsbh	v1, sum
 	movn	sum, v1, odd
+	.set	pop
 #else
 	beqz	odd, 1f			/* odd buffer alignment? */
 	 lui	v1, 0x00ff
-- 
1.9.0
