Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2016 00:41:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30096 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993004AbcHCWlRdrtPD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2016 00:41:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C3702F8C336F7;
        Wed,  3 Aug 2016 23:40:56 +0100 (IST)
Received: from [192.168.167.31] (192.168.167.31) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 3 Aug
 2016 23:41:01 +0100
Subject: Re: [PATCH] MIPS: dont specify STACKPROTECTOR in defconfigs
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
References: <20160803190359.6486-1-paul.gortmaker@windriver.com>
CC:     Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   James Hartley <james.hartley@imgtec.com>
Message-ID: <32093d53-44fe-1bde-261b-daf7bab500d9@imgtec.com>
Date:   Wed, 3 Aug 2016 23:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160803190359.6486-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.167.31]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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

Hi Paul,


On 03/08/16 20:03, Paul Gortmaker wrote:
> Only one defconfig has a STACKPROTECTOR value.  And it asks for
> the strong variant, which isn't supported by older toolchains.
>
> Due to the nature of MIPS having more platform specific code than say
> x86, the allyesconfig and allmodconfig aren't as effective for build
> coverage.  So, in addition, I like to use a trivial script to walk all
> the defconfigs and build each one.
>
> However I will get false positives on unsupported stackprotector values
> with an older toolchain like gcc-4.6.3.  As in this instance I am just
> using the compiler as a glorified syntax checker on a machine where I
> build a bunch of other arch for the same reason, there is no real
> motivation to get a newer toolchain for improved optimization etc.
>
> Since there is only one of them, and there is nothing about these
> settings that are board/platform specific, I propose we just eliminate
> the existing instance and take the default.
Are you sure that this is not platform specific - my understanding is
that this can be used to give a small security enhancement, which could
be platform rather than arch specific.  Either way, I don't believe that
pistachio requires this option, so:

Acked-by: James Hartley <james.hartley@imgtec.com>

James.

>
> Cc: James Hartley <james.hartley@imgtec.com>
> Cc: Ionela Voinescu <ionela.voinescu@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/mips/configs/pistachio_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
> index 8b7429127a1d..698631327c8c 100644
> --- a/arch/mips/configs/pistachio_defconfig
> +++ b/arch/mips/configs/pistachio_defconfig
> @@ -29,7 +29,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_EMBEDDED=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=y
> -CONFIG_CC_STACKPROTECTOR_STRONG=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODULE_FORCE_UNLOAD=y
