Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 15:48:16 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:44841 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903750Ab2FMNsI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 15:48:08 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5DDm4WI006829;
        Wed, 13 Jun 2012 14:48:05 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5DDm2du006818;
        Wed, 13 Jun 2012 14:48:02 +0100
Date:   Wed, 13 Jun 2012 14:48:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of
 board_bcm963xx.c
Message-ID: <20120613134801.GA5516@linux-mips.org>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
 <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33622
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jun 12, 2012 at 10:23:38AM +0200, Jonas Gorski wrote:

> board_bcm963xx.c is already large enough.

And the grand cure for that sort of issue is FDT - we by now have built
big deserts of code just registering platform devices like this..  See
John Crispin's Lantiq work or David's Cavium code for FDT examples.

> +int __init bcm63xx_flash_register(void)
> +{
> +	u32 val;
> +
> +	/* read base address of boot chip select (0) */
> +	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
> +	val &= MPI_CSBASE_BASE_MASK;
> +
> +	mtd_resources[0].start = val;
> +	mtd_resources[0].end = 0x1FFFFFFF;
> +
> +	return platform_device_register(&mtd_dev);
> +}
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
> new file mode 100644
> index 0000000..8dcb541
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
> @@ -0,0 +1,6 @@
> +#ifndef __BCM63XX_FLASH_H
> +#define __BCM63XX_FLASH_H
> +
> +int __init bcm63xx_flash_register(void);

Don't use __init in declarations.  It doesn't make any difference to the
compiler but it may cause build errors if <linux/init.h> has not been
included before which this file doesn't.

> +#endif /* __BCM63XX_FLASH_H */

I suggest to make bcm63xx_flash_register an arch_initcall.  It already is
being called indirectly from an bcm63xx_flash_register() so this would
allow making the function static, get rid of bcm63xx_dev_flash.h which
only exists to silence checkpatch warnings and make board_register_devices
a little cleaner.

  Ralf

PS: Don't forget about FDT :-)  Eventually, not necessarily now.
