Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2009 23:23:35 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:61629 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20808404AbZCKXX2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Mar 2009 23:23:28 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 627F740009;
	Thu, 12 Mar 2009 00:23:19 +0100 (CET)
Received: from [192.168.10.105] (c-30bde555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.189.48])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4097040007;
	Thu, 12 Mar 2009 00:23:19 +0100 (CET)
Cc:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Message-Id: <1977ADB0-36B0-4370-B3E5-A8D5DC5EEE36@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20090311112806.GA24541@linux-mips.org>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-24-808569442"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: __do_IRQ() going away
Date:	Thu, 12 Mar 2009 00:23:27 +0100
References: <20090311112806.GA24541@linux-mips.org>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.930.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-24-808569442
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

I'll have a quick look at the NEC EMMA2 code, for review...

//Markus
On 11 Mar 2009, at 12:28, Ralf Baechle wrote:

> __do_IRQ() is deprecated since a long time and there are plans to  
> remove
> it for 2.6.30.  The MIPS platforms seem to fall into three classes:
>
> o Platforms setting CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ to explicitly  
> disable
>   __do_IRQ():
> 	capcella_defconfig, cobalt_defconfig, e55_defconfig,
> 	fulong_defconfig, ip27_defconfig, jazz_defconfig, jmr3927_defconfig,
> 	lasat_defconfig, mpc30x_defconfig, pnx8335-stb225_defconfig,
> 	pnx8550-jbs_defconfig, pnx8550-stb810_defconfig, rb532_defconfig,
> 	rbtx49xx_defconfig, tb0219_defconfig, tb0226_defconfig,
> 	tb0287_defconfig and workpad_defconfig.
>
> o Platforms that don't set CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ but  
> don't
>   seem to use __do_IRQ():
>
> 	bcm47xx_defconfig, cavium-octeon_defconfig, excite_defconfig,
> 	ip22_defconfig, ip28_defconfig, msp71xx_defconfig, wrppmc_defconfig,
>
> o Platforms that still seem to rely on __do_IRQ():
>     o All Sibyte platforms:
> 	bigsur_defconfig and sb1250-swarm_defconfig
>
>     o All Alchemy platforms:
> 	db1000_defconfig, db1100_defconfig, db1200_defconfig,  
> db1500_defconfig,
> 	db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
> 	and pb1550_defconfig
>
>     o malta_defconfig.  The platform code itself is ok but irq-gic.c,
> 	irq-msc01.c, irq-msc01.c and irq_cpu.c are still using set_irq_chip
> 	and need fixing.
>
>     o And the rest:
> 	decstation_defconfig, emma2rh_defconfig, ip32_defconfig,
> 	yosemite_defconfig, mipssim_defconfig and rm200_defconfig.
>
> For now I've checked in the following patch into linux-queue.
>
>  Ralf
>
> MIPS: Enable GENERIC_HARDIRQS_NO__DO_IRQ for all platforms
>
> __do_IRQ() is deprecated and will go away.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> arch/mips/Kconfig |   12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
>
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -77,7 +77,6 @@ config MIPS_COBALT
> 	select SYS_SUPPORTS_32BIT_KERNEL
> 	select SYS_SUPPORTS_64BIT_KERNEL
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
>
> config MACH_DECSTATION
> 	bool "DECstations"
> @@ -132,7 +131,6 @@ config MACH_JAZZ
> 	select SYS_SUPPORTS_32BIT_KERNEL
> 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
> 	select SYS_SUPPORTS_100HZ
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	help
> 	 This a family of machines based on the MIPS R4030 chipset which was
> 	 used by several vendors to build RISC/os and Windows NT  
> workstations.
> @@ -154,7 +152,6 @@ config LASAT
> 	select SYS_SUPPORTS_32BIT_KERNEL
> 	select SYS_SUPPORTS_64BIT_KERNEL if BROKEN
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
>
> config LEMOTE_FULONG
> 	bool "Lemote Fulong mini-PC"
> @@ -175,7 +172,6 @@ config LEMOTE_FULONG
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> 	select SYS_SUPPORTS_HIGHMEM
> 	select SYS_HAS_EARLY_PRINTK
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
> 	select CPU_HAS_WB
> 	help
> @@ -246,7 +242,6 @@ config MACH_VR41XX
> 	select CEVT_R4K
> 	select CSRC_R4K
> 	select SYS_HAS_CPU_VR41XX
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
>
> config NXP_STB220
> 	bool "NXP STB220 board"
> @@ -360,7 +355,6 @@ config SGI_IP27
> 	select SYS_SUPPORTS_BIG_ENDIAN
> 	select SYS_SUPPORTS_NUMA
> 	select SYS_SUPPORTS_SMP
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	help
> 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
> 	  workstations.  To compile a Linux kernel that runs on these, say Y
> @@ -559,7 +553,6 @@ config MIKROTIK_RB532
> 	select CEVT_R4K
> 	select CSRC_R4K
> 	select DMA_NONCOHERENT
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	select HW_HAS_PCI
> 	select IRQ_CPU
> 	select SYS_HAS_CPU_MIPS32_R1
> @@ -697,8 +690,7 @@ config SCHED_OMIT_FRAME_POINTER
> 	default y
>
> config GENERIC_HARDIRQS_NO__DO_IRQ
> -	bool
> -	default n
> +	def_bool y
>
> #
> # Select some configuration options automatically based on user  
> selections.
> @@ -905,7 +897,6 @@ config SOC_PNX833X
> 	select SYS_SUPPORTS_32BIT_KERNEL
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> 	select SYS_SUPPORTS_BIG_ENDIAN
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	select GENERIC_GPIO
> 	select CPU_MIPSR2_IRQ_VI
>
> @@ -924,7 +915,6 @@ config SOC_PNX8550
> 	select SYS_HAS_CPU_MIPS32_R1
> 	select SYS_HAS_EARLY_PRINTK
> 	select SYS_SUPPORTS_32BIT_KERNEL
> -	select GENERIC_HARDIRQS_NO__DO_IRQ
> 	select GENERIC_GPIO
>
> config SWAP_IO_SPACE
>


--Apple-Mail-24-808569442
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkm4R+8ACgkQ6I0XmJx2Nrww9wCg2M/lbvGoVN6EhM4UwUsk6Ros
yS8AoJwfcFi/Z28mwXn/AoovsKdSiT4h
=4VbH
-----END PGP SIGNATURE-----

--Apple-Mail-24-808569442--
