Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 20:32:47 +0100 (BST)
Received: from xenotime.net ([66.160.160.81]:62373 "HELO xenotime.net")
	by ftp.linux-mips.org with SMTP id S20045045AbWHKTcp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 20:32:45 +0100
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 12:32:32 -0700
Date:	Fri, 11 Aug 2006 12:35:20 -0700
From:	"Randy.Dunlap" <rdunlap@xenotime.net>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Message-Id: <20060811123520.1cac289b.rdunlap@xenotime.net>
In-Reply-To: <200608102318.04512.thomas.koeller@baslerweb.com>
References: <200608102318.04512.thomas.koeller@baslerweb.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@xenotime.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@xenotime.net
Precedence: bulk
X-list: linux-mips

On Thu, 10 Aug 2006 23:18:04 +0200 Thomas Koeller wrote:

> This is a driver used for image capturing by the Basler eXcite
> smart camera platform. It utilizes the integrated GPI DMA engine of
> the MIPS RM9122 processor. Since this driver does not fit into one
> of the existing categories I created a new toplevel directory for
> it (which may not be appropriate?).

Sounds like it could fit into drivers/media/ maybe ?

> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
> ---
>  drivers/Kconfig            |    2 
>  drivers/Makefile           |    1 
>  drivers/xicap/Kconfig      |   30 +
>  drivers/xicap/Makefile     |    6 
>  drivers/xicap/xicap_core.c |  483 ++++++++++++++++++
>  drivers/xicap/xicap_gpi.c  | 1204 
> ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/xicap/xicap_priv.h |   47 ++
>  include/xicap/xicap.h      |   40 +
>  8 files changed, 1813 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 8b11ceb..5b4d329 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -74,4 +74,6 @@ source "drivers/rtc/Kconfig"
>  
>  source "drivers/dma/Kconfig"
>  
> +source "drivers/xicap/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fc2d744..af1b1ee 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -76,3 +76,4 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
>  obj-$(CONFIG_SUPERH)		+= sh/
>  obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
>  obj-$(CONFIG_DMA_ENGINE)	+= dma/
> +obj-$(CONFIG_EXCITE_FCAP)	+= xicap/
> diff --git a/drivers/xicap/Kconfig b/drivers/xicap/Kconfig
> new file mode 100644
> index 0000000..da17d82
> --- /dev/null
> +++ b/drivers/xicap/Kconfig
> @@ -0,0 +1,30 @@
> +#
> +# eXcite frame capturing configuration
> +#
> +
> +menu "eXcite frame capture support"
> +	depends BASLER_EXCITE
> +
> +config EXCITE_FCAP
> +	tristate "Frame capturing support for eXcite devices
> (EXPERIMENTAL)"
> +	---help---
> +	 Enable basic support for frame capture devices on the
> BASLER eXcite
> +	 platform. You also have to select a hardware driver.
> +	 
> +	 This can also be compiled as a module, which will be named
> +	 xicap_core.
> +
> +
> +config EXCITE_FCAP_GPI
> +	depends CPU_RM9000 && EXCITE_FCAP
> +	tristate "Frame capturing using MIPS RM9K (EXPERIMENTAL)"
> +	---help---
> +	 This driver implememnts frame capturing support via the
> +	 GPI device found on MIPS RM9K embedded processors
> manufactured
> +	 by PMC-Sierra, Inc.
> +	 
> +	 This driver can be built as a module, which will be named
> +	 xicap_gpi.
> +
> +endmenu

---
~Randy
