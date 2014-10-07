Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 01:23:07 +0200 (CEST)
Received: from v094114.home.net.pl ([79.96.170.134]:64916 "HELO
        v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27010787AbaJGXXEz2AqH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 01:23:04 +0200
Received: from afeu97.neoplus.adsl.tpnet.pl [95.49.124.97] (HELO vostro.rjw.lan)
 by serwer1319399.home.pl [79.96.170.134] with SMTP (IdeaSmtpServer v0.80)
 id dcbcb30690d681b0; Wed, 8 Oct 2014 01:22:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 44/44] kernel: Remove pm_power_off
Date:   Wed, 08 Oct 2014 01:43:07 +0200
Message-ID: <1469166.g4FqVc5SJX@vostro.rjw.lan>
User-Agent: KMail/4.11.5 (Linux/3.16.0-rc5+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1412659726-29957-45-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-45-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Return-Path: <rjw@rjwysocki.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@rjwysocki.net
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

On Monday, October 06, 2014 10:28:46 PM Guenter Roeck wrote:
> No users of pm_power_off are left, so it is safe to remove the function.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

ACK

> ---
>  include/linux/pm.h              |  1 -
>  kernel/power/poweroff_handler.c | 10 +---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 45271b5..fce7645 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -31,7 +31,6 @@
>  /*
>   * Callbacks for platform drivers to implement.
>   */
> -extern void (*pm_power_off)(void);
>  extern void (*pm_power_off_prepare)(void);
>  
>  /*
> diff --git a/kernel/power/poweroff_handler.c b/kernel/power/poweroff_handler.c
> index 96f59ef..01a3a39 100644
> --- a/kernel/power/poweroff_handler.c
> +++ b/kernel/power/poweroff_handler.c
> @@ -20,12 +20,6 @@
>  #include <linux/types.h>
>  
>  /*
> - * If set, calling this function will power off the system immediately.
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
> -/*
>   *	Notifier list for kernel code which wants to be called
>   *	to power off the system.
>   */
> @@ -163,8 +157,6 @@ int register_poweroff_handler_simple(void (*handler)(void), int priority)
>   */
>  void do_kernel_poweroff(void)
>  {
> -	if (pm_power_off)
> -		pm_power_off();
>  	atomic_notifier_call_chain(&poweroff_handler_list, 0, NULL);
>  }
>  
> @@ -175,6 +167,6 @@ void do_kernel_poweroff(void)
>   */
>  bool have_kernel_poweroff(void)
>  {
> -	return pm_power_off != NULL || poweroff_handler_list.head != NULL;
> +	return poweroff_handler_list.head != NULL;
>  }
>  EXPORT_SYMBOL(have_kernel_poweroff);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
