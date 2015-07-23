Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 20:26:00 +0200 (CEST)
Received: from smtp-out-104.synserver.de ([212.40.185.104]:1046 "EHLO
        smtp-out-104.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010800AbbGWSZ7TnInl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 20:25:59 +0200
Received: (qmail 32228 invoked by uid 0); 23 Jul 2015 18:25:58 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 32141
Received: from ppp-188-174-127-204.dynamic.mnet-online.de (HELO ?192.168.178.30?) [188.174.127.204]
  by 217.119.54.81 with AES128-SHA encrypted SMTP; 23 Jul 2015 18:25:58 -0000
Message-ID: <55B131B1.10302@metafoo.de>
Date:   Thu, 23 Jul 2015 20:25:53 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        James Hogan <james.hogan@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Levente Kurusa <levex@linux.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
In-Reply-To: <1437586416-14735-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48406
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

On 07/22/2015 07:33 PM, Alban Bedel wrote:
> diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
> index 54c80d4..3dc500c 100644
> --- a/arch/mips/jz4740/gpio.c
> +++ b/arch/mips/jz4740/gpio.c
> @@ -262,18 +262,6 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
>   }
>   EXPORT_SYMBOL(jz_gpio_port_get_value);
>
> -int gpio_to_irq(unsigned gpio)
> -{
> -	return JZ4740_IRQ_GPIO(0) + gpio;
> -}
> -EXPORT_SYMBOL_GPL(gpio_to_irq);

This need to be hooked up the gpio_to_irq() callback of the gpio_chip struct 
of this driver rather than completely removing it. Otherwise this 
functionality will be broken.

Similar for other platforms which implement the function.

- Lars
