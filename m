Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6O0rARw017399
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 17:53:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6O0rADJ017398
	for linux-mips-outgoing; Tue, 23 Jul 2002 17:53:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6O0quRw017389
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 17:52:56 -0700
Received: (qmail 17490 invoked from network); 24 Jul 2002 00:33:45 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 24 Jul 2002 00:33:45 -0000
Message-ID: <3D3DFC40.6020300@ict.ac.cn>
Date: Wed, 24 Jul 2002 09:00:48 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] make PIIX4 ide driver available for MIPS
References: <3D3DF04E.7070401@mvista.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  Algor p6032 board use it too. We have been using native driver for a 
long time.

Jun Sun wrote:

>
> Malta uses this chip. The native driver does provide significant gain 
> in performance. See attached bonnie++ test results.
>
> Two separate patches for both linux_2_4 branch and trunk.
>
> Jun
>
>
>------------------------------------------------------------------------
>
>diff -Nru link/drivers/ide/Config.in.orig link/drivers/ide/Config.in
>--- link/drivers/ide/Config.in.orig	Wed Jun 26 15:35:44 2002
>+++ link/drivers/ide/Config.in	Tue Jul 23 17:03:44 2002
>@@ -72,7 +72,7 @@
>   	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
> 	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
> 	    dep_bool '    HPT366/368/370 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
>-	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
>+	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" -o "$CONFIG_MIPS" = "y" -o "$CONFIG_MIPS64" = "y" ]; then
> 	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
> 	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
> 	    fi
>
>
>------------------------------------------------------------------------
>
>diff -Nru link/drivers/ide/Config.in.orig link/drivers/ide/Config.in
>--- link/drivers/ide/Config.in.orig	Wed Jul 10 14:04:49 2002
>+++ link/drivers/ide/Config.in	Tue Jul 23 17:06:55 2002
>@@ -70,7 +70,7 @@
>   	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
> 	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
> 	    dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
>-	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
>+	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" -o "$CONFIG_MIPS" = "y" -o "$CONFIG_MIPS64" = "y" ]; then
> 	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
> 	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
> 	    fi
>
>
>------------------------------------------------------------------------
>
>
>==========================
>. bonnie++ test:
>
>With PIIX4 controller code and turnning
>---------------------------------------
>
>Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
>Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
>10.0.18.6      300M    44  99  4969  73  2875  65    65  99  5219  70 117.0  20 
>Latency               186ms     342ms     476ms     138ms   12186us    2550ms   
>Version  1.92       ------Sequential Create------ --------Random Create-------- 
>10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                 16    83  99  1677 100  1158  98    87  99  1849 100   302  98 
>Latency             25192us    2257us    2009us   45175us    1163us    9985us   
>
>With PIIX4 controller code:
>--------------------------
>
>Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
>Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
>10.0.18.6      300M    44  99  4548  67  2517  56    65  99  5019  69 114.1  20 
>Latency               186ms     436ms    1652ms     147ms   14697us    2418ms   
>Version  1.92       ------Sequential Create------ --------Random Create-------- 
>10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                 16    83  99  1663  99  1141  98    87  99  1819 100   304  98 
>Latency             32274us    1690us    2826us   37199us    1157us   10074us   
>
>Use PCI generic code
>--------------------
>Version  1.92       ------Sequential Output------ --Sequential Input- --Random- 
>                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks-- 
>Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP 
>10.0.18.6      300M    44  99  2433  35  1201  26    64  98  3101  44  85.5  14 
>Latency               186ms    4190ms    2722ms     168ms   40544us    1922ms   
>Version  1.92       ------Sequential Create------ --------Random Create-------- 
>10.0.18.6           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete-- 
>              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
>                 16    83  99  1607  99  1115  95    87  99  1788 100   305  98 
>Latency             24155us    2249us    2496us   33010us    1021us   10074us   
>
>
