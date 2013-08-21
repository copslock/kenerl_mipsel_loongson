Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 09:26:52 +0200 (CEST)
Received: from mail-ea0-f174.google.com ([209.85.215.174]:65143 "EHLO
        mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822344Ab3HUH0sp86ie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 09:26:48 +0200
Received: by mail-ea0-f174.google.com with SMTP id z15so36220ead.19
        for <linux-mips@linux-mips.org>; Wed, 21 Aug 2013 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8JpMez3IRg9yigw3gNFE+GK2f0yYvBi3275GuY+64ow=;
        b=wwNaYu2ocZuUVtCiKwZDB4d5jR0YzpN6T9jFFtftkUphrbbO3lUogZ9eALTJfmhETk
         nt0Rvcrsd08q43BMB7C5BIPmzQ8JiiPZ3elCEr3QQEhvJNRH+W/2nLu6XR3EOSt2RTAX
         CsWUKVVxl0GObZ1JxRFwO3prnfOaPtP+XYNGCo5OtZN7FC5kHVSSyQgAHkMmpL1iqcbD
         m6broSJtZ7mqXaGdw1DFeWP7PhSa+5qnNXmbEd5Oc0EW7ezR3lzd8SwV+a7k2Bjz5NZm
         ZvZSxvUbJNm+YZ4ai6MX/zmNc9WQvs9RsTKjxp+QhI8YJ2Qijx5NAIYCuYf4OwRV5eQn
         Uv0A==
X-Received: by 10.14.210.8 with SMTP id t8mr8180046eeo.39.1377070003382;
        Wed, 21 Aug 2013 00:26:43 -0700 (PDT)
Received: from gmail.com (BC24D856.catv.pool.telekom.hu. [188.36.216.86])
        by mx.google.com with ESMTPSA id l47sm7458180eex.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 00:26:42 -0700 (PDT)
Date:   Wed, 21 Aug 2013 09:26:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC
 help texts
Message-ID: <20130821072640.GA27495@gmail.com>
References: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
> CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but missed
> a few plain English references in the CONFIG_KEXEC help texts.
> 
> Remove them, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/arm/Kconfig     |    3 +--
>  arch/ia64/Kconfig    |    6 +++---
>  arch/mips/Kconfig    |    6 +++---
>  arch/powerpc/Kconfig |    6 +++---
>  arch/sh/Kconfig      |    6 +++---
>  arch/x86/Kconfig     |    6 +++---
>  6 files changed, 16 insertions(+), 17 deletions(-)
[...]
>  	bool "kernel crash dumps (EXPERIMENTAL)"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b32ebf9..6ace5de 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1627,9 +1627,9 @@ config KEXEC
>  
>  	  It is an ongoing process to be certain the hardware in a machine
>  	  is properly shutdown, so do not be surprised if this code does not
> -	  initially work for you.  It may help to enable device hotplugging
> -	  support.  As of this writing the exact hardware interface is
> -	  strongly in flux, so no good recommendation can be made.
> +	  initially work for you.  As of this writing the exact hardware
> +	  interface is strongly in flux, so no good recommendation can be
> +	  made.
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
