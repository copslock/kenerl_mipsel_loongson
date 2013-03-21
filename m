Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 06:36:35 +0100 (CET)
Received: from outbound-mail03.westnet.com.au ([203.10.1.244]:19181 "EHLO
        outbound-mail03.westnet.com.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3CUFgdF5nfM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Mar 2013 06:36:33 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAOebSlGVhxBY/2dsb2JhbAANNsU6gW6DGAEBAQQ4QAEQCw4KCRYPCQMCAQIBRQYNAQUCAQGHfQGvL5MmjxAHg0ADqn4
X-IronPort-AV: E=Sophos;i="4.84,883,1355068800"; 
   d="scan'208";a="322847480"
Received: from acc1027289.lnk.telstra.net (HELO [172.16.0.22]) ([149.135.16.88])
  by outbound-mail03.westnet.com.au with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 21 Mar 2013 13:35:19 +0800
Message-ID: <514A9C19.8080008@westnet.com.au>
Date:   Thu, 21 Mar 2013 15:35:21 +1000
From:   Greg Ungerer <gregungerer@westnet.com.au>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Alexandre Courbot <gnurou@gmail.com>
CC:     Mike Frysinger <vapier@gentoo.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [RFC 2/3] m68k: coldfire: use gpiolib
References: <1363527723-32713-1-git-send-email-acourbot@nvidia.com> <1363527723-32713-3-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1363527723-32713-3-git-send-email-acourbot@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregungerer@westnet.com.au
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

On 17/03/13 23:42, Alexandre Courbot wrote:
> Force use of gpiolib for Coldfire, as a step towards the deprecation of
> GENERIC_GPIO.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Greg Ungerer <gerg@uclinux.org>


> ---
>   arch/m68k/Kconfig.cpu | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index b1cfff8..d266787 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -22,8 +22,7 @@ config M68KCLASSIC
>
>   config COLDFIRE
>   	bool "Coldfire CPU family support"
> -	select GENERIC_GPIO
> -	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARCH_REQUIRE_GPIOLIB
>   	select ARCH_HAVE_CUSTOM_GPIO_H
>   	select CPU_HAS_NO_BITFIELDS
>   	select CPU_HAS_NO_MULDIV64
>
