Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 17:06:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58828 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012853AbcBPQGSAcuon (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Feb 2016 17:06:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1GG6EpF000313;
        Tue, 16 Feb 2016 17:06:14 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1GG69iw000311;
        Tue, 16 Feb 2016 17:06:09 +0100
Date:   Tue, 16 Feb 2016 17:06:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org, "# v4 . 3+" <stable@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
Message-ID: <20160216160609.GA15268@linux-mips.org>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Feb 16, 2016 at 04:40:34PM +0100, Arnd Bergmann wrote:
> Date:   Tue, 16 Feb 2016 16:40:34 +0100
> From: Arnd Bergmann <arnd@arndb.de>
> To: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
>  Russell King <rmk+kernel@arm.linux.org.uk>, Bjorn Helgaas
>  <bhelgaas@google.com>, Alexandre Courbot <gnurou@gmail.com>,
>  linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
>  Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>,
>  linux-mips@linux-mips.org, "# v4 . 3+" <stable@vger.kernel.org>, Alban
>  Bedel <albeu@free.fr>, Thomas Gleixner <tglx@linutronix.de>, Paul Burton
>  <paul.burton@imgtec.com>
> Subject: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
> 
> gpiolib has removed the irq_to_gpio() API several years ago,
> but the global header still provided a non-working stub.
> 
> With a MIPS-wide change to use the generic header file, the jz4740
> platform is now using the wrong stub implementation of irq_to_gpio(),
> which cannot work.
> 
> This uses an open-coded implementation in the only line it
> is used in.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org> # v4.3+
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h").
> ---
>  arch/mips/jz4740/gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
> index 8c6d76c9b2d6..d9907e57e9b9 100644
> --- a/arch/mips/jz4740/gpio.c
> +++ b/arch/mips/jz4740/gpio.c
> @@ -270,7 +270,7 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
>  }
>  EXPORT_SYMBOL(jz_gpio_port_get_value);
>  
> -#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
> +#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
>  
>  static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
>  {

I've already committed an identical fix locally.

  Ralf
