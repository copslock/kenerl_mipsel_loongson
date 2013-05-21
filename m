Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 00:05:11 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:50419 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835027Ab3EUWFKLf5Lp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 00:05:10 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 3E64D21B917;
        Wed, 22 May 2013 01:05:06 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id PKj0C0XYFF9p; Wed, 22 May 2013 01:05:01 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 3FEF35BC005;
        Wed, 22 May 2013 01:05:00 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Wed, 22 May 2013 01:04:58 +0300
Date:   Wed, 22 May 2013 01:04:57 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        spi-devel-general@lists.sourceforge.net,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Message-ID: <20130521220457.GF31836@blackmetal.musicnaut.iki.fi>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36514
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

What about OCTEON_WDT, should it be changed too:

        tristate "Cavium OCTEON SOC family Watchdog Timer"
        depends on CPU_CAVIUM_OCTEON

On Mon, May 20, 2013 at 03:19:38PM -0700, David Daney wrote:
>  config OCTEON_MGMT_ETHERNET
>  	tristate "Octeon Management port ethernet driver (CN5XXX, CN6XXX)"
> -	depends on  CPU_CAVIUM_OCTEON
> +	depends on  CAVIUM_OCTEON_SOC

>  config MDIO_OCTEON
>  	tristate "Support for MDIO buses on Octeon SOCs"
> -	depends on  CPU_CAVIUM_OCTEON
> +	depends on  CAVIUM_OCTEON_SOC

>  config USB_OCTEON_OHCI
>  	bool "Octeon on-chip OHCI support"
> -	depends on CPU_CAVIUM_OCTEON
> +	depends on  CAVIUM_OCTEON_SOC

Just a minor comment, here the extra whitespace after "depends on"
could be eliminated.

A.
