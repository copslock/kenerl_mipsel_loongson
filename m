Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jan 2014 11:47:54 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58941 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378AbaAKKrwgbZt9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Jan 2014 11:47:52 +0100
Message-ID: <52D120C8.8020102@openwrt.org>
Date:   Sat, 11 Jan 2014 11:45:28 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com
Subject: Re: [PATCH 3/3] MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT
 value
References: <1389386114-31834-1-git-send-email-florian@openwrt.org> <1389386114-31834-4-git-send-email-florian@openwrt.org>
In-Reply-To: <1389386114-31834-4-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 10/01/14 21:35, Florian Fainelli wrote:
> Broadcom BCM63xx DSL SoCs have a L1-cache line size of 16 bytes (shift
> value of 4) instead of the currently configured 32 bytes L1-cache line
> size.
>
> Reported-by: Daniel Gonzalez<dgcbueu@gmail.com>
> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> ---
>   arch/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 123f7c0..a3fec87 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -139,6 +139,7 @@ config BCM63XX
>   	select SWAP_IO_SPACE
>   	select ARCH_REQUIRE_GPIOLIB
>   	select HAVE_CLK
> +	select MIPS_L1_CACHE_SHIFT_4
>   	help
>   	 Support for BCM63XX based boards
>


Hi Florian,

why is this not part of 1/3

     John
