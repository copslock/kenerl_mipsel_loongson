Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2007 13:36:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34454 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022024AbXFLMgl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Jun 2007 13:36:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5CCYg6q003321;
	Tue, 12 Jun 2007 13:35:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5CCYejj003320;
	Tue, 12 Jun 2007 13:34:40 +0100
Date:	Tue, 12 Jun 2007 13:34:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 09/15] add serial port definition for lemote fulong
Message-ID: <20070612123440.GC2926@linux-mips.org>
References: <11811127722019-git-send-email-tiansm@lemote.com> <11811127741719-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11811127741719-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 02:52:46PM +0800, tiansm@lemote.com wrote:

> +#if defined(CONFIG_LEMOTE_FULONG)
> +#define LEMOTE_FULONG_SERIAL_PORT_DEFNS			\
> +	/* UART CLK   PORT IRQ     FLAGS        */	\
> +	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */
> +#endif
> +
>  #define SERIAL_PORT_DFNS				\
>  	DDB5477_SERIAL_PORT_DEFNS			\
>  	EV64120_SERIAL_PORT_DEFNS			\
> @@ -172,6 +178,7 @@
>  	STD_SERIAL_PORT_DEFNS				\
>  	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
>  	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
> -	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS
> +	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
> +	LEMOTE_FULONG_SERIAL_PORT_DEFNS
>  
>  #endif /* _ASM_SERIAL_H */

I wonder, is the standard CONFIG_HAVE_STD_PC_SERIAL_PORT which does
basically the same thing as above but for all four ports of a typical
PC-style 16652 configuration for some reason inacceptable for Fulong?

  Ralf
