Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 09:00:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51248 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbdIAG7vwqltu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Sep 2017 08:59:51 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v816xmNa010663;
        Fri, 1 Sep 2017 08:59:48 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v816xlJP010661;
        Fri, 1 Sep 2017 08:59:47 +0200
Date:   Fri, 1 Sep 2017 08:59:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/31] mips/sgi-ip22: Use separate static data field with
 with static timer
Message-ID: <20170901065947.GA32117@linux-mips.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-25-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504222183-61202-25-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Aug 31, 2017 at 04:29:36PM -0700, Kees Cook wrote:

> In preparation for changing the timer callback argument to the timer
> pointer, move to a separate static data variable.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/sgi-ip22/ip22-reset.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
> index 196b041866ac..5cc32610e6d3 100644
> --- a/arch/mips/sgi-ip22/ip22-reset.c
> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> @@ -38,6 +38,7 @@
>  #define PANIC_FREQ		(HZ / 8)
>  
>  static struct timer_list power_timer, blink_timer, debounce_timer;
> +static unsigned long blink_timer_timeout;

You're removing power_timer and debounce_timer ...

>  #define MACHINE_PANICED		1
>  #define MACHINE_SHUTTING_DOWN	2
> @@ -86,13 +87,13 @@ static void power_timeout(unsigned long data)
>  	sgi_machine_power_off();
>  }
>  
> -static void blink_timeout(unsigned long data)
> +static void blink_timeout(unsigned long unused)
>  {
>  	/* XXX fix this for fullhouse  */
>  	sgi_ioc_reset ^= (SGIOC_RESET_LC0OFF|SGIOC_RESET_LC1OFF);
>  	sgioc->reset = sgi_ioc_reset;
>  
> -	mod_timer(&blink_timer, jiffies + data);
> +	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
>  }
>  
>  static void debounce(unsigned long data)
> @@ -128,8 +129,8 @@ static inline void power_button(void)
>  	}
>  
>  	machine_state |= MACHINE_SHUTTING_DOWN;
> -	blink_timer.data = POWERDOWN_FREQ;
> -	blink_timeout(POWERDOWN_FREQ);
> +	blink_timer_timeout = POWERDOWN_FREQ;
> +	blink_timeout(0);
>  
>  	setup_timer(&power_timer, power_timeout, 0UL);

... but don't remove the reference to power_timer nor use of debounce_timer.

>  	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
> @@ -169,8 +170,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
>  		return NOTIFY_DONE;
>  	machine_state |= MACHINE_PANICED;
>  
> -	blink_timer.data = PANIC_FREQ;
> -	blink_timeout(PANIC_FREQ);
> +	blink_timer_timeout = PANIC_FREQ;
> +	blink_timeout(0);
>  
>  	return NOTIFY_DONE;
>  }
> @@ -193,8 +194,7 @@ static int __init reboot_setup(void)
>  		return res;
>  	}
>  
> -	init_timer(&blink_timer);
> -	blink_timer.function = blink_timeout;
> +	setup_timer(&blink_timer, blink_timeout, 0);
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>  
>  	return 0;

  Ralf
