Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:18:59 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:13152 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865306Ab3HHLS43js7G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:18:56 +0200
Message-ID: <52037E98.2040902@imgtec.com>
Date:   Thu, 8 Aug 2013 12:18:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: ralink: add support for periodic timer irq
References: <1375959950-31024-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375959950-31024-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_08_12_18_50
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi John,

On 08/08/13 12:05, John Crispin wrote:
> +static int rt_timer_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct rt_timer *rt;
> +	struct clk *clk;
> +
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource found\n");
> +		return -EINVAL;
> +	}

devm_request_and_ioremap already error checks res so you don't need to
check it yourself (see devm_request_and_ioremap kerneldoc comment in
lib/devres.c).

> +
> +	rt = devm_kzalloc(&pdev->dev, sizeof(*rt), GFP_KERNEL);
> +	if (!rt) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	rt->irq = platform_get_irq(pdev, 0);
> +	if (!rt->irq) {
> +		dev_err(&pdev->dev, "failed to load irq\n");
> +		return -ENOENT;
> +	}
> +
> +	rt->membase = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!rt->membase) {
> +		dev_err(&pdev->dev, "failed to ioremap\n");
> +		return -ENOMEM;
> +	}

Cheers
James
