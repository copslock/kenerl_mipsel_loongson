Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 10:47:16 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43782 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133410AbWB0KrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 10:47:05 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3BD0C64D3D; Mon, 27 Feb 2006 10:54:41 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 826EB8D59; Mon, 27 Feb 2006 11:54:33 +0100 (CET)
Date:	Mon, 27 Feb 2006 10:54:33 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060227105433.GJ12044@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060223224346.GA7536@flint.arm.linux.org.uk> <20060224003947.GJ9704@deprecation.cyrius.com> <20060224083141.GA32080@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224083141.GA32080@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Russell King <rmk@arm.linux.org.uk> [2006-02-24 08:31]:
> Not quite - I didn't say "do absolutely nothing" - I did explicitly say
...
> At a guess, for the console port, you want to disable the receiver, leave
> the transmitter enabled, and disable all interrupts originating from the
> port.

I tried to implement this suggestion but it still fails.  Note that
I'm a complete kernel newbie so maybe I just did something wrong.  In
any case, the other fix I just sent (taken from sunzilog) works.

For the record, what I initially tried (but which doesn't work) was:

diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
index 419dd3c..2bda770 100644
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -747,20 +747,23 @@ static void ip22zilog_shutdown(struct ua
 	struct zilog_channel *channel;
 	unsigned long flags;
 
-	if (ZS_IS_CONS(up))
-		return;
-
 	spin_lock_irqsave(&port->lock, flags);
 
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 
-	/* Disable receiver and transmitter.  */
+	/* Disable receiver. */
 	up->curregs[R3] &= ~RxENAB;
-	up->curregs[R5] &= ~TxENAB;
-
-	/* Disable all interrupts and BRK assertion.  */
+	/* Disable all interrupts. */
 	up->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-	up->curregs[R5] &= ~SND_BRK;
+	/* For the console port, we want to disable the receiver, leave
+	 * the transmitter enabled, and disable all interrupts originating
+	 * from the port. */
+	if (!ZS_IS_CONS(up)) {
+		/* Disable transmitter. */
+		up->curregs[R5] &= ~TxENAB;
+		/* Disable BRK assertion. */
+		up->curregs[R5] &= ~SND_BRK;
+	}
 	ip22zilog_maybe_update_regs(up, channel);
 
 	spin_unlock_irqrestore(&port->lock, flags);
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 5cc4d4c..63cdf9d 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -834,20 +834,23 @@ static void sunzilog_shutdown(struct uar
 	struct zilog_channel __iomem *channel;
 	unsigned long flags;
 
-	if (ZS_IS_CONS(up))
-		return;
-
 	spin_lock_irqsave(&port->lock, flags);
 
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 
-	/* Disable receiver and transmitter.  */
+	/* Disable receiver. */
 	up->curregs[R3] &= ~RxENAB;
-	up->curregs[R5] &= ~TxENAB;
-
-	/* Disable all interrupts and BRK assertion.  */
+	/* Disable all interrupts. */
 	up->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-	up->curregs[R5] &= ~SND_BRK;
+	/* For the console port, we want to disable the receiver, leave
+	 * the transmitter enabled, and disable all interrupts originating
+	 * from the port. */
+	if (!ZS_IS_CONS(up)) {
+		/* Disable transmitter. */
+		up->curregs[R5] &= ~TxENAB;
+		/* Disable BRK assertion. */
+		up->curregs[R5] &= ~SND_BRK;
+	}
 	sunzilog_maybe_update_regs(up, channel);
 
 	spin_unlock_irqrestore(&port->lock, flags);

-- 
Martin Michlmayr
http://www.cyrius.com/
