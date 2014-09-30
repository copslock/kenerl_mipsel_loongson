Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 19:30:29 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:38148 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010116AbaI3RaY3X4HL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 19:30:24 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1XZ1FY-0007PH-K5; Tue, 30 Sep 2014 13:30:08 -0400
Received: from linville-x1.hq.tuxdriver.com (localhost.localdomain [127.0.0.1])
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.6) with ESMTP id s8UHKmWA021763;
        Tue, 30 Sep 2014 13:20:48 -0400
Received: (from linville@localhost)
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.8/Submit) id s8UHKjnv021762;
        Tue, 30 Sep 2014 13:20:45 -0400
Date:   Tue, 30 Sep 2014 13:20:45 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@venema.h4ckr.net
Subject: Re: [PATCH 15/16] ath5k: update dependencies
Message-ID: <20140930172044.GE11919@tuxdriver.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-16-git-send-email-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411929195-23775-16-git-send-email-ryazanov.s.a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
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

This patch does not seem to apply to wireless-next.  What tree is it
based upon?

John

On Sun, Sep 28, 2014 at 10:33:14PM +0400, Sergey Ryazanov wrote:
> - Use config symbol defined in the driver instead of arch specific one for
>   conditional compilation.
> - Rename the ATHEROS_AR231X config symbol to AR231X.
> - Some of AR231x SoCs (e.g. AR2315) have PCI bus support, so remove !PCI
>   dependency, which block AHB support build.
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath5k-devel@lists.ath5k.org
> ---
> 
> Changes since RFC:
>   - merge together patches that update ath5k dependencies
> 
>  drivers/net/wireless/ath/ath5k/Kconfig | 10 +++++-----
>  drivers/net/wireless/ath/ath5k/ath5k.h |  2 +-
>  drivers/net/wireless/ath/ath5k/base.c  |  4 ++--
>  drivers/net/wireless/ath/ath5k/led.c   |  4 ++--
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/Kconfig b/drivers/net/wireless/ath/ath5k/Kconfig
> index c9f81a3..2b2a399 100644
> --- a/drivers/net/wireless/ath/ath5k/Kconfig
> +++ b/drivers/net/wireless/ath/ath5k/Kconfig
> @@ -1,13 +1,13 @@
>  config ATH5K
>  	tristate "Atheros 5xxx wireless cards support"
> -	depends on (PCI || ATHEROS_AR231X) && MAC80211
> +	depends on (PCI || AR231X) && MAC80211
>  	select ATH_COMMON
>  	select MAC80211_LEDS
>  	select LEDS_CLASS
>  	select NEW_LEDS
>  	select AVERAGE
> -	select ATH5K_AHB if (ATHEROS_AR231X && !PCI)
> -	select ATH5K_PCI if (!ATHEROS_AR231X && PCI)
> +	select ATH5K_AHB if AR231X
> +	select ATH5K_PCI if !AR231X
>  	---help---
>  	  This module adds support for wireless adapters based on
>  	  Atheros 5xxx chipset.
> @@ -54,14 +54,14 @@ config ATH5K_TRACER
>  
>  config ATH5K_AHB
>  	bool "Atheros 5xxx AHB bus support"
> -	depends on (ATHEROS_AR231X && !PCI)
> +	depends on AR231X
>  	---help---
>  	  This adds support for WiSoC type chipsets of the 5xxx Atheros
>  	  family.
>  
>  config ATH5K_PCI
>  	bool "Atheros 5xxx PCI bus support"
> -	depends on (!ATHEROS_AR231X && PCI)
> +	depends on (!AR231X && PCI)
>  	---help---
>  	  This adds support for PCI type chipsets of the 5xxx Atheros
>  	  family.
> diff --git a/drivers/net/wireless/ath/ath5k/ath5k.h b/drivers/net/wireless/ath/ath5k/ath5k.h
> index 85316bb..1ed7a88 100644
> --- a/drivers/net/wireless/ath/ath5k/ath5k.h
> +++ b/drivers/net/wireless/ath/ath5k/ath5k.h
> @@ -1647,7 +1647,7 @@ static inline struct ath_regulatory *ath5k_hw_regulatory(struct ath5k_hw *ah)
>  	return &(ath5k_hw_common(ah)->regulatory);
>  }
>  
> -#ifdef CONFIG_ATHEROS_AR231X
> +#ifdef CONFIG_ATH5K_AHB
>  #define AR5K_AR2315_PCI_BASE	((void __iomem *)0xb0100000)
>  
>  static inline void __iomem *ath5k_ahb_reg(struct ath5k_hw *ah, u16 reg)
> diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
> index 8ad2550..dd42487 100644
> --- a/drivers/net/wireless/ath/ath5k/base.c
> +++ b/drivers/net/wireless/ath/ath5k/base.c
> @@ -99,7 +99,7 @@ static int ath5k_reset(struct ath5k_hw *ah, struct ieee80211_channel *chan,
>  
>  /* Known SREVs */
>  static const struct ath5k_srev_name srev_names[] = {
> -#ifdef CONFIG_ATHEROS_AR231X
> +#ifdef CONFIG_ATH5K_AHB
>  	{ "5312",	AR5K_VERSION_MAC,	AR5K_SREV_AR5312_R2 },
>  	{ "5312",	AR5K_VERSION_MAC,	AR5K_SREV_AR5312_R7 },
>  	{ "2313",	AR5K_VERSION_MAC,	AR5K_SREV_AR2313_R8 },
> @@ -142,7 +142,7 @@ static const struct ath5k_srev_name srev_names[] = {
>  	{ "5413",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5413 },
>  	{ "5424",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5424 },
>  	{ "5133",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5133 },
> -#ifdef CONFIG_ATHEROS_AR231X
> +#ifdef CONFIG_ATH5K_AHB
>  	{ "2316",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_2316 },
>  	{ "2317",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_2317 },
>  #endif
> diff --git a/drivers/net/wireless/ath/ath5k/led.c b/drivers/net/wireless/ath/ath5k/led.c
> index 48a6a69b..c730677 100644
> --- a/drivers/net/wireless/ath/ath5k/led.c
> +++ b/drivers/net/wireless/ath/ath5k/led.c
> @@ -162,7 +162,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
>  {
>  	int ret = 0;
>  	struct ieee80211_hw *hw = ah->hw;
> -#ifndef CONFIG_ATHEROS_AR231X
> +#ifndef CONFIG_ATH5K_AHB
>  	struct pci_dev *pdev = ah->pdev;
>  #endif
>  	char name[ATH5K_LED_MAX_NAME_LEN + 1];
> @@ -171,7 +171,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
>  	if (!ah->pdev)
>  		return 0;
>  
> -#ifdef CONFIG_ATHEROS_AR231X
> +#ifdef CONFIG_ATH5K_AHB
>  	match = NULL;
>  #else
>  	match = pci_match_id(&ath5k_led_devices[0], pdev);
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
