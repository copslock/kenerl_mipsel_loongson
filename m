Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 21:36:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50629 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903480Ab2HPTgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 21:36:22 +0200
Message-ID: <502D4B70.4010509@phrozen.org>
Date:   Thu, 16 Aug 2012 21:35:12 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de> <1345132801-8430-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1345132801-8430-4-git-send-email-hauke@hauke-m.de>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 16/08/12 18:00, Hauke Mehrtens wrote:
> int gpio_get_value(unsigned gpio)
> +{
> +	if (gpio < bcm47xx_gpio_count)
> +		return bcm47xx_gpio_in(1 << gpio);
> +
> +	return __gpio_get_value(gpio);
> +}
> +EXPORT_SYMBOL(gpio_get_value);

Hi,

You are using a gpio_chip. simply doing this

#define gpio_get_value __gpio_get_value

inside your arch/mips/include/asm/mach-bcm47xx/gpio.h will be enough.
__gpio_get_value() will then automatically find and use
bcm47xx_gpio_get_value() via the gpio_chip.

John
