Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 11:28:54 +0100 (CET)
Received: from mx1.moondrake.net ([212.85.150.166]:46332 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492986AbZKDK2s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 11:28:48 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id ED3E3274004; Wed,  4 Nov 2009 11:28:46 +0100 (CET)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id E25E6274007;
	Wed,  4 Nov 2009 11:28:45 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 3CFC582919;
	Wed,  4 Nov 2009 11:40:13 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 88E28FF855;
	Wed,  4 Nov 2009 11:28:59 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	<a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
Organization: Mandriva
Date:	Wed, 04 Nov 2009 11:28:59 +0100
In-Reply-To: <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com> (Wu Zhangjin's message of "Wed,  4 Nov 2009 17:04:47 +0800")
Message-ID: <m3iqdqtwgk.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips


Hi,

Wu Zhangjin <wuzhangjin@gmail.com> writes:

> Loongson2F has built-in DDR2 and PCIX controller. The PCIX controller
> have a similar programming interface with FPGA northbridge used in
> Loongson2E.
>
> The main differences between loongson-2e and loongson-2f include:
>
> 1. loongson-2f has an extra address windows configuration module, which
> can be used to map CPU address space to DDR or PCI address space, or map
> the PCI-DMA address space to DDR or LIO address space.
>
> 2. loongson-2f support 8 levels of software configurable cpu frequency,
> which can be configured via a register(LOONGSON_CHIPCFG0).  the coming
> cpufreq and standby support are based on this feature.
>
> herein, the module and the corresponding operations are abstracted to
> loongson.h.
>
> besides, the other loongson2f-specific source code are added here,
> including gcc 4.4 support, pci memory space, pci io space, dma address.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig                                  |   18 ++++
>  arch/mips/Makefile                                 |    2 +
>  .../mips/include/asm/mach-loongson/dma-coherence.h |    4 +
>  arch/mips/include/asm/mach-loongson/loongson.h     |   84 +++++++++++++++++++-
>  arch/mips/include/asm/mach-loongson/mem.h          |   25 ++++--
>  arch/mips/include/asm/mach-loongson/pci.h          |   28 ++++++-
>  arch/mips/loongson/common/bonito-irq.c             |    5 +
>  arch/mips/loongson/common/init.c                   |   18 ++++
>  arch/mips/loongson/common/mem.c                    |   17 ++++
>  arch/mips/loongson/common/pci.c                    |    8 ++
>  10 files changed, 199 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ae9fa98..8417357 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1059,6 +1059,21 @@ config CPU_LOONGSON2E
>  	  The Loongson 2E processor implements the MIPS III instruction set
>  	  with many extensions.
>  
> +	  It has an internal FPGA northbridge, which is compatiable to
> +	  bonito64.
> +
> +config CPU_LOONGSON2F
> +	bool "Loongson 2F"
> +	depends on SYS_HAS_CPU_LOONGSON2F
> +	select CPU_LOONGSON2
> +	help
> +	  The Loongson 2F processor implements the MIPS III instruction set
> +	  with many extensions.
> +
> +	  Loongson2F have built-in DDR2 and PCIX controller. The PCIX controller
> +	  have a similar programming interface with FPGA northbridge used in
> +	  Loongson2E.
> +

Small question : Why don't you restrict to 64bit kernels only ? From
what I remember from some discussions with ST, trying to use a 32-bit
kernel on 2f is a nice way to get troubles. It would be better imho to
forbid such a configuration. As a side effect, this will remove all
'defined(CONFIG_64BIT)' parts of your #ifdef tests. 

Arnaud
