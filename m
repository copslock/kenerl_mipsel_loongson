Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2014 13:08:18 +0100 (CET)
Received: from smtp-out-081.synserver.de ([212.40.185.81]:1078 "EHLO
        smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6824818AbaBKMIQWe5a2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Feb 2014 13:08:16 +0100
Received: (qmail 22203 invoked by uid 0); 11 Feb 2014 12:08:08 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 22149
Received: from p4fe61ed3.dip0.t-ipconnect.de (HELO ?192.168.0.176?) [79.230.30.211]
  by 217.119.54.73 with AES256-SHA encrypted SMTP; 11 Feb 2014 12:08:07 -0000
Message-ID: <52FA12B2.5090906@metafoo.de>
Date:   Tue, 11 Feb 2014 13:08:18 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Jingoo Han <jg1.han@samsung.com>
CC:     'Ralf Baechle' <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM
References: <003901cf25fc$73002790$590076b0$%han@samsung.com> <003d01cf25fd$309c58a0$91d509e0$%han@samsung.com>
In-Reply-To: <003d01cf25fd$309c58a0$91d509e0$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 02/10/2014 02:12 AM, Jingoo Han wrote:
> The HAVE_PWM symbol is only for legacy platforms that provide
> the PWM API without using the generic framework. The jz4740
> platform uses the generic PWM framework, after the commit "f6b8a57
> pwm: Add Ingenic JZ4740 support".
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   arch/mips/Kconfig |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index dcae3a7..d132603 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -235,7 +235,6 @@ config MACH_JZ4740
>   	select IRQ_CPU
>   	select ARCH_REQUIRE_GPIOLIB
>   	select SYS_HAS_EARLY_PRINTK
> -	select HAVE_PWM
>   	select HAVE_CLK
>   	select GENERIC_IRQ_CHIP
>
>
