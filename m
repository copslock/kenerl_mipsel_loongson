Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 18:43:55 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:48546 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133778AbWGERno (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2006 18:43:44 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 45C88443C9; Wed,  5 Jul 2006 19:43:41 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FyBPN-0005Ar-7O; Wed, 05 Jul 2006 18:43:29 +0100
Date:	Wed, 5 Jul 2006 18:43:29 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Search+replace gone wrong...
Message-ID: <20060705174329.GA15138@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

some random hit by search+replace, it seems.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index ac658c4..c64a820 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -316,9 +316,9 @@ #define MACEISA_MISC_INT	(MACEISA_RTC_IN
 				 MACEISA_KEYB_POLL_INT |	\
 				 MACEISA_MOUSE_INT |		\
 				 MACEISA_MOUSE_POLL_INT |	\
-				 MACEIIRQF_TIMER0_INT |		\
-				 MACEIIRQF_TIMER1_INT |		\
-				 MACEIIRQF_TIMER2_INT)
+				 MACEISA_TIMER0_INT |		\
+				 MACEISA_TIMER1_INT |		\
+				 MACEISA_TIMER2_INT)
 #define MACEISA_SUPERIO_INT	(MACEISA_PARALLEL_INT |		\
 				 MACEISA_PAR_CTXA_INT |		\
 				 MACEISA_PAR_CTXB_INT |		\
@@ -349,7 +349,7 @@ static void enable_maceisa_irq (unsigned
 	case MACEISA_AUDIO_SW_IRQ ... MACEISA_AUDIO3_MERR_IRQ:
 		crime_int = MACE_AUDIO_INT;
 		break;
-	case MACEISA_RTC_IRQ ... MACEIIRQF_TIMER2_IRQ:
+	case MACEISA_RTC_IRQ ... MACEISA_TIMER2_IRQ:
 		crime_int = MACE_MISC_INT;
 		break;
 	case MACEISA_PARALLEL_IRQ ... MACEISA_SERIAL2_RDMAOR_IRQ:
