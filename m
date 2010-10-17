Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 18:59:43 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:45302 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491169Ab0JQQ7W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 18:59:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id F326912AF9D;
        Sun, 17 Oct 2010 18:59:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CxXpqSaZ+MC9; Sun, 17 Oct 2010 18:59:15 +0200 (CEST)
Received: from lenovo.localnet (gob75-6-82-236-225-16.fbx.proxad.net [82.236.225.16])
        by zmc.proxad.net (Postfix) with ESMTPSA id 59DD812AF9B;
        Sun, 17 Oct 2010 18:59:15 +0200 (CEST)
From:   Florian Fainelli <ffainelli@freebox.fr>
To:     Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/9] MIPS: Add BMIPS processor types to Kconfig
Date:   Sun, 17 Oct 2010 19:01:04 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc6-amd64; KDE/4.4.5; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <17ebecce124618ddf83ec6fe8e526f93@localhost> <adc90cbb99148b1f3a1e880caba50fa4@localhost>
In-Reply-To: <adc90cbb99148b1f3a1e880caba50fa4@localhost>
Organization: Freebox
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201010171901.04581.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Hello Kevin,

Le Saturday 16 October 2010 23:22:31, Kevin Cernekee a écrit :
> Add processor feature definitions for BMIPS3300, BMIPS4350, BMIPS4380,
> and BMIPS5000.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  arch/mips/Kconfig |   63
> +++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 63
> insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5526faa..1403926 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1332,6 +1332,57 @@ config CPU_CAVIUM_OCTEON
>  	  can have up to 16 Mips64v2 cores and 8 integrated gigabit ethernets.
>  	  Full details can be found at http://www.caviumnetworks.com.
> 
> +config CPU_BMIPS3300
> +	bool "BMIPS3300"
> +	depends on SYS_HAS_CPU_BMIPS3300
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select SWAP_IO_SPACE
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select WEAK_ORDERING
> +	help
> +	  Broadcom BMIPS3300 processors.
> +
> +config CPU_BMIPS4350
> +	bool "BMIPS4350"
> +	depends on SYS_HAS_CPU_BMIPS4350
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select SWAP_IO_SPACE
> +	select SYS_SUPPORTS_SMP
> +	select SYS_SUPPORTS_HOTPLUG_CPU
> +	select WEAK_ORDERING
> +	help
> +	  Broadcom BMIPS4350 processors.

May I suggest to include the marketed name "Viper" here to help people know where this CPU block can be found?

> +
> +config CPU_BMIPS4380
> +	bool "BMIPS4380"
> +	depends on SYS_HAS_CPU_BMIPS4380
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select SWAP_IO_SPACE
> +	select SYS_SUPPORTS_SMP
> +	select SYS_SUPPORTS_HOTPLUG_CPU
> +	select WEAK_ORDERING
> +	help
> +	  Broadcom BMIPS4380 processors.
> +
> +config CPU_BMIPS5000
> +	bool "BMIPS5000"
> +	depends on SYS_HAS_CPU_BMIPS5000
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select SWAP_IO_SPACE
> +	select SYS_SUPPORTS_SMP
> +	select SYS_SUPPORTS_HOTPLUG_CPU
> +	select WEAK_ORDERING
> +	help
> +	  Broadcom BMIPS5000 processors.
> +
>  endchoice
> 
>  if CPU_LOONGSON2F
> @@ -1450,6 +1501,18 @@ config SYS_HAS_CPU_SB1
>  config SYS_HAS_CPU_CAVIUM_OCTEON
>  	bool
> 
> +config SYS_HAS_CPU_BMIPS3300
> +	bool
> +
> +config SYS_HAS_CPU_BMIPS4350
> +	bool
> +
> +config SYS_HAS_CPU_BMIPS4380
> +	bool
> +
> +config SYS_HAS_CPU_BMIPS5000
> +	bool
> +
>  #
>  # CPU may reorder R->R, R->W, W->R, W->W
>  # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
