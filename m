Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 22:03:05 +0100 (CET)
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:58561 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012478AbbBDVDDnlxUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 22:03:03 +0100
Received: from cpsps-ews28.kpnxchange.com ([10.94.84.194]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 22:02:58 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews28.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 22:02:58 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 22:02:57 +0100
Message-ID: <1423083777.27378.8.camel@x220>
Subject: Re: [PATCH_V2 25/34] serial: 8250_jz47xx: support for Ingenic
 jz47xx UARTs
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mturquette@linaro.org,
        sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz,
        tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de,
        paul.burton@imgtec.com
Date:   Wed, 04 Feb 2015 22:02:57 +0100
In-Reply-To: <1423063323-19419-26-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
         <1423063323-19419-26-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2015 21:02:57.0621 (UTC) FILETIME=[F3C05850:01D040BD]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 2015-02-04 at 15:21 +0000, Zubair Lutfullah Kakakhel wrote:
> From: Paul Burton <paul.burton@imgtec.com>
> 
> Introduce a driver suitable for use with the UARTs present in
> Ingenic jz47xx series SoCs. These are described as being ns16550
> compatible but aren't quite - they require the setting of an extra bit
> in the FCR register to enable the UART module. The serial_out
> implementation is the same as that in arch/mips/jz4740/serial.c - which
> will shortly be removed.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-serial@vger.kernel.org
> 
> ---
> V2 changes
> Removed FSF address
> Added select SERIAL_CORE_CONSOLE to fix a build error
> ---
>  drivers/tty/serial/8250/8250_jz47xx.c | 225 ++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig       |   9 ++
>  drivers/tty/serial/8250/Makefile      |   1 +
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
> 
>[...]
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 0fcbcd2..ebb298e 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -322,3 +322,12 @@ config SERIAL_8250_MT6577
>  	help
>  	  If you have a Mediatek based board and want to use the
>  	  serial port, say Y to this option. If unsure, say N.
> +
> +config SERIAL_8250_JZ47XX
> +	tristate "Support for Ingenic jz47xx series serial ports"
> +	depends on SERIAL_8250
> +	select SERIAL_EARLYCON
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  If you have a system using an Ingenic jz47xx series SoC and wish to
> +	  make use of its UARTs, say Y to this option. If unsure, say N.

Nit: should people never say M?


Paul Bolle
