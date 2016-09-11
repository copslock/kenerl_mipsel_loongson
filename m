Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2016 14:41:52 +0200 (CEST)
Received: from basicbox7.server-home.net ([195.137.212.29]:56245 "EHLO
        basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcIKMlpwnui2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2016 14:41:45 +0200
Received: from ankhmorpork.fritz.box (ip4d15e046.dynamic.kabel-deutschland.de [77.21.224.70])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by basicbox7.server-home.net (Postfix) with ESMTPSA id 2E04C5EEF2A;
        Sun, 11 Sep 2016 14:41:40 +0200 (CEST)
Subject: Re: [BISECTED REGRESSION] v4.8-rc: gpio-leds broken on OCTEON
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
References: <20160823203605.GA12169@raspberrypi.musicnaut.iki.fi>
 <57BDCE58.20200@cavium.com>
 <20160825182453.GF12169@raspberrypi.musicnaut.iki.fi>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <dc278c85-5ebd-7b91-2524-8c3549d1ee0c@leemhuis.info>
Date:   Sun, 11 Sep 2016 14:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160825182453.GF12169@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <regressions@leemhuis.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: regressions@leemhuis.info
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

Hi! On 25.08.2016 20:24, Aaro Koskinen wrote:
> On Wed, Aug 24, 2016 at 11:42:00AM -0500, Steven J. Hill wrote:
>> It is actually two patches that cause the breakage. The other is:
>>    commit e55aeb6ba4e8cc3549bff1e75ea1d029324bce21
>>    of/irq: Mark interrupt controllers as populated before initialisation
>> I needed to revert both of these in order to get MMC working on our 71xx and
>> 78xx boards. For our MMC, I got error messages from the MMC core of "Invalid
>> POWER GPIO" until I applied the second patch. I will have a fix worthy of
>> upstreaming today which will be posted today.
> 
> The below change works for me...
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 5a9b87b..5fd57c2 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1618,6 +1618,7 @@ static int __init octeon_irq_init_gpio(
>  		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
>  		return -ENOMEM;
>  	}
> +	of_node_clear_flag(gpio_node, OF_POPULATED);
>  
>  	return 0;
>  }

This afaics wasn't merged and the discussion looks stalled. Was this
issue discussed elsewhere or even fixed in between? Just asking, because
this issue is on the list of regressions for 4.8.

Ciao, Thorsten
