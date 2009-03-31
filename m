Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 18:00:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:28249 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20025854AbZCaRAK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 18:00:10 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9A3393ECB; Tue, 31 Mar 2009 10:00:06 -0700 (PDT)
Message-ID: <49D24C37.2030001@ru.mvista.com>
Date:	Tue, 31 Mar 2009 21:00:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1xxx-ide: fix build with CONFIG_PM
References: <1238517876-4724-1-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1238517876-4724-1-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> au1xxx_ide_dev_t is never defined;  get rid of all PM stuff as

    You meant au1xxx_power_dev_t?

> well since it is not in the driver source anyway.

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
> index 60638b8..5656c72 100644
> --- a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
> +++ b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
> @@ -46,20 +46,6 @@
>  #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON	0
>  #endif
>  
> -#ifdef CONFIG_PM
> -/*
> - * This will enable the device to be powered up when write() or read()
> - * is called. If this is not defined, the driver will return -EBUSY.
> - */
> -#define WAKE_ON_ACCESS 1
> -
> -typedef struct {
> -	spinlock_t		lock;	/* Used to block on state transitions */
> -	au1xxx_power_dev_t	*dev;	/* Power Managers device structure */
> -	unsigned		stopped; /* Used to signal device is stopped */
> -} pm_state;
> -#endif
> -
>  typedef struct {
>  	u32			tx_dev_id, rx_dev_id, target_dev_id;
>  	u32			tx_chan, rx_chan;
> @@ -72,9 +58,6 @@ typedef struct {
>  #endif
>  	int			irq;
>  	u32			regbase;
> -#ifdef CONFIG_PM
> -	pm_state		pm;
> -#endif
>  } _auide_hwif;
>  
>  /******************************************************************************/

MBR, Sergei
