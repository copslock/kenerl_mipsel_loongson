Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 15:55:34 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48112 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903600Ab1J0Nza (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2011 15:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=JjtLe5R3pQqucOq8WLPu8V5YyXdQMKl2wBFv+OWrxCk=;
        b=PFtpAFqfu2t0uuZBgBRCgPtNShNoykKXx0msEzeblSwPNPmq8XQmiPuMHx5+YucPtHQzDTjFI/cml0FCY66UYSNS3dzRi0i0DmAudupnh6rff1e0AnSuHGJ7T+9L+8m92WJAN64froLSWpRdBZ8dypG/9wUuARK35JTudL70GOk=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:36559)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1RJQP5-0006TQ-93; Thu, 27 Oct 2011 14:53:55 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1RJQP3-0004Nb-Cq; Thu, 27 Oct 2011 14:53:53 +0100
Date:   Thu, 27 Oct 2011 14:53:53 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jonas Bonn <jonas@southpole.se>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linux@lists.openrisc.net, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Message-ID: <20111027135353.GM19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1319720503-3183-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 31312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19750

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 11ad0bf..741efb2 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -5,14 +5,15 @@
>  #include <mach/gpio.h>
>  
>  #ifndef __ARM_GPIOLIB_COMPLEX
> +/* assume the mach has defined this */
> +#ifndef irq_to_gpio
> +#define irq_to_gpio irq_to_gpio
> +#endif

Oh, this isn't a valid assumption either - it's far from valid.  Those
sub-architectures which don't define __ARM_GPIOLIB_COMPLEX probably don't
define any kind of irq_to_gpio function by any means.  Some of our
mach/gpio.h header files for sub-architectures using entirely gpiolib
are entirely empty - and we want them to stay that way.
