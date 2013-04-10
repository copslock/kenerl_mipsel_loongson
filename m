Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 00:47:22 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47453 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835068Ab3DJWrPGKckz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 00:47:15 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08331840;
        Wed, 10 Apr 2013 22:47:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 06/64] MIPS: Fix logic errors in bitops.c
Date:   Wed, 10 Apr 2013 15:46:03 -0700
Message-Id: <20130410224334.584076940@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <20130410224333.114387235@linuxfoundation.org>
References: <20130410224333.114387235@linuxfoundation.org>
User-Agent: quilt/0.60-5.1.1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit 0c81157b46c533139d6be721d41617020c59a2c3 upstream.

commit 92d11594f6 (MIPS: Remove irqflags.h dependency from bitops.h)
factored some of the bitops code out into a separate file
(arch/mips/lib/bitops.c).  Unfortunately the logic converting a bit
mask into a boolean result was lost in some of the functions.  We had:

   int res;
   unsigned long shifted_result_bit;
   .
   .
   .
   res = shifted_result_bit;
   return res;

Which truncates off the high 32 bits (thus yielding an incorrect
value) on 64-bit systems.

The manifestation of this is that a non-SMP 64-bit kernel will not
boot as the bitmap operations in bootmem.c are all screwed up.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc:  linux-mips@linux-mips.org
Cc: Jim Quinlan <jim2101024@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/4965/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/bitops.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/mips/lib/bitops.c
+++ b/arch/mips/lib/bitops.c
@@ -90,12 +90,12 @@ int __mips_test_and_set_bit(unsigned lon
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a |= mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -116,12 +116,12 @@ int __mips_test_and_set_bit_lock(unsigne
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a |= mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -141,12 +141,12 @@ int __mips_test_and_clear_bit(unsigned l
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a &= ~mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -166,12 +166,12 @@ int __mips_test_and_change_bit(unsigned
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a ^= mask;
 	raw_local_irq_restore(flags);
 	return res;
