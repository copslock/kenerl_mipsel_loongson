Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 10:01:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27988 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014837AbbDAIBzQbtuG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 10:01:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E16B7E1F325C3;
        Wed,  1 Apr 2015 09:01:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Apr 2015 09:01:49 +0100
Received: from [192.168.154.138] (192.168.154.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 1 Apr
 2015 09:01:49 +0100
Message-ID: <551BA5ED.7060106@imgtec.com>
Date:   Wed, 1 Apr 2015 09:01:49 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: MIPS: Select CONFIG_MIPS_O32_FP64_SUPPORT if 64bit kernel
 and o32
References: <551B9513.5020606@gentoo.org>
In-Reply-To: <551B9513.5020606@gentoo.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 04/01/2015 07:49 AM, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> Select CONFIG_MIPS_O32_FP64_SUPPORT by default if CONFIG_64BIT and
> CONFIG_MIPS32_O32 are selected.  This avoids breaking things when
> booting into an o32 userland under a 64bit kernel.  Symptoms of not
> selecting CONFIG_MIPS_O32_FP64_SUPPORT can include OpenSSH claiming that
> the "PRNG is not seeded" and Python programs to fail with either a
> SIGSEGV or errors regarding "float NaN".
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> mips-fix-o32-fp64-on-mips64.patch
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 294f82e..1b826ed 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2736,6 +2736,7 @@ config MIPS32_O32
>  	select COMPAT
>  	select MIPS32_COMPAT
>  	select SYSVIPC_COMPAT if SYSVIPC
> +	select MIPS_O32_FP64_SUPPORT if 64BIT
>  	help
>  	  Select this option if you want to run o32 binaries.  These are pure
>  	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
> 
> 
Hi,

No this is not a good solution. This has already been fixed in
mips-for-linux-next and might make it to 4.0 in time

https://patchwork.linux-mips.org/patch/9344/

can you try that patch instead?

-- 
markos
