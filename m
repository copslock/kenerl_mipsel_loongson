Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 19:34:36 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41971 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTHKSee>;
	Mon, 11 Aug 2003 19:34:34 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7BIYSD09530;
	Mon, 11 Aug 2003 11:34:28 -0700
Date: Mon, 11 Aug 2003 11:34:28 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time trailing clean-ups
Message-ID: <20030811113428.F9020@mvista.com>
References: <Pine.GSO.3.96.1030811144812.19197C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030811144812.19197C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 11, 2003 at 03:02:16PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Aug 11, 2003 at 03:02:16PM +0200, Maciej W. Rozycki wrote:
> Hello,
> 
>  Here is hopefully the final part (for now) of the generic time changes.
> It addresses the following problems:
> 
> -	 */
> -	if (!jiffies) {
> -		timerhi = timerlo = 0;
> -		mips_hpt_init(count);
> +	 *
> +	 * The first timer interrupt comes late as interrupts are
> +	 * enabled long after timers are initialized.  Therefore the
> +	 * high precision timer is fast, leading to wrong gettimeoffset()
> +	 * calculations.  We deal with it by setting it based on the
> +	 * number of its ticks between the second and the third interrupt.
> +	 * That is still somewhat imprecise, but it's a good estimate.
> +	 * --macro
> +	 */
> +	j = jiffies;
> +	if (j < 4) {
> +		static unsigned int prev_count;
> +		static int hpt_initialized;
> +
> +		switch (j) {
> +		case 0:
> +			timerhi = timerlo = 0;
> +			mips_hpt_init(count);
> +			break;
> +		case 2:
> +			prev_count = count;
> +			break;
> +		case 3:
> +			if (!hpt_initialized) {
> +				unsigned int c3 = 3 * (count - prev_count);
> +
> +				timerhi = 0;
> +				timerlo = c3;
> +				mips_hpt_init(count - c3);
> +				hpt_initialized = 1;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
>  	}
> 

The first gettimeoffset() call is way after many jiffies (~50 normally?).  Such
an estimate is not necessary.

Also note jiffies can wrap around.  

Jun
