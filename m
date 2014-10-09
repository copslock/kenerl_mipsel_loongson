Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 12:31:46 +0200 (CEST)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47638 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010918AbaJIKbozqj0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 12:31:44 +0200
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1C5D381E56; Thu,  9 Oct 2014 12:31:44 +0200 (CEST)
Date:   Thu, 9 Oct 2014 12:31:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Romain Perier <romain.perier@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
Message-ID: <20141009103143.GA6787@amd>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
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

Hi!

> +/**
> + *	register_poweroff_handler_simple - Register function to be called to power off
> + *					   the system
> + *	@handler:	Function to be called to power off the system
> + *	@priority:	Handler priority. For priority guidelines see
> + *			register_poweroff_handler.
> + *
> + *	This is a simplified version of register_poweroff_handler. It does not
> + *	take a notifier as argument, but a function pointer. The function
> + *	registers a poweroff handler with specified priority. Poweroff
> + *	handlers registered with this function can not be unregistered,
> + *	and only a single poweroff handler can be installed using it.
> + *
> + *	This function must not be called from modules and is therefore
> + *	not exported.
> + *
> + *	Returns -EBUSY if a poweroff handler has already been registered
> + *	using register_poweroff_handler_simple. Otherwise returns zero,
> + *	since atomic_notifier_chain_register() currently always returns zero.
> + */
> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
> +{
> +	char symname[KSYM_NAME_LEN];
> +
> +	if (poweroff_handler_data.handler) {
> +		lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
> +				   symname);
> +		pr_warn("Poweroff function already registered (%s)", symname);
> +		lookup_symbol_name((unsigned long)handler, symname);
> +		pr_cont(", cannot register %s\n", symname);
> +		return -EBUSY;
> +	}

Dunno, are you maybe overdoing the debugging infrastructure a bit?
This is not going to happen in production, and if it does happen,
developer can look the symbol name himself.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
