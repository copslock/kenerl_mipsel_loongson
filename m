Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 17:56:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22292 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025160AbcDVP4SasP6y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 17:56:18 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 57AD069E79807;
        Fri, 22 Apr 2016 16:56:09 +0100 (IST)
Received: from [10.20.78.30] (10.20.78.30) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 22 Apr 2016
 16:56:11 +0100
Date:   Fri, 22 Apr 2016 16:56:02 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <fengguang.wu@intel.com>,
        "stable # v4 . 4+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Allow R6 compact branch policy to be left
 unspecified
In-Reply-To: <1461314611-15317-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1604221648580.21846@tp.orcam.me.uk>
References: <1461314611-15317-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.30]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 22 Apr 2016, Paul Burton wrote:

> It turns out that some toolchains which support MIPS R6 don't support
> the -mcompact-branches flag to specify compact branch behaviour. Default
> to not providing the -mcompact-branch option to the compiler such that
> we can build with such toolchains.

 Good idea overall, one further suggestion below.

> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index f0e314c..e91b3d1 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -117,7 +117,15 @@ if CPU_MIPSR6
>  
>  choice
>  	prompt "Compact branch policy"
> -	default MIPS_COMPACT_BRANCHES_OPTIMAL
> +	default MIPS_COMPACT_BRANCHES_DEFAULT
> +
> +config MIPS_COMPACT_BRANCHES_DEFAULT
> +	bool "Toolchain Default (don't specify)"
> +	help
> +	  Don't pass the -mcompact-branches flag to the compiler, allowing it
> +	  to use its default (generally "optimal"). This is particularly
> +	  useful for early R6-supporting toolchains which don't support the
> +	  -mcompact-branches flag.
>  
>  config MIPS_COMPACT_BRANCHES_NEVER
>  	bool "Never (force delay slot branches)"

 How about making the option depend on DEBUG_KERNEL and maybe making it an 
umbrella setting to hide details from users who do not want to be 
bothered, i.e. something like:

config MIPS_COMPACT_BRANCHES_OVERRIDE
     bool "Override the toolchain default for compact branch policy"
     depends on DEBUG_KERNEL
     default n
[...]
if MIPS_COMPACT_BRANCHES_OVERRIDE
choice
    prompt "Compact branch policy"
    default MIPS_COMPACT_BRANCHES_OPTIMAL
[...]
endif # MIPS_COMPACT_BRANCHES_OVERRIDE

?

  Maciej
