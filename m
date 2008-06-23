Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2008 23:50:06 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:31376 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28575620AbYFWWt7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2008 23:49:59 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KAurF-0004yk-00; Tue, 24 Jun 2008 00:49:57 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id A0A12FB464; Tue, 24 Jun 2008 00:48:05 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix IP32 unexpected irq 71
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080623224805.A0A12FB464@solo.franken.de>
Date:	Tue, 24 Jun 2008 00:48:05 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

It's possible that the crime interrupt handler is called without
pending interrupts (probably a hardware issue). To avoid irritating
"unexpected irq 71" messages, we now just ignore the spurious crime
interrupts.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip32/ip32-irq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index b0ea0e4..0d6b666 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -425,6 +425,11 @@ static void ip32_irq0(void)
 	BUILD_BUG_ON(MACEISA_SERIAL2_RDMAOR_IRQ - MACEISA_AUDIO_SW_IRQ != 31);
 
 	crime_int = crime->istat & crime_mask;
+
+	/* crime sometime delivers spurious interrupts, ignore them */
+	if (unlikely(crime_int == 0))
+		return;
+
 	irq = MACE_VID_IN1_IRQ + __ffs(crime_int);
 
 	if (crime_int & CRIME_MACEISA_INT_MASK) {
