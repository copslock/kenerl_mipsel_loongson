Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 06:17:16 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:6788 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20021370AbXCJGRL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2007 06:17:11 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A6Doo4031307
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 22:13:51 -0800
Received: from sony (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l2A6DnSb013154;
	Fri, 9 Mar 2007 22:13:49 -0800
Date:	Fri, 9 Mar 2007 22:13:48 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	stjeanma@pmc-sierra.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] drivers: PMC MSP71xx LED driver
Message-Id: <20070309221348.c5ab7acc.akpm@linux-foundation.org>
In-Reply-To: <45F1DDC8.1010503@pmc-sierra.com>
References: <45F1DDC8.1010503@pmc-sierra.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

> On Fri, 9 Mar 2007 14:20:56 -0800  Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> 
> 
> >  > +typedef enum {
> >  > +     MSP_LED_INPUT = 0,
> >  > +     MSP_LED_OUTPUT,
> >  > +} msp_led_direction_t;
> > 
> > No typedefs, please.   Convert this to
> > 
> > enum msp_led_direction {
> >         ...
> > };
> 
> Alright I'll change it but it wasn't mentioned in the review of
> the previous drivers and they've been resubmitted with some.
> A quick search shows several drivers typedef'ing enums with and
> without *_t suffixes.

Poeple do bad things, and it sometimes gets missed.

> Is there a new style rule or are only core kernel types allowed to
> use _t?

The general rule is: no typedefs.

typedefs make sense when the underlying type can change: u64, size_t,
resource_size_t, etc.  We also use them for really hairy definitions like
filler_t.  Nothing else.  Please don't use them just to save typing.

> 
> >  > +/* Output modes */
> >  > +typedef enum {
> >  > +     MSP_LED_OFF = 0,                /* Off steady */
> >  > +     MSP_LED_ON,                             /* On steady */
> >  > +     MSP_LED_BLINK,                  /* On for initialPeriod, off 
> > for finalPeriod */
> >  > +     MSP_LED_BLINK_INVERT,   /* Off for initialPeriod, on for 
> > finalPeriod */
> >  > +} msp_led_mode_t;
> > 
> > Ditto.
> > 
> >  > +/* For non-LED pins, these macros set HI and LO accordingly */
> >  > +#define msp_led_pin_hi       msp_led_turn_off
> >  > +#define msp_led_pin_lo       msp_led_turn_on
> > 
> > eww.
> > 
> > static inline wrapper functions are preferred.  Write code in C, not cpp
> > where possible.
> 
> I agree the wrappers are cleaner but don't understand how this relates
> to C++.

cpp == C preprocessor.

It would be better to do

/*
 * nice comment goes here 
 */
static inline void msp_led_pin_hi(...)
{
	msp_led_turn_off(...);
}
