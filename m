Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2018 13:30:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994668AbeA2MaetGBip (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jan 2018 13:30:34 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119E120C48;
        Mon, 29 Jan 2018 12:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119E120C48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 29 Jan 2018 12:30:19 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
Message-ID: <20180129123018.GB7637@saruman>
References: <1517225205-10374-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517225205-10374-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

On Mon, Jan 29, 2018 at 11:26:45AM +0000, Matt Redfearn wrote:
> When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
> added board support for the RBTX4939, it added a call to
> led_classdev_register even if the LED class is built as a module.
> Built-in arch code cannot call module code directly like this. Commit
> b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
> changed the inclusion of this code to a single check that
> CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
> remains.
> This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=y
> is set:
> 
> arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
> setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_register'
> make: *** [Makefile:999: vmlinux] Error 1
> 
> Fix this by using the IS_BUILTIN() macro instead.
> 
> Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
> Fixes: b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro")

Well, I don't think the latter did anything wrong or made anything
worse, so shouldn't really be implicated by "Fixes:", but other than
that it looks like a reasonable workaround (even if ideally the
driverlet would be separate from the device instantiation):

Reviewed-by: James Hogan <jhogan@kernel.org>

Thanks
James

> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> ---
> 
>  arch/mips/txx9/rbtx4939/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
> index 8b937300fb7f..fd26fadc8617 100644
> --- a/arch/mips/txx9/rbtx4939/setup.c
> +++ b/arch/mips/txx9/rbtx4939/setup.c
> @@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
>  
>  #define RBTX4939_MAX_7SEGLEDS	8
>  
> -#if IS_ENABLED(CONFIG_LEDS_CLASS)
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS)
>  static u8 led_val[RBTX4939_MAX_7SEGLEDS];
>  struct rbtx4939_led_data {
>  	struct led_classdev cdev;
> @@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(void)
>  
>  static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
>  {
> -#if IS_ENABLED(CONFIG_LEDS_CLASS)
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS)
>  	unsigned long flags;
>  	local_irq_save(flags);
>  	/* bit7: reserved for LED class */
> -- 
> 2.7.4
> 
