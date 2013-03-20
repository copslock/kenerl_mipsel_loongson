Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Mar 2013 23:39:44 +0100 (CET)
Received: from plane.gmane.org ([80.91.229.3]:45646 "EHLO plane.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834917Ab3CTWjnCf7s8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Mar 2013 23:39:43 +0100
Received: from list by plane.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1UIRfw-0002y9-3F
        for linux-mips@linux-mips.org; Wed, 20 Mar 2013 23:40:04 +0100
Received: from p579bf2b1.dip.t-dialin.net ([87.155.242.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Mar 2013 23:40:04 +0100
Received: from s.gottschall by p579bf2b1.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Mar 2013 23:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: Re: MIPS: Add dependencies for HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date:   Wed, 20 Mar 2013 23:33:36 +0100
Message-ID: <kiddfo$82s$1@ger.gmane.org>
References: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk> <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p579bf2b1.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk>
X-archive-position: 35922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.gottschall@dd-wrt.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Am 04.03.2013 05:17, schrieb Ben Hutchings:
> The MIPS implementation of transparent huge-pages (THP) is 64-bit only,
> and of course also requires that the CPU supports huge-pages.
>
> Currently it's entirely possible to enable THP in other configurations,
> which then fail to build due to pfn_pmd() not being defined.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: David Daney <david.daney@cavium.com>
> ---
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -19,7 +19,7 @@ config MIPS
>   	select HAVE_KRETPROBES
>   	select HAVE_DEBUG_KMEMLEAK
>   	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
> -	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
>   	select RTC_LIB if !MACH_LOONGSON
>   	select GENERIC_ATOMIC64 if !64BIT
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>
why? the mips32 74k platform (broadcom bcm4706 for instance) does 
support huge pages. and some of these devices are also using highmem for 
accessing more than 128mb ram (which is totally broken in all current 
kernels too and causing filesystem corruptions)
i was able to fix the highmem problem using a patch which was submitted 
but never taken into the mainline, but i just was able to get thb 
partially to work on mips32. but i think it would be possible to support 
this on mips32 as well. so why leaving it out?

regards,
Sebastian Gottschall
