Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 11:37:39 +0100 (BST)
Received: from smtp.gentoo.org ([140.211.166.183]:31695 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S20021826AbYHEKhb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 11:37:31 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2204)
	id 7369A67343; Tue,  5 Aug 2008 10:37:28 +0000 (UTC)
Date:	Tue, 5 Aug 2008 10:37:28 +0000
From:	Ricardo Mendoza <ricmm@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp, ricmm@gentoo.org
Subject: [PATCH] cevt-r4k.c irq ack optimization
Message-ID: <20080805103728.GA4628@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

Hello Ralf,

Whereas current implementation works, the modification below can protect
us from problems such as the pipeline hazards in vr41xx cpus without any
added extra code length. Also, I beleive Yoichi posted something similar
a few months ago.

Please apply.


     Ricardo

---

Ack the IRQ by writing to c0_compare it's own value rather than the
c0_count value. This prevents issues caused by pipeline hazards, on
vr41xx for example.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 arch/mips/kernel/cevt-r4k.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 24a2d90..16e079c 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -186,7 +186,7 @@ static int c0_compare_int_usable(void)
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
+		c0_timer_ack();
 		irq_disable_hazard();
 		if (c0_compare_int_pending())
 			return 0;
@@ -208,7 +208,7 @@ static int c0_compare_int_usable(void)
 	if (!c0_compare_int_pending())
 		return 0;
 
-	write_c0_compare(read_c0_count());
+	c0_timer_ack();
 	irq_disable_hazard();
 	if (c0_compare_int_pending())
 		return 0;
