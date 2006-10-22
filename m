Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2006 20:26:07 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:55200 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038624AbWJVT0G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Oct 2006 20:26:06 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 51C3C3ECC; Sun, 22 Oct 2006 12:25:42 -0700 (PDT)
Message-ID: <453BC5B4.50005@ru.mvista.com>
Date:	Sun, 22 Oct 2006 23:25:40 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> [Sorry, resend without unrelated changes ...]

> Since we already moved to GENERIC_TIME, we should implement
> alternatives of old do_gettimeoffset routines to get sub-jiffies
> resolution from gettimeofday().  This patch includes:
> 
> * MIPS clocksource support (based on works by Manish Lachwani).
> * remove unused gettimeoffset routines and related codes.
> * remove unised 64bit do_div64_32().
> * simplify mips_hpt_init. (no argument needed, __init tag)
> * simplify c0_hpt_timer_init. (no need to write to c0_count)
> * remove some hpt_init routines.
> * mips_hpt_mask variable to specify bitmask of hpt value.
> * convert jmr3927_do_gettimeoffset to jmr3927_hpt_read.
> * convert ip27_do_gettimeoffset to ip27_hpt_read.
> * convert bcm1480_do_gettimeoffset to bcm1480_hpt_read.
> * simplify sb1250 hpt functions. (no need to subtract and shift)

> Other than board independent part are not tested.  Please test if you
> have those platforms.  Thank you.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

>  Documentation/mips/time.README          |   35 ---
>  arch/mips/au1000/common/time.c          |   98 ----------

    If the generic implementation is working well, the Alchemy code doesn't 
need its own anymore. However, my patch that fixes the mips_hpt_frequency 
calculation needs to be applied first before deleing this code. I'll try to 
look into this and test some time...

>  arch/mips/dec/time.c                    |    9 
>  arch/mips/jmr3927/rbhma3100/setup.c     |   46 +---
>  arch/mips/kernel/time.c                 |  312 ++++----------------------------
>  arch/mips/philips/pnx8550/common/time.c |    4 
>  arch/mips/pmc-sierra/yosemite/smp.c     |    6 
>  arch/mips/sgi-ip27/ip27-timer.c         |   16 -
>  arch/mips/sibyte/bcm1480/time.c         |   40 ++--
>  arch/mips/sibyte/sb1250/time.c          |   28 --
>  include/asm-mips/div64.h                |   21 --
>  include/asm-mips/sibyte/sb1250.h        |    2 
>  include/asm-mips/time.h                 |   10 -
>  13 files changed, 105 insertions(+), 522 deletions(-)

> diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
> index 0254340..744f746 100644
> --- a/arch/mips/jmr3927/rbhma3100/setup.c
> +++ b/arch/mips/jmr3927/rbhma3100/setup.c
> @@ -170,12 +170,26 @@ static void jmr3927_machine_power_off(vo
>  	while (1);
>  }
>  
> +static unsigned int jmr3927_hpt_read(void)
> +{
> +	unsigned int count;
> +	unsigned long j;
> +	/* read consistent jiffies and counter */
> +	do {
> +		count = jmr3927_tmrptr->trr;
> +		j = jiffies;
> +	} while (count > jmr3927_tmrptr->trr);
> +	return j * (JMR3927_TIMER_CLK / HZ) + count;
> +}

    That emulation trick looks very dubious. I'd suggest to implement a 
different clocksource driver instead, since this is, after all, is not a CPU 
counter. And this will get in the way of the clockevent implementation later. 
  Also, it's stops to be continuous this way. And I don't understand why you 
need this trick at all if you have the variable mips_hpt_mask...
    And the same complaint about BCM1480 code.

> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index debe86c..2c6d52b 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -11,6 +11,7 @@
>   * Free Software Foundation;  either version 2 of the  License, or (at your
>   * option) any later version.
>   */
> +#include <linux/clocksource.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +void (*mips_hpt_init)(void) __initdata = null_hpt_init;
> +unsigned int mips_hpt_mask = 0xffffffff;
>  
>  /* last time when xtime and rtc are sync'ed up */
>  static long last_rtc_update;
> @@ -533,13 +310,41 @@ static unsigned int __init calibrate_hpt
>  	} while (--i);
>  	hpt_end = mips_hpt_read();
>  
> -	hpt_count = hpt_end - hpt_start;
> +	hpt_count = (hpt_end - hpt_start) & mips_hpt_mask;
>  	hz = HZ;
>  	frequency = (u64)hpt_count * (u64)hz;
>  
>  	return frequency >> log_2_loops;
>  }
>  
> +static cycle_t read_mips_hpt(void)
> +{
> +	return (cycle_t)mips_hpt_read();
> +}
> +
> +static struct clocksource clocksource_mips = {
> +	.name		= "MIPS",
> +	.rating		= 250,
> +	.read		= read_mips_hpt,
> +	.shift		= 24,
> +	.is_continuous	= 1,
> +};
> +
> +static void __init init_mips_clocksource(void)
> +{
> +	u64 temp;
> +
> +	if (!mips_hpt_frequency || mips_hpt_read == null_hpt_read)
> +		return;
> +
> +	temp = (u64) NSEC_PER_SEC << clocksource_mips.shift;
> +	do_div(temp, mips_hpt_frequency);
> +	clocksource_mips.mult = (unsigned)temp;
> +	clocksource_mips.mask = mips_hpt_mask;
> +
> +	clocksource_register(&clocksource_mips);
> +}
> +

    Well, I'd vote against the generic implementation. It's not quite correct 
to call all the diverse timers here "MIPS", IMHO...

> @@ -633,6 +411,8 @@ void __init time_init(void)
>  	 * is not invoked accidentally.
>  	 */
>  	plat_timer_setup(&timer_irqaction);
> +
> +	init_mips_clocksource();

    Well, this is usually done via module_init()...

WBR, Sergei
