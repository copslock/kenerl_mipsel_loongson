Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 18:05:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:23280 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTHLRFl>;
	Tue, 12 Aug 2003 18:05:41 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7CH5bN30210;
	Tue, 12 Aug 2003 10:05:37 -0700
Date: Tue, 12 Aug 2003 10:05:37 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time trailing clean-ups
Message-ID: <20030812100537.B30067@mvista.com>
References: <20030811113428.F9020@mvista.com> <Pine.GSO.3.96.1030812125503.5935B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030812125503.5935B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Aug 12, 2003 at 03:34:25PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 12, 2003 at 03:34:25PM +0200, Maciej W. Rozycki wrote:
> On Mon, 11 Aug 2003, Jun Sun wrote:
> 
> > >  Here is hopefully the final part (for now) of the generic time changes.
> > > It addresses the following problems:
> > > 
> > > -	 */
> > > -	if (!jiffies) {
> > > -		timerhi = timerlo = 0;
> > > -		mips_hpt_init(count);
> > > +	 *
> > > +	 * The first timer interrupt comes late as interrupts are
> > > +	 * enabled long after timers are initialized.  Therefore the
> > > +	 * high precision timer is fast, leading to wrong gettimeoffset()
> > > +	 * calculations.  We deal with it by setting it based on the
> > > +	 * number of its ticks between the second and the third interrupt.
> > > +	 * That is still somewhat imprecise, but it's a good estimate.
> > > +	 * --macro
> > > +	 */
> > > +	j = jiffies;
> > > +	if (j < 4) {
> > > +		static unsigned int prev_count;
> > > +		static int hpt_initialized;
> > > +
> > > +		switch (j) {
> > > +		case 0:
> > > +			timerhi = timerlo = 0;
> > > +			mips_hpt_init(count);
> > > +			break;
> > > +		case 2:
> > > +			prev_count = count;
> > > +			break;
> > > +		case 3:
> > > +			if (!hpt_initialized) {
> > > +				unsigned int c3 = 3 * (count - prev_count);
> > > +
> > > +				timerhi = 0;
> > > +				timerlo = c3;
> > > +				mips_hpt_init(count - c3);
> > > +				hpt_initialized = 1;
> > > +			}
> > > +			break;
> > > +		default:
> > > +			break;
> > > +		}
> > >  	}
> > > 
> > 
> > The first gettimeoffset() call is way after many jiffies (~50 normally?).  Such
> > an estimate is not necessary.
> 
>  As a number of interrupts is lost (at least half a second worth of; it
> depends on how long console_init() executes), it takes a few minutes for
> gettimeoffset() to recover from the error -- r0 (which is the number of
> HPT ticks in a jiffy) is too high.  As a result, offsets within jiffies as
> calculated by gettimeoffset() are distributed unevenly.  You may not care,
> but I use NTP on my systems and I do care.  With the above initialization,
> r0 is almost correct from the beginning and after a few minutes of uptime
> the error is no higher than one tick. 
> 
>  The fixed_rate_gettimeoffset() backend doesn't care but the calibrate_*()
> ones do.

Perhaps we should always calibrate the counter frequency and forget about
all those calibrate_*() routines.  This will allow us to get rid of a few
funtions.  Plus knowing the frequency is generally a good thing (for some
performance measurement, for example).

I have a patch floating around just doing that, and in MontaVista tree
we have already done for a long time.

The patch is at 

http://linux.junsun.net/patches/oss.sgi.com/experimental/011128.calibrate_mips_counter.patch

(Wow!  I can't believe it was done almost two years ago.)

Jun
