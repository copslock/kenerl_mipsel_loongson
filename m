Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6O0eDRw017179
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 17:40:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6O0eDqT017178
	for linux-mips-outgoing; Tue, 23 Jul 2002 17:40:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f235.dialo.tiscali.de [62.246.17.235])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6O0dwRw017162
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 17:39:59 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6O0en430826;
	Wed, 24 Jul 2002 02:40:50 +0200
Date: Wed, 24 Jul 2002 02:40:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] make PIIX4 ide driver available for MIPS
Message-ID: <20020724024049.A20154@dea.linux-mips.net>
References: <3D3DF04E.7070401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3DF04E.7070401@mvista.com>; from jsun@mvista.com on Tue, Jul 23, 2002 at 05:09:50PM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 05:09:50PM -0700, Jun Sun wrote:

> Malta uses this chip.  The native driver does provide significant gain in 
> performance.  See attached bonnie++ test results.
> 
> Two separate patches for both linux_2_4 branch and trunk.

CONFIG_MIPS is defined for both 32-bit and 64-bit kernel.

   Ralf


> diff -Nru link/drivers/ide/Config.in.orig link/drivers/ide/Config.in
> --- link/drivers/ide/Config.in.orig	Wed Jun 26 15:35:44 2002
> +++ link/drivers/ide/Config.in	Tue Jul 23 17:03:44 2002
> @@ -72,7 +72,7 @@
>    	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
>  	    dep_bool '    HPT366/368/370 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
> -	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
> +	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" -o "$CONFIG_MIPS" = "y" -o "$CONFIG_MIPS64" = "y" ]; then
>  	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
>  	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
>  	    fi

> diff -Nru link/drivers/ide/Config.in.orig link/drivers/ide/Config.in
> --- link/drivers/ide/Config.in.orig	Wed Jul 10 14:04:49 2002
> +++ link/drivers/ide/Config.in	Tue Jul 23 17:06:55 2002
> @@ -70,7 +70,7 @@
>    	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
>  	    dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
> -	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
> +	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" -o "$CONFIG_MIPS" = "y" -o "$CONFIG_MIPS64" = "y" ]; then
>  	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
>  	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
>  	    fi

> 
> ==========================
> . bonnie++ test:
> 
> With PIIX4 controller code and turnning
> ---------------------------------------
> 
> Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
> 10.0.18.6      300M    44  99  4969  73  2875  65    65  99  5219  70 117.0  20 
> Latency               186ms     342ms     476ms     138ms   12186us    2550ms   
> Version  1.92       ------Sequential Create------ --------Random Create-------- 
> 10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                  16    83  99  1677 100  1158  98    87  99  1849 100   302  98 
> Latency             25192us    2257us    2009us   45175us    1163us    9985us   
> 
> With PIIX4 controller code:
> --------------------------
> 
> Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
> 10.0.18.6      300M    44  99  4548  67  2517  56    65  99  5019  69 114.1  20 
> Latency               186ms     436ms    1652ms     147ms   14697us    2418ms   
> Version  1.92       ------Sequential Create------ --------Random Create-------- 
> 10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                  16    83  99  1663  99  1141  98    87  99  1819 100   304  98 
> Latency             32274us    1690us    2826us   37199us    1157us   10074us   
> 
> Use PCI generic code
> --------------------
> Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
> 10.0.18.6      300M    44  99  2433  35  1201  26    64  98  3101  44  85.5  14 
> Latency               186ms    4190ms    2722ms     168ms   40544us    1922ms   
> Version  1.92       ------Sequential Create------ --------Random Create-------- 
> 10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                  16    83  99  1607  99  1115  95    87  99  1788 100   305  98 
> Latency             24155us    2249us    2496us   33010us    1021us   10074us   
> 
> 
