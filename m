Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 14:34:40 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:57326 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225288AbTHLNei>; Tue, 12 Aug 2003 14:34:38 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07910;
	Tue, 12 Aug 2003 15:34:27 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 12 Aug 2003 15:34:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time trailing clean-ups
In-Reply-To: <20030811113428.F9020@mvista.com>
Message-ID: <Pine.GSO.3.96.1030812125503.5935B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 11 Aug 2003, Jun Sun wrote:

> >  Here is hopefully the final part (for now) of the generic time changes.
> > It addresses the following problems:
> > 
> > -	 */
> > -	if (!jiffies) {
> > -		timerhi = timerlo = 0;
> > -		mips_hpt_init(count);
> > +	 *
> > +	 * The first timer interrupt comes late as interrupts are
> > +	 * enabled long after timers are initialized.  Therefore the
> > +	 * high precision timer is fast, leading to wrong gettimeoffset()
> > +	 * calculations.  We deal with it by setting it based on the
> > +	 * number of its ticks between the second and the third interrupt.
> > +	 * That is still somewhat imprecise, but it's a good estimate.
> > +	 * --macro
> > +	 */
> > +	j = jiffies;
> > +	if (j < 4) {
> > +		static unsigned int prev_count;
> > +		static int hpt_initialized;
> > +
> > +		switch (j) {
> > +		case 0:
> > +			timerhi = timerlo = 0;
> > +			mips_hpt_init(count);
> > +			break;
> > +		case 2:
> > +			prev_count = count;
> > +			break;
> > +		case 3:
> > +			if (!hpt_initialized) {
> > +				unsigned int c3 = 3 * (count - prev_count);
> > +
> > +				timerhi = 0;
> > +				timerlo = c3;
> > +				mips_hpt_init(count - c3);
> > +				hpt_initialized = 1;
> > +			}
> > +			break;
> > +		default:
> > +			break;
> > +		}
> >  	}
> > 
> 
> The first gettimeoffset() call is way after many jiffies (~50 normally?).  Such
> an estimate is not necessary.

 As a number of interrupts is lost (at least half a second worth of; it
depends on how long console_init() executes), it takes a few minutes for
gettimeoffset() to recover from the error -- r0 (which is the number of
HPT ticks in a jiffy) is too high.  As a result, offsets within jiffies as
calculated by gettimeoffset() are distributed unevenly.  You may not care,
but I use NTP on my systems and I do care.  With the above initialization,
r0 is almost correct from the beginning and after a few minutes of uptime
the error is no higher than one tick. 

 The fixed_rate_gettimeoffset() backend doesn't care but the calibrate_*()
ones do.

> Also note jiffies can wrap around.  

 Yep, it's already handled and the change above preserves it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
