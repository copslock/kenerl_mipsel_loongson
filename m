Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2012 01:40:05 +0100 (CET)
Received: from cassarossa.samfundet.no ([129.241.93.19]:43208 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826031Ab2KGAkDlPwu0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2012 01:40:03 +0100
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.72)
        (envelope-from <egtvedt@samfundet.no>)
        id 1TVtfI-000406-ER; Wed, 07 Nov 2012 01:38:44 +0100
Date:   Wed, 7 Nov 2012 01:38:44 +0100
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Michal Nazarewicz <mpn@google.com>
Cc:     Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/6] arch: Change defconfigs to point to
 g_mass_storage.
Message-ID: <20121107003844.GA8837@samfundet.no>
References: <cover.1352237765.git.mina86@mina86.com>
 <007d0b4e8872b877076918bd3268832e9ea9d667.1352237765.git.mina86@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d0b4e8872b877076918bd3268832e9ea9d667.1352237765.git.mina86@mina86.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 34914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Tue 06 Nov 2012 22:52:35 +0100 or thereabout, Michal Nazarewicz wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
> 
> The File-backed Storage Gadget (g_file_storage) is being removed, since
> it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> changes defconfigs point to the new gadget.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>  (fort AT91)
> Acked-by: Tony Lindgren <tony@atomide.com>  (for omap1)
> ---
>  arch/arm/configs/afeb9260_defconfig                |    2 +-
>  arch/arm/configs/at91sam9260_defconfig             |    2 +-
>  arch/arm/configs/at91sam9261_defconfig             |    2 +-
>  arch/arm/configs/at91sam9263_defconfig             |    2 +-
>  arch/arm/configs/at91sam9g20_defconfig             |    2 +-
>  arch/arm/configs/corgi_defconfig                   |    2 +-
>  arch/arm/configs/davinci_all_defconfig             |    2 +-
>  arch/arm/configs/h7202_defconfig                   |    3 +--
>  arch/arm/configs/magician_defconfig                |    2 +-
>  arch/arm/configs/mini2440_defconfig                |    2 +-
>  arch/arm/configs/omap1_defconfig                   |    3 +--
>  arch/arm/configs/prima2_defconfig                  |    1 -
>  arch/arm/configs/spitz_defconfig                   |    2 +-
>  arch/arm/configs/stamp9g20_defconfig               |    2 +-
>  arch/arm/configs/viper_defconfig                   |    2 +-
>  arch/arm/configs/zeus_defconfig                    |    2 +-
>  arch/avr32/configs/atngw100_defconfig              |    2 +-
>  arch/avr32/configs/atngw100_evklcd100_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_evklcd101_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig         |    2 +-
>  arch/avr32/configs/atngw100mkii_defconfig          |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd100_defconfig |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd101_defconfig |    2 +-
>  arch/avr32/configs/atstk1002_defconfig             |    2 +-
>  arch/avr32/configs/atstk1003_defconfig             |    2 +-
>  arch/avr32/configs/atstk1004_defconfig             |    2 +-
>  arch/avr32/configs/atstk1006_defconfig             |    2 +-
>  arch/avr32/configs/favr-32_defconfig               |    2 +-
>  arch/avr32/configs/hammerhead_defconfig            |    2 +-

For all the AVR32 related changes +1 (-:

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

IMHO this patch is trivial and needed since you change all the users of a
certain symbol. Thanks for doing the maintenance.

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
