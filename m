Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 09:27:57 +0200 (CEST)
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:32791 "EHLO
        lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008504AbbDFH14VGD1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 09:27:56 +0200
Received: from [192.168.10.110] ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id CXTn1q00546mmVf01XTo69; Mon, 06 Apr 2015 09:27:50 +0200
Message-ID: <1428305269.634.43.camel@x220>
Subject: Re: [PATCH] mfd: Add support for CPLD chip on Mikrotik RB4xx boards
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, sameo@linux.intel.com, lee.jones@linaro.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Apr 2015 09:27:49 +0200
In-Reply-To: <1428285076-14269-1-git-send-email-bert@biot.com>
References: <1428285076-14269-1-git-send-email-bert@biot.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Mon, 2015-04-06 at 03:51 +0200, Bert Vermeulen wrote:
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

> +config MFD_RB4XX_CPLD
> +	tristate "MikroTik RB4XX CPLD driver"
> +	depends on ATH79 && SPI_RB4XX

I noticed you also submitted a patch that adds the Kconfig symbol
SPI_RB4XX (https://lkml.org/lkml/2015/4/5/167 ). That symbol's entry
contains
	depends on SPI_MASTER && ATH79

So I think the dependency here can be simplified to
	depends on SPI_RB4XX

Would that work too?

> +	help
> +	  Driver for the CPLD chip present on MikroTik RB4xx boards.
> +	  It controls CPU access to NAND flash and user LEDs.

> --- /dev/null
> +++ b/drivers/mfd/rb4xx-cpld.c

> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/bitops.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>

You really wanted to make sure <linux/module.h> was included, didn't
you?

Thanks,


Paul Bolle
