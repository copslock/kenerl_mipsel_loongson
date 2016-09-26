Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2016 22:41:09 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41032 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992043AbcIZUlCUn3M7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Sep 2016 22:41:02 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-134-48-nat.elisa-mobile.fi [85.76.134.48])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 774884005;
        Mon, 26 Sep 2016 23:41:01 +0300 (EEST)
Date:   Mon, 26 Sep 2016 23:41:01 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH v2] MIPS: Octeon: mark GPIO controller node not populated
 after IRQ init.
Message-ID: <20160926204101.GB19498@raspberrypi.musicnaut.iki.fi>
References: <57C0922C.40907@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57C0922C.40907@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Fri, Aug 26, 2016 at 02:02:04PM -0500, Steven J. Hill wrote:
> We clear the OF_POPULATED flag for the GPIO controller node on Octeon
> processors. Otherwise, none of the devices hanging on the GPIO lines
> are probed. The 'gpio-leds' driver on OCTEON failed to probe in addition
> to other devices on Cavium 71xx and 78xx development boards.
> 
> Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Ralf, I think this patch should be still included in v4.8 final.

Thanks,

A.

> ---
>  arch/mips/cavium-octeon/octeon-irq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 5a9b87b..c1eb1ff 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1619,6 +1619,12 @@ static int __init octeon_irq_init_gpio(
>  		return -ENOMEM;
>  	}
> 
> +	/*
> +	 * Clear the OF_POPULATED flag that was set by of_irq_init()
> +	 * so that all GPIO devices will be probed.
> +	 */
> +	of_node_clear_flag(gpio_node, OF_POPULATED);
> +
>  	return 0;
>  }
>  /*
> -- 
> 1.9.1
> 
> 
