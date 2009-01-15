Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 14:25:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10438 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365139AbZAOOZP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 14:25:15 +0000
Received: from localhost (p8187-ipad206funabasi.chiba.ocn.ne.jp [222.145.82.187])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 542809DD8; Thu, 15 Jan 2009 23:25:09 +0900 (JST)
Date:	Thu, 15 Jan 2009 23:25:10 +0900 (JST)
Message-Id: <20090115.232510.65192869.anemo@mba.ocn.ne.jp>
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org, tpaoletti@caviumnetworks.com
Subject: Re: [PATCH 20/20] MIPS: Add Cavium OCTEON to arch/mips/Kconfig
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1229038418-31833-20-git-send-email-ddaney@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
	<1229038418-31833-20-git-send-email-ddaney@caviumnetworks.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 11 Dec 2008 15:33:38 -0800, David Daney <ddaney@caviumnetworks.com> wrote:
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -595,6 +595,44 @@ config WR_PPMC
>  	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
>  	  board, which is based on GT64120 bridge chip.
>  
> +config CAVIUM_OCTEON_SIMULATOR
> +	bool "Support for the Cavium Networks Octeon Simulator"
> +	select CEVT_R4K
> +	select 64BIT_PHYS_ADDR
> +	select DMA_COHERENT
> +	select SYS_SUPPORTS_64BIT_KERNEL
> +	select SYS_SUPPORTS_BIG_ENDIAN
> +	select SYS_SUPPORTS_HIGHMEM
> +	select CPU_CAVIUM_OCTEON
> +	help
> +	  The Octeon simulator is software performance model of the Cavium
> +	  Octeon Processor. It supports simulating Octeon processors on x86
> +	  hardware.

All other board entries use SYS_HAS_CPU_XXXX intermediate variable to
select CPU.  Please defined SYS_HAS_CPU_CAVIUM_OCTEON and use it.
Othersize every other board configs will be asked for
CPU_CAVIUM_OCTEON.

---
Atsushi Nemoto
