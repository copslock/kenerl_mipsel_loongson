Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 01:01:14 +0000 (GMT)
Received: from mo00.po.2iij.Net ([210.130.202.204]:39916 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133729AbWBTBBF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 01:01:05 +0000
Received: NPO MO00 id k1K17twG006537; Mon, 20 Feb 2006 10:07:55 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox03) id k1K17suB021247
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 20 Feb 2006 10:07:54 +0900 (JST)
Message-Id: <200602200107.k1K17suB021247@mbox03.po.2iij.net>
Date:	Mon, 20 Feb 2006 10:07:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: VR4181
In-Reply-To: <20060220001126.GA17967@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
	<20060220000141.GX10266@deprecation.cyrius.com>
	<20060220001126.GA17967@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Martin,

VR4181 has already been removed from the mainline and linux-mips. 
I think linux-mips should synchronize with the mainline.

Yoichi

On Mon, 20 Feb 2006 00:11:26 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> It seems the following VR4181 change never made it into mainline.
> 
> 
> --- linux-2.6.16-rc4/arch/mips/Kconfig	2006-02-19 20:08:02.000000000 +0000
> +++ mips-2.6.16-rc4/arch/mips/Kconfig	2006-02-19 20:14:36.000000000 +0000
> @@ -503,10 +503,7 @@
>  	  ether port USB, AC97, PCI, etc.
>  
>  config MACH_VR41XX
> -	bool "Support for NEC VR4100 series based machines"
> -	select SYS_HAS_CPU_VR41XX
> -	select SYS_SUPPORTS_32BIT_KERNEL
> -	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
> +	bool "Support for NEC VR41XX-based machines"
>  
>  config PMC_YOSEMITE
>  	bool "Support for PMC-Sierra Yosemite eval board"
> @@ -1019,6 +1016,9 @@
>  config HAVE_STD_PC_SERIAL_PORT
>  	bool
>  
> +config VR4181
> +	bool
> +
>  config ARC_CONSOLE
>  	bool "ARC console support"
>  	depends on SGI_IP22 || SNI_RM200_PCI
> @@ -1130,7 +1130,7 @@
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_64BIT_KERNEL
>  	help
> -	  The options selects support for the NEC VR4100 series of processors.
> +	  The options selects support for the NEC VR41xx series of processors.
>  	  Only choose this option if you have one of these processors as a
>  	  kernel built with this option will not run on any other type of
>  	  processor or vice versa.
> --- linux-2.6.16-rc4/arch/mips/kernel/cpu-probe.c	2006-02-19 20:08:04.000000000 +0000
> +++ mips-2.6.16-rc4/arch/mips/kernel/cpu-probe.c	2006-02-19 20:14:37.000000000 +0000
> @@ -242,9 +242,15 @@
>  		break;
>  	case PRID_IMP_VR41XX:
>  		switch (c->processor_id & 0xf0) {
> +#ifndef CONFIG_VR4181
>  		case PRID_REV_VR4111:
>  			c->cputype = CPU_VR4111;
>  			break;
> +#else
> +		case PRID_REV_VR4181:
> +			c->cputype = CPU_VR4181;
> +			break;
> +#endif
>  		case PRID_REV_VR4121:
>  			c->cputype = CPU_VR4121;
>  			break;
> 
