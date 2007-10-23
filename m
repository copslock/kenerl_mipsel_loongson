Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 11:32:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53909 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029906AbXJWKcc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 11:32:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9NAWVwg001340;
	Tue, 23 Oct 2007 11:32:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9NAWTL3001339;
	Tue, 23 Oct 2007 11:32:29 +0100
Date:	Tue, 23 Oct 2007 11:32:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, yoichi_yuasa@tripeaks.co.jp,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
Message-ID: <20071023103229.GB1033@linux-mips.org>
References: <200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net> <20071023.100645.74754145.nemoto@toshiba-tops.co.jp> <200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net> <20071023.114824.122622188.nemoto@toshiba-tops.co.jp> <alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 07:21:28AM +0200, Thomas Gleixner wrote:

> > Thomas, clockevents_program_event() (or ->set_next_event() method for
> > clock_event_device) is supposed to be called with interrupt enabled?
> 
> Actually all call sites have interrupts disabled right now and I can
> not think of a reason why we would ever call with interrupts
> enabled. Time to add some comment.

In which case arch/{mips,x86]/kernel/i8253.c can both be improved too.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/i8253.c |   12 ++++--------
 arch/x86/kernel/i8253.c  |   12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index 5d9830d..1b54674 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -23,9 +23,7 @@ static DEFINE_SPINLOCK(i8253_lock);
 static void init_pit_timer(enum clock_event_mode mode,
 			   struct clock_event_device *evt)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
+	spin_lock(&i8253_lock);
 
 	switch(mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -54,7 +52,7 @@ static void init_pit_timer(enum clock_event_mode mode,
 		/* Nothing to do here */
 		break;
 	}
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	spin_unlock(&i8253_lock);
 }
 
 /*
@@ -64,12 +62,10 @@ static void init_pit_timer(enum clock_event_mode mode,
  */
 static int pit_next_event(unsigned long delta, struct clock_event_device *evt)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
+	spin_lock(&i8253_lock);
 	outb_p(delta & 0xff , PIT_CH0);	/* LSB */
 	outb(delta >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	spin_unlock(&i8253_lock);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index a42c807..5246515 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -31,9 +31,7 @@ struct clock_event_device *global_clock_event;
 static void init_pit_timer(enum clock_event_mode mode,
 			   struct clock_event_device *evt)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
+	spin_lock(&i8253_lock);
 
 	switch(mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -62,7 +60,7 @@ static void init_pit_timer(enum clock_event_mode mode,
 		/* Nothing to do here */
 		break;
 	}
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	spin_unlock(&i8253_lock);
 }
 
 /*
@@ -72,12 +70,10 @@ static void init_pit_timer(enum clock_event_mode mode,
  */
 static int pit_next_event(unsigned long delta, struct clock_event_device *evt)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
+	spin_lock(&i8253_lock);
 	outb_p(delta & 0xff , PIT_CH0);	/* LSB */
 	outb(delta >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	spin_unlock(&i8253_lock);
 
 	return 0;
 }
