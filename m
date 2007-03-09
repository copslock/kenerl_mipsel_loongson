Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 22:22:27 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:33212 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021657AbXCIWWV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 22:22:21 +0000
Received: (qmail 26574 invoked by uid 101); 9 Mar 2007 22:21:10 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 9 Mar 2007 22:21:10 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l29ML98Z031875;
	Fri, 9 Mar 2007 14:21:09 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPQVNJ>; Fri, 9 Mar 2007 14:21:09 -0800
Message-ID: <45F1DDC8.1010503@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] drivers: PMC MSP71xx LED driver
Date:	Fri, 9 Mar 2007 14:20:56 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 09 Mar 2007 22:20:56.0903 (UTC) FILETIME=[356A5D70:01C76299]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Andrew Morton wrote:
>  > On Mon, 26 Feb 2007 17:48:55 -0600 Marc St-Jean 
> <stjeanma@pmc-sierra.com> wrote:
>  > [PATCH] drivers: PMC MSP71xx LED driver
>  >
>  > Patch to add LED driver for the PMC-Sierra MSP71xx devices.
>  >
>  > This patch references some platform support files previously
>  > submitted to the linux-mips@linux-mips.org list.

Thanks for the feedback Andrew, I've implemented your recommendations.
A few comments/answers below.

[...]

>  > +     /* determine the progress into the current cycle, relative to 
> the POLL_PERIOD */
>  > +     initialPeriod = (u8)(*ledRegPtr >> MSP_LED_INITIALPERIOD_SHIFT);
>  > +     finalPeriod = (u8)(*ledRegPtr >> MSP_LED_FINALPERIOD_SHIFT);
>  > +     ledTimeOut = (u8)(*ledRegPtr >> MSP_LED_WATCHDOG_SHIFT);
>  > +     timer = (u8)(private_msp_led_register[ledId] >> 
> MSP_LED_WATCHDOG_SHIFT);
> 
> I assume all these (u8) casts are unneeded.
> 
>  > +     totalPeriod = (u16)initialPeriod + (u16)finalPeriod;
> 
> And here.

I assume the author didn't expect the integer promotion to occur until
after the addition.

[...]

> 
>  > +{
>  > +     int pin;
>  > +     u8 currDirectionBits, currDataBits, prevDataBits, 
> prevDirectionBits;
>  > +     currDirectionBits = currDataBits = prevDataBits = 
> prevDirectionBits = 0;
> 
> The unneeded initialisations here are just to suppress the incorrect gcc
> warning, yes?

No, initialization is needed as they are passed by reference to functions
setting/clearing bits.

> If so, that should at least be comented.  And try to avoid declarations o
> this form as well as multiple assignments.  So you want:
> 
>         u8 curr_direction_bits = 0;     /* Suppress gcc warning */
>         u8 curr_data_bits = 0;          /* Suppress gcc warning */
>         u8 prev_data_bits = 0;          /* Suppress gcc warning */
>         u8 prev_direction_bits = 0;     /* Suppress gcc warning */
> 
> the initialisation does cause extra ode to be generated and we usually just
> let te warning come out.  I think later gcc's fixed it.

OK, I've split them on to separate line but without the comment.

[...]

> 
>  > +void __init pmctwiled_setup(void)
>  > +{
>  > +     static int called;
>  > +     int dev;
>  > +
>  > +     /* check if already initialized */
>  > +     if( called )
>  > +             return;
> 
> This cannot happen (can it?)

Yes it can happen. Platform code can call pmctwiled_setup (that's why
the function was written) before the pmctwiled_init function runs.
This is so various sub-system init functions can ensure initialization
has occurred before setting start-up values.

If you have an idea on a better way to accomplish this I'm all ears.


>  > +     /* initialize LEDs to default state */
>  > +     for( dev = 0; dev < MSP_LED_NUM_DEVICES; dev++ ) {
>  > +             int pin;
>  > +             pmctwiled_device[dev] = NULL;
>  > +            
>  > +             for( pin = 0; pin < 8; pin++ ) {
>  > +                     int led = MSP_LED_DEVPIN(dev,pin);
>  > +                     if (mspLedInitialInputState[dev] & (1 << pin)) 
> {                               
>  > +                             msp_led_disable(led);
>  > +                     } else {
>  > +                             msp_led_enable(led);
>  > +                             if (mspLedInitialPinState[dev] & (1 << 
> pin))                                                                   
> 
>  > +                                     msp_led_turn_on(led);           
>                
>  > +                             else                   
>  > +                                     msp_led_turn_off(led);
>  > +                     }
>  > +                    
>  > +                     /* Initialize the private led register memory */
>  > +                     private_msp_led_register[led] = 0;
>  > +             }
>  > +     }
>  > +    
>  > +     /* indicate initialised */
>  > +     called++;
>  > +}

[...]

>  > +typedef enum {
>  > +     MSP_LED_INPUT = 0,
>  > +     MSP_LED_OUTPUT,
>  > +} msp_led_direction_t;
> 
> No typedefs, please.   Convert this to
> 
> enum msp_led_direction {
>         ...
> };

Alright I'll change it but it wasn't mentioned in the review of
the previous drivers and they've been resubmitted with some.
A quick search shows several drivers typedef'ing enums with and
without *_t suffixes.

Is there a new style rule or are only core kernel types allowed to
use _t?


>  > +/* Output modes */
>  > +typedef enum {
>  > +     MSP_LED_OFF = 0,                /* Off steady */
>  > +     MSP_LED_ON,                             /* On steady */
>  > +     MSP_LED_BLINK,                  /* On for initialPeriod, off 
> for finalPeriod */
>  > +     MSP_LED_BLINK_INVERT,   /* Off for initialPeriod, on for 
> finalPeriod */
>  > +} msp_led_mode_t;
> 
> Ditto.
> 
>  > +/* For non-LED pins, these macros set HI and LO accordingly */
>  > +#define msp_led_pin_hi       msp_led_turn_off
>  > +#define msp_led_pin_lo       msp_led_turn_on
> 
> eww.
> 
> static inline wrapper functions are preferred.  Write code in C, not cpp
> where possible.

I agree the wrappers are cleaner but don't understand how this relates
to C++.

Marc
