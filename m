Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 21:48:22 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42387 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20027541AbXBEVsS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 21:48:18 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id l15Lx1IK011259;
	Mon, 5 Feb 2007 21:59:02 GMT
Date:	Mon, 5 Feb 2007 21:59:01 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Message-ID: <20070205215901.7344c954@localhost.localdomain>
In-Reply-To: <45C77B61.1080209@pmc-sierra.com>
References: <45C77B61.1080209@pmc-sierra.com>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

>   	unsigned char		hub6;			/* this should be in the 8250 driver */
>   	unsigned char		unused[3];
> +	void				*data;			/* generic platform data pointer */
>   };

Convention is "private_data"

>
>   /*
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index 3c8a6aa..b3550cc 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -37,6 +37,7 @@ #define UART_IIR_MSI		0x00 /* Modem stat
>   #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
>   #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
>   #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
> +#define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */

Please move this down a line to break it from "official" values and call
it DESIGNWARE_UART_IIR_BUSY, so it is obviously designware specific.

Otherwise looks much less invasive and messy
