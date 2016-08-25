Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 00:40:50 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59563 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992249AbcHYWklI2XEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 00:40:41 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id AC1EB409A;
        Fri, 26 Aug 2016 01:40:34 +0300 (EEST)
Date:   Fri, 26 Aug 2016 01:40:33 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        Rob Herring <robh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, David Daney <david.daney@cavium.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: mark GPIO controller node not populated
 IRQ, init.
Message-ID: <20160825224033.GH12169@raspberrypi.musicnaut.iki.fi>
References: <422712ab-4b0d-2b6d-4600-b917c2d327a9@cavium.com>
 <57BF6F47.4030803@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BF6F47.4030803@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54760
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

On Thu, Aug 25, 2016 at 03:20:55PM -0700, David Daney wrote:
> On 08/25/2016 02:22 PM, Steven J. Hill wrote:
> >We clear the OF_POPULATED flag for the GPIO controller node, otherwise
> >the GPIO lines used by the MMC driver are never probed.

Please also mention that gpio-leds failed to probe.

> >Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
> >Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> >---
> >  arch/mips/cavium-octeon/octeon-irq.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> >diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> >index 5a9b87b..41d12d4 100644
> >--- a/arch/mips/cavium-octeon/octeon-irq.c
> >+++ b/arch/mips/cavium-octeon/octeon-irq.c
> >@@ -1619,6 +1619,13 @@ static int __init octeon_irq_init_gpio(
> >  		return -ENOMEM;
> >  	}
> >
> >+	/*
> >+	 * Clear the OF_POPULATED flag that was set above for the
> 
> Can we s/above/in of_irq_init()/ to be less ambiguous?
> 
> >+	 * GPIO controller so that the lines used by the MMC driver
> 
> I suspect that it is not just MMC that was broken by commit 15cc2ed6dcf9.
> Can we get a real description of exactly which kernel facilities are
> impacted?  Is it all GPIO, or what?

For me it fixes gpio-leds breakage, so I think it's all GPIO. Referring
to MMC driver is not appropriate anyway as the OCTEON MMC is not yet
merged. :-)

> >+	 * will not be skipped.
> >+	 */
> >+	of_node_clear_flag(gpio_node, OF_POPULATED);
> >+
> >  	return 0;

For this actual code change, you can add:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
