Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 09:04:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51624 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbdIAHEhnMTRu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Sep 2017 09:04:37 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v8174au6010804;
        Fri, 1 Sep 2017 09:04:36 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v8174ZgC010803;
        Fri, 1 Sep 2017 09:04:35 +0200
Date:   Fri, 1 Sep 2017 09:04:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/31] mips/sgi-ip32: Use separate static data field with
 with static timer
Message-ID: <20170901070435.GB32117@linux-mips.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-24-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504222183-61202-24-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59905
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

On Thu, Aug 31, 2017 at 04:29:35PM -0700, Kees Cook wrote:

> In preparation for changing the timer callback argument to the timer
> pointer, move to a separate static data variable.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/sgi-ip32/ip32-reset.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
> index 4e263fd4deff..6636a9c686cd 100644
> --- a/arch/mips/sgi-ip32/ip32-reset.c
> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> @@ -38,6 +38,7 @@
>  extern struct platform_device ip32_rtc_device;
>  
>  static struct timer_list power_timer, blink_timer;
> +static unsigned long blink_timer_timeout;

Similar to the IP22 patch this patch removes power_timer ...

>  static int has_panicked, shutting_down;
>  
>  static __noreturn void ip32_poweroff(void *data)
> @@ -71,11 +72,11 @@ static void ip32_machine_restart(char *cmd)
>  	unreachable();
>  }
>  
> -static void blink_timeout(unsigned long data)
> +static void blink_timeout(unsigned long unused)
>  {
>  	unsigned long led = mace->perif.ctrl.misc ^ MACEISA_LED_RED;
>  	mace->perif.ctrl.misc = led;
> -	mod_timer(&blink_timer, jiffies + data);
> +	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
>  }
>  
>  static void ip32_machine_halt(void)
> @@ -99,8 +100,8 @@ void ip32_prepare_poweroff(void)
>  	}
>  
>  	shutting_down = 1;
> -	blink_timer.data = POWERDOWN_FREQ;
> -	blink_timeout(POWERDOWN_FREQ);
> +	blink_timer_timeout = POWERDOWN_FREQ;
> +	blink_timeout(0);
>  
>  	setup_timer(&power_timer, power_timeout, 0UL);

... but doesn't fix the users.

>  	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
> @@ -120,8 +121,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
>  	led = mace->perif.ctrl.misc | MACEISA_LED_GREEN;
>  	mace->perif.ctrl.misc = led;
>  
> -	blink_timer.data = PANIC_FREQ;
> -	blink_timeout(PANIC_FREQ);
> +	blink_timer_timeout = PANIC_FREQ;
> +	blink_timeout(0);
>  
>  	return NOTIFY_DONE;
>  }
> @@ -142,8 +143,7 @@ static __init int ip32_reboot_setup(void)
>  	_machine_halt = ip32_machine_halt;
>  	pm_power_off = ip32_machine_halt;
>  
> -	init_timer(&blink_timer);
> -	blink_timer.function = blink_timeout;
> +	setup_timer(&blink_timer, blink_timeout, 0);
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>  
>  	return 0;

  Ralf
