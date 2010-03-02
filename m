Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2010 14:39:04 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:35056 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491138Ab0CBNjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Mar 2010 14:39:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 20B413418153;
        Tue,  2 Mar 2010 14:38:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CZNKzExolfNX; Tue,  2 Mar 2010 14:38:55 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 8562F341814A;
        Tue,  2 Mar 2010 14:38:55 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 6/7] MIPS: bcm63xx: call board_register_device from device_initcall()
Date:   Tue, 2 Mar 2010 14:38:47 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr> <1264872898-28149-7-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1264872898-28149-7-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003021438.47105.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Hi Maxime,

On Saturday 30 January 2010 18:34:57 Maxime Bizon wrote:
> Some device registration (eg leds), expect subsystem initcall to be
> run first, so move board device registration to device_initcall().
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  arch/mips/bcm63xx/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
> index d005659..04a3499 100644
> --- a/arch/mips/bcm63xx/setup.c
> +++ b/arch/mips/bcm63xx/setup.c
> @@ -124,4 +124,4 @@ int __init bcm63xx_register_devices(void)
>  	return board_register_devices();
>  }
> 
> -arch_initcall(bcm63xx_register_devices);
> +device_initcall(bcm63xx_register_devices);

This breaks the fallback SPROM registration, that one needs to be set before
the PCI subsystem is intialized, otherwise b43 gets an empty WLAN MAC
address. This was the reason to move bcm63xx_register_devices to
the arch_initcall level in the first place.

Let's use the first stage board callback which also has to be called prior to
PCI initialization.

From: Florian Fainelli <ffainelli@freebox.fr>
Subject: [PATCH] bcm63xx: register SSB SPROM fallback in board's first stage callback

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 90faa37..f7e0be1 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -676,6 +676,17 @@ void __init board_prom_init(void)
 	}
 
 	bcm_gpio_writel(val, GPIO_MODE_REG);
+
+	/* Generate MAC address for WLAN and
+	 * register our SPROM */
+#ifdef CONFIG_SSB_PCIHOST
+	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
+		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
+			printk(KERN_ERR "failed to register fallback SPROM\n");
+	}
+#endif
 }
 
 /*
@@ -835,17 +846,6 @@ int __init board_register_devices(void)
 	if (board.has_dsp)
 		bcm63xx_dsp_register(&board.dsp);
 
-	/* Generate MAC address for WLAN and
-	 * register our SPROM */
-#ifdef CONFIG_SSB_PCIHOST
-	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
-		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
-		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
-		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
-			printk(KERN_ERR "failed to register fallback SPROM\n");
-	}
-#endif
-
 	/* read base address of boot chip select (0) */
 	if (BCMCPU_IS_6345())
 		val = 0x1fc00000;
