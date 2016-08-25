Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 20:25:01 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57327 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992147AbcHYSYzIlC-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 20:24:55 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id AE7641A26F9;
        Thu, 25 Aug 2016 21:24:53 +0300 (EEST)
Date:   Thu, 25 Aug 2016 21:24:53 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [BISECTED REGRESSION] v4.8-rc: gpio-leds broken on OCTEON
Message-ID: <20160825182453.GF12169@raspberrypi.musicnaut.iki.fi>
References: <20160823203605.GA12169@raspberrypi.musicnaut.iki.fi>
 <57BDCE58.20200@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BDCE58.20200@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54754
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

On Wed, Aug 24, 2016 at 11:42:00AM -0500, Steven J. Hill wrote:
> It is actually two patches that cause the breakage. The other is:
> 
>    commit e55aeb6ba4e8cc3549bff1e75ea1d029324bce21
>    of/irq: Mark interrupt controllers as populated before initialisation
> 
> I needed to revert both of these in order to get MMC working on our 71xx and
> 78xx boards. For our MMC, I got error messages from the MMC core of "Invalid
> POWER GPIO" until I applied the second patch. I will have a fix worthy of
> upstreaming today which will be posted today.

The below change works for me...

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 5a9b87b..5fd57c2 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1618,6 +1618,7 @@ static int __init octeon_irq_init_gpio(
 		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
 		return -ENOMEM;
 	}
+	of_node_clear_flag(gpio_node, OF_POPULATED);
 
 	return 0;
 }

A.
