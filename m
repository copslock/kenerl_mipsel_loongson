Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:47:42 +0100 (CET)
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1077 "EHLO
        smtp-out-221.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012831AbcBPPrlACRgn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:47:41 +0100
Received: (qmail 6700 invoked by uid 0); 16 Feb 2016 15:47:39 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 6678
Received: from p4fde6749.dip0.t-ipconnect.de (HELO ?192.168.2.127?) [79.222.103.73]
  by 217.119.54.73 with AES128-SHA encrypted SMTP; 16 Feb 2016 15:47:39 -0000
Subject: Re: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "# v4 . 3+" <stable@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56C34499.5010704@metafoo.de>
Date:   Tue, 16 Feb 2016 16:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52091
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

On 02/16/2016 04:40 PM, Arnd Bergmann wrote:
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

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

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
> 
