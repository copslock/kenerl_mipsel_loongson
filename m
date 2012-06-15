Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 11:52:53 +0200 (CEST)
Received: from lebrac.rtp-net.org ([88.191.135.105]:33395 "EHLO
        lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1902755Ab2FOJwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 11:52:46 +0200
Received: by lebrac.rtp-net.org (Postfix, from userid 5001)
        id 35F0329255; Fri, 15 Jun 2012 11:51:01 +0200 (CEST)
Received: from lebrac.rtp-net.org (localhost [IPv6:::1])
        by lebrac.rtp-net.org (Postfix) with ESMTP id 7939C2924C;
        Fri, 15 Jun 2012 11:50:56 +0200 (CEST)
From:   Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 07/14] MIPS: Loongson 3: Add serial port support.
Organization: RtpNet
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-8-git-send-email-chenhc@lemote.com>
Date:   Fri, 15 Jun 2012 11:50:56 +0200
In-Reply-To: <1339747801-28691-8-git-send-email-chenhc@lemote.com> (Huacai
        Chen's message of "Fri, 15 Jun 2012 16:09:54 +0800")
Message-ID: <87aa04x5rz.fsf@lebrac.rtp-net.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 33653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.patard@rtp-net.org
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

Huacai Chen <chenhuacai@gmail.com> writes:

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/mach-loongson/loongson.h |    3 ++
>  arch/mips/loongson/common/serial.c             |   27 ++++++++++++++++++++++++
>  arch/mips/loongson/common/uart_base.c          |    5 ++++
>  3 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index fe7d9a6..16d0924 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -125,6 +125,9 @@ static inline void do_perfcnt_IRQ(void)
>  #define LOONGSON_PCICONFIGBASE	0x00
>  #define LOONGSON_REGBASE	0x100
>  
> +/* Loongson-3A cpu uart */
> +#define LOONGSON_UART_BASE 0x1fe001e0

hm. if it's loongson3 specifique, why is it called like this and not
LOONGSON3_UART_BASE ?
Moreover, from a quick look, why don't you define it later in the file
with the proper macros, say:

#define LOONGSON3_UART_BASE     LOONGSON_REG(LOONGSON_REGBASE + 0xe0)


> +
>  /* PCI Configuration Registers */
>  
>  #define LOONGSON_PCI_REG(x)	LOONGSON_REG(LOONGSON_PCICONFIGBASE + (x))
> diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
> index 7580873..6bfe9dd 100644
> --- a/arch/mips/loongson/common/serial.c
> +++ b/arch/mips/loongson/common/serial.c
> @@ -47,6 +47,33 @@ static struct plat_serial8250_port uart8250_data[][2] = {
>  	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
>  	[MACH_LEMOTE_NAS]               {PORT_M(3), {} },
>  	[MACH_LEMOTE_LL2F]              {PORT(3), {} },
> +	[MACH_LEMOTE_A1004]             {
> +						{
> +							.irq		= MIPS_CPU_IRQ_BASE + 2,
> +							.uartclk	= 33177600,
> +							.iotype		= UPIO_MEM,
> +							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> +						},
> +						{}
> +					},
> +	[MACH_LEMOTE_A1101]             {
> +						{
> +							.irq		= MIPS_CPU_IRQ_BASE + 2,
> +							.uartclk	= 25000000,
> +							.iotype		= UPIO_MEM,
> +							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> +						},
> +						{}
> +					},
> +	[MACH_LEMOTE_A1205]             {
> +						{
> +							.irq		= MIPS_CPU_IRQ_BASE + 2,
> +							.uartclk	= 25000000,
> +							.iotype		= UPIO_MEM,
> +							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> +						},
> +						{}
> +					},
>  	[MACH_LOONGSON_END]             {},

What about modifying PORT_M to makes things clearer ?

Arnaud
