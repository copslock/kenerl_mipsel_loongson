Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 13:26:58 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:45828 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133646AbWBTN0p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 13:26:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 15D37F5B47;
	Mon, 20 Feb 2006 14:33:38 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02873-08; Mon, 20 Feb 2006 14:33:37 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B71A9E1C6D;
	Mon, 20 Feb 2006 14:33:37 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1KDXSJX021934;
	Mon, 20 Feb 2006 14:33:28 +0100
Date:	Mon, 20 Feb 2006 13:33:31 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	stevel@mvista.com, wyldfier@iname.com, lachwani@pmc-sierra.com,
	dan@embeddededge.com, johuang@siliconmotion.com
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
In-Reply-To: <20060219234757.GW10266@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
References: <20060219234318.GA16311@deprecation.cyrius.com>
 <20060219234757.GW10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1293/Sun Feb 19 17:40:25 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 19 Feb 2006, Martin Michlmayr wrote:

> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 6acfa3d..dd628cb 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -47,11 +47,6 @@ config MTD_MS02NV
>  	  accelerator.  Say Y here if you have a DECstation 5000/2x0 or a
>  	  DECsystem 5900 equipped with such a module.
>  
> -	  If you want to compile this driver as a module ( = code which can be
> -	  inserted in and removed from the running kernel whenever you want),
> -	  say M here and read <file:Documentation/modules.txt>.  The module will
> -	  be called ms02-nv.o.
> -
>  config MTD_DATAFLASH
>  	tristate "Support for AT45xxx DataFlash"
>  	depends on MTD && SPI_MASTER && EXPERIMENTAL

 NAK.

> diff --git a/drivers/net/declance.c b/drivers/net/declance.c
> index d049129..6561575 100644
> --- a/drivers/net/declance.c
> +++ b/drivers/net/declance.c
> @@ -1301,7 +1301,6 @@ static void __exit dec_lance_cleanup(voi
>  	while (root_lance_dev) {
>  		struct net_device *dev = root_lance_dev;
>  		struct lance_private *lp = netdev_priv(dev);
> -
>  		unregister_netdev(dev);
>  #ifdef CONFIG_TC
>  		if (lp->slot >= 0)

 NAK.

> diff --git a/drivers/scsi/dec_esp.c b/drivers/scsi/dec_esp.c
> index e755664..4b86685 100644
> --- a/drivers/scsi/dec_esp.c
> +++ b/drivers/scsi/dec_esp.c
> @@ -55,7 +55,7 @@
>  
>  static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
>  static void dma_drain(struct NCR_ESP *esp);
> -static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp);
> +static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
>  static void dma_dump_state(struct NCR_ESP *esp);
>  static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
>  static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);

 ACK.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 7d7724c..7e63f15 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1336,8 +1336,8 @@ config FB_PMAGB_B
>   	select FB_CFB_IMAGEBLIT
>  	help
>  	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
> -	  in the MIPS-based DECstation series. The card is currently only 
> -	  supported in 1280x1024x8 mode.  
> +	  in the MIPS-based DECstation series. The card is currently only
> +	  supported in 1280x1024x8 mode.
>  
>  config FB_MAXINE
>  	bool "Maxine (Personal DECstation) onboard framebuffer support"

 ACK.

 Thanks for looking into it.

  Maciej
