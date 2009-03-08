Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2009 08:37:35 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:23512 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20808857AbZCHIhd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Mar 2009 08:37:33 +0000
Received: (qmail 27627 invoked from network); 8 Mar 2009 09:37:31 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 8 Mar 2009 09:37:31 +0100
Date:	Sun, 8 Mar 2009 09:37:31 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 08/10] Alchemy: DB1300 blink leds on timer tick
Message-ID: <20090308093731.1e7a9067@scarran.roarinelk.net>
In-Reply-To: <1236452697.9848.1.camel@kh-d820>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	<788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	<0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	<7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	<0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	<394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	<7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	<df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
	<be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
	<20090307103731.4660e57f@scarran.roarinelk.net>
	<1236452697.9848.1.camel@kh-d820>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Sat, 07 Mar 2009 13:04:57 -0600
Kevin Hickey <khickey@rmicorp.com> wrote:

> On Sat, 2009-03-07 at 10:37 +0100, Manuel Lauss wrote:
> > On Fri,  6 Mar 2009 10:20:07 -0600
> > Kevin Hickey <khickey@rmicorp.com> wrote:
> > 
> > > Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
> > > This can help tell the difference between a soft and hard hung board.
> 
> > Please don't do that.  I'd still like to get all devboard hackery out
> > of code in common/ (at least for mainline kernels; what you do to the
> > RMI-sources I don't care about).
> 
> Can you suggest an alternative?  Or are you saying that this
> functionality does not belong in the mainline kernel at all?
> 

How about this?  No ifdefery, and every board can implement its own
board_timer_set callback to blink some leds. (Note, I still don't feel
this is "right", but ultimately it's not up you anyway).

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index f58d4ff..ac448c2 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -44,6 +44,8 @@

 extern int allow_au1k_wait; /* default off for CP0 Counter */

+void (*board_timer_set)(void) = NULL;
+
 static cycle_t au1x_counter1_read(void)
 {
        return au_readl(SYS_RTCREAD);
@@ -67,6 +69,9 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
        au_writel(delta, SYS_RTCMATCH2);
        au_sync();

+       if (board_timer_set)
+               board_timer_set();
+
        return 0;
 }
