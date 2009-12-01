Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 14:32:16 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59970 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492465AbZLANcM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 14:32:12 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1DWPrK019390;
        Tue, 1 Dec 2009 13:32:25 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1DWNwk019379;
        Tue, 1 Dec 2009 13:32:23 GMT
Date:   Tue, 1 Dec 2009 13:32:23 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH v6 1/8] Loongson: Lemote-2F: add platform specific submenu
Message-ID: <20091201133223.GA14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <a67a4a2ab32fc0e3281845479f07adf69dbf0bb2.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67a4a2ab32fc0e3281845479f07adf69dbf0bb2.1259664573.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 07:07:23PM +0800, Wu Zhangin wrote:

>  arch/mips/loongson/Kconfig |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 3df1967..a34dfcc 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -83,3 +83,23 @@ config LOONGSON_UART_BASE
>  	bool
>  	default y
>  	depends on EARLY_PRINTK || SERIAL_8250
> +
> +#
> +# Loongson Platform Specific Drivers
> +#
> +
> +menuconfig LOONGSON_PLATFORM_DEVICES
> +	bool "Loongson Platform Drivers"
> +	default y
> +	help
> +	  Say Y here to get to see options for device drivers of various
> +	  loongson platforms, including vendor-specific laptop/pc extension
> +	  drivers.  This option alone does not add any kernel code.
> +
> +	  If you say N, all options in this submenu will be skipped and disabled.
> +
> +if LOONGSON_PLATFORM_DEVICES
> +# Put platform specific stuff here

Useless comment.  LOONGSON_PLATFORM_DEVICES already says exactly that.

> +
> +
> +endif # LOONGSON_PLATFORM_DEVICES

  Ralf
