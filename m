Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2006 20:40:10 +0100 (BST)
Received: from web37509.mail.mud.yahoo.com ([209.191.91.156]:61335 "HELO
	web37509.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038607AbWJVTkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Oct 2006 20:40:08 +0100
Received: (qmail 4190 invoked by uid 60001); 22 Oct 2006 19:39:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6fO7GOxOP+JXAwQxdXb3VPAF42/SLH0Uue0sD7vwq4WRhAyuD0LHtj9pgQrpgfxWCADs6Qw7idjmsE0/iukfXt3+LBYT59Z+r+r9J94HeUb1oqKow0t+lbEeEcV+jwB2HhjIndn3L/0Z4HK1MStTuUTM+T+pbIxWh9CAHzpHAsw=  ;
Message-ID: <20061022193958.4188.qmail@web37509.mail.mud.yahoo.com>
Received: from [71.146.170.214] by web37509.mail.mud.yahoo.com via HTTP; Sun, 22 Oct 2006 12:39:58 PDT
Date:	Sun, 22 Oct 2006 12:39:58 -0700 (PDT)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
In-Reply-To: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

The init_mips_clocksource() call is made via
module_init(). It does not need to be explicitly
called in time_init() after plat_timer_setup().

Thanks,
Manish Lachwani

--- Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> [Sorry, resend without unrelated changes ...]
> 
> Since we already moved to GENERIC_TIME, we should
> implement
> alternatives of old do_gettimeoffset routines to get
> sub-jiffies
> resolution from gettimeofday().  This patch
> includes:
> 
> * MIPS clocksource support (based on works by Manish
> Lachwani).
> * remove unused gettimeoffset routines and related
> codes.
> * remove unised 64bit do_div64_32().
> * simplify mips_hpt_init. (no argument needed,
> __init tag)
> * simplify c0_hpt_timer_init. (no need to write to
> c0_count)
> * remove some hpt_init routines.
> * mips_hpt_mask variable to specify bitmask of hpt
> value.
> * convert jmr3927_do_gettimeoffset to
> jmr3927_hpt_read.
> * convert ip27_do_gettimeoffset to ip27_hpt_read.
> * convert bcm1480_do_gettimeoffset to
> bcm1480_hpt_read.
> * simplify sb1250 hpt functions. (no need to
> subtract and shift)
> 
> Other than board independent part are not tested. 
> Please test if you
> have those platforms.  Thank you.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>  Documentation/mips/time.README          |   35 ---
>  arch/mips/au1000/common/time.c          |   98
> ----------
>  arch/mips/dec/time.c                    |    9 
>  arch/mips/jmr3927/rbhma3100/setup.c     |   46 +---
>  arch/mips/kernel/time.c                 |  312
> ++++----------------------------
>  arch/mips/philips/pnx8550/common/time.c |    4 
>  arch/mips/pmc-sierra/yosemite/smp.c     |    6 
>  arch/mips/sgi-ip27/ip27-timer.c         |   16 -
>  arch/mips/sibyte/bcm1480/time.c         |   40 ++--
>  arch/mips/sibyte/sb1250/time.c          |   28 --
>  include/asm-mips/div64.h                |   21 --
>  include/asm-mips/sibyte/sb1250.h        |    2 
>  include/asm-mips/time.h                 |   10 -
>  13 files changed, 105 insertions(+), 522
> deletions(-)
> 
> diff --git a/Documentation/mips/time.README
> b/Documentation/mips/time.README
> index e1304b6..e9f428a 100644
> --- a/Documentation/mips/time.README
> +++ b/Documentation/mips/time.README
> @@ -38,17 +38,12 @@ The new time code provide the
> following 
>  
>    a) Implements functions required by Linux common
> code:
>  	time_init
> -	do_gettimeofday
> -	do_settimeofday
>  
>    b) provides an abstraction of RTC and null RTC
> implementation as default.
>  	extern unsigned long (*rtc_get_time)(void);
>  	extern int (*rtc_set_time)(unsigned long);
>  
> -  c) a set of gettimeoffset functions for different
> CPUs and different
> -     needs.
> -
> -  d) high-level and low-level timer interrupt
> routines where the timer 
> +  c) high-level and low-level timer interrupt
> routines where the timer 
>       interrupt source  may or may not be the CPU
> timer.  The high-level 
>       routine is dispatched through do_IRQ() while
> the low-level is 
>       dispatched in assemably code (usually
> int-handler.S)
> @@ -73,8 +68,7 @@ the following functions or values:
>    c) (optional) board-specific RTC routines.
>  
>    d) (optional) mips_hpt_frequency - It must be
> definied if the board
> -     is using CPU counter for timer interrupt or it
> is using fixed rate
> -     gettimeoffset().
> +     is using CPU counter for timer interrupt.
>  
>  
>  PORTING GUIDE
> @@ -89,16 +83,6 @@ Step 1: decide how you like to
> implement
>       If the answer is no, you need a timer to
> provide the timer interrupt
>       at 100 HZ speed.
>  
> -     You cannot use the fast gettimeoffset
> functions, i.e.,
> -
> -	unsigned long fixed_rate_gettimeoffset(void);
> -	unsigned long calibrate_div32_gettimeoffset(void);
> -	unsigned long calibrate_div64_gettimeoffset(void);
> -
> -    You can use null_gettimeoffset() will gives the
> same time resolution as
> -    jiffy.  Or you can implement your own
> gettimeoffset (probably based on 
> -    some ad hoc hardware on your machine.)
> -
>    c) The following sub steps assume your CPU has
> counter register.
>       Do you plan to use the CPU counter register as
> the timer interrupt
>       or use an exnternal timer?
> @@ -123,8 +107,8 @@ Step 3: implement rtc routines,
> board_ti
>    board_time_init() -
>    	a) (optional) set up RTC routines,
>          b) (optional) calibrate and set the
> mips_hpt_frequency
> - 	    (only needed if you intended to use
> fixed_rate_gettimeoffset
> - 	     or use cpu counter as timer interrupt
> source)
> + 	    (only needed if you intended to use cpu
> counter as timer interrupt
> + 	     source)
>  
>    plat_timer_setup() -
>   	a) (optional) over-write any choices made above
> by time_init().
> @@ -154,8 +138,8 @@ for some of the functions in
> time.c.  
>  For example, you may define your own timer
> interrupt routine, which does
>  some of its own processing and then calls
> timer_interrupt().
>  
> -You can also over-ride any of the built-in
> functions (gettimeoffset,
> -RTC routines and/or timer interrupt routine).
> +You can also over-ride any of the built-in
> functions (RTC routines
> +and/or timer interrupt routine).
>  
>  
>  PORTING NOTES FOR SMP
> @@ -187,10 +171,3 @@ You need to decide on your
> timer interru
>  
>  	You can also do the low-level version of those
> interrupt routines,
>  	following similar dispatching routes described
> above.
> -
> -Note about do_gettimeoffset():
> -
> -  It is very likely the CPU counter registers are
> not sync'ed up in a SMP box.
> -  Therefore you cannot really use the many of the
> existing routines that
> -  are based on CPU counter.  You should wirte your
> own gettimeoffset rouinte
> -  if you want intra-jiffy resolution.
> diff --git a/arch/mips/au1000/common/time.c
> b/arch/mips/au1000/common/time.c
> index 94f0919..5c5ffde 100644
> --- a/arch/mips/au1000/common/time.c
> +++ b/arch/mips/au1000/common/time.c
> @@ -53,9 +53,6 @@ static unsigned long r4k_cur;   
> /* What
>  int	no_au1xxx_32khz;
>  extern int allow_au1k_wait; /* default off for CP0
> Counter */
>  
> -/* Cycle counter value at the previous timer
> interrupt.. */
> -static unsigned int timerhi = 0, timerlo = 0;
> -
>  #ifdef CONFIG_PM
>  #if HZ < 100 || HZ > 1000
>  #error "unsupported HZ value! Must be in
> [100,1000]"
> @@ -91,10 +88,6 @@ void mips_timer_interrupt(void)
>  		goto null;
>  
>  	do {
> -		count = read_c0_count();
> -		timerhi += (count < timerlo);   /* Wrap around */
> -		timerlo = count;
> -
>  		kstat_this_cpu.irqs[irq]++;
>  		do_timer(1);
> 
=== message truncated ===
