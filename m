Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 06:17:22 +0000 (GMT)
Received: from mo01.po.2iij.Net ([210.130.202.205]:34517 "EHLO
	mo01.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8127231AbWCTGRM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 06:17:12 +0000
Received: NPO MO01 id k2K6Qm0L026600; Mon, 20 Mar 2006 15:26:48 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox03) id k2K6QkOq026633
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 20 Mar 2006 15:26:47 +0900 (JST)
Date:	Mon, 20 Mar 2006 15:26:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based
 machines
Message-Id: <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043902.GA20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043902.GA20416@deprecation.cyrius.com>
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
X-archive-position: 10874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Mar 2006 04:39:02 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> MIPS supports various NEC VR41XX chips and not just the VR4100.
> Update Kconfig accordingly, thereby bringing the file in sync with
> the linux-mips tree.

The linux-mips tree is older than kernel.org about this part.

Yoichi

> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> 
> --- linux-2.6/arch/mips/Kconfig	2006-03-13 18:45:54.000000000 +0000
> +++ mips.git/arch/mips/Kconfig	2006-03-20 03:22:02.000000000 +0000
> @@ -503,7 +503,7 @@
>  	  ether port USB, AC97, PCI, etc.
>  
>  config MACH_VR41XX
> -	bool "Support for NEC VR4100 series based machines"
> +	bool "Support for NEC VR41XX-based machines"
>  	select SYS_HAS_CPU_VR41XX
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
> @@ -1134,7 +1134,7 @@
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_64BIT_KERNEL
>  	help
> -	  The options selects support for the NEC VR4100 series of processors.
> +	  The options selects support for the NEC VR41xx series of processors.
>  	  Only choose this option if you have one of these processors as a
>  	  kernel built with this option will not run on any other type of
>  	  processor or vice versa.
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
