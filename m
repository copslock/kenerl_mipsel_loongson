Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:38:50 +0200 (CEST)
Received: from mail-yk0-f172.google.com ([209.85.160.172]:50960 "EHLO
        mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010964AbaJIPis7Pk1O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:38:48 +0200
Received: by mail-yk0-f172.google.com with SMTP id 19so810010ykq.17
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0k/N24PcUBe9iG10NtBv929oRNel0z3lrcVo0Ih+L1Y=;
        b=rRmkaEPZRlnBYtmJ2smsj71zw1hFtgU7w9KOwCZaiuc7JKOyrP2B2W6vE5p4G6+UP7
         mKv6/4TV1579tLsk0A2qbf/x6NIX6zvyNNvdLAZ9tFEGoCklFy2V3E9zwJpYpn5TPkYi
         5INOaXNP0tXOJxdATJQiSyns6YnoVGtV9PU1mPmXlIuG9TAMP7F2N9a36ojQeeebudJI
         BEo6XPfxRpvda8J+9BFLVnbgt6NYJWqZuWwLkc7U0ys419w7Wqad0hzKgF6y9CkItbsq
         h+ANcMeOqYevTBaoYBOHq7kZfi1NpwE1wz1rYllnLVwKd4z161XajBpD3Zyoci0MfWlm
         1gsA==
X-Received: by 10.70.103.139 with SMTP id fw11mr518450pdb.64.1412869122756;
        Thu, 09 Oct 2014 08:38:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id yw3sm845932pbc.88.2014.10.09.08.38.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 08:38:41 -0700 (PDT)
Date:   Thu, 9 Oct 2014 08:38:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20141009153836.GA31987@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
 <20141009103143.GA6787@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141009103143.GA6787@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Oct 09, 2014 at 12:31:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +/**
> > + *	register_poweroff_handler_simple - Register function to be called to power off
> > + *					   the system
> > + *	@handler:	Function to be called to power off the system
> > + *	@priority:	Handler priority. For priority guidelines see
> > + *			register_poweroff_handler.
> > + *
> > + *	This is a simplified version of register_poweroff_handler. It does not
> > + *	take a notifier as argument, but a function pointer. The function
> > + *	registers a poweroff handler with specified priority. Poweroff
> > + *	handlers registered with this function can not be unregistered,
> > + *	and only a single poweroff handler can be installed using it.
> > + *
> > + *	This function must not be called from modules and is therefore
> > + *	not exported.
> > + *
> > + *	Returns -EBUSY if a poweroff handler has already been registered
> > + *	using register_poweroff_handler_simple. Otherwise returns zero,
> > + *	since atomic_notifier_chain_register() currently always returns zero.
> > + */
> > +int register_poweroff_handler_simple(void (*handler)(void), int priority)
> > +{
> > +	char symname[KSYM_NAME_LEN];
> > +
> > +	if (poweroff_handler_data.handler) {
> > +		lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
> > +				   symname);
> > +		pr_warn("Poweroff function already registered (%s)", symname);
> > +		lookup_symbol_name((unsigned long)handler, symname);
> > +		pr_cont(", cannot register %s\n", symname);
> > +		return -EBUSY;
> > +	}
> 
> Dunno, are you maybe overdoing the debugging infrastructure a bit?
> This is not going to happen in production, and if it does happen,
> developer can look the symbol name himself.

On the other side, I don't think it hurts to have that message.
Anyway, I'll use %ps as suggested by Geert.

Guenter
