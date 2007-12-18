Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 10:58:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42372 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578333AbXLRK6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 10:58:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBIArJ6q019666;
	Tue, 18 Dec 2007 10:53:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBIAqs5g019664;
	Tue, 18 Dec 2007 11:52:54 +0100
Date:	Tue, 18 Dec 2007 11:52:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] Introduced GPI_RM9000 configuration parameter
Message-ID: <20071218105254.GA13344@linux-mips.org>
References: <20071218003140.4415847A63@mail.koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071218003140.4415847A63@mail.koeller.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 18, 2007 at 01:26:19AM +0100, Thomas Koeller wrote:

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c6fc405..62bc553 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -856,6 +856,9 @@ config GENERIC_ISA_DMA_SUPPORT_BROKEN
>  config GENERIC_GPIO
>  	bool
>  
> +config GPI_RM9000
> +       bool
> +
>  #
>  # Endianess selection.  Sufficiently obscure so many users don't know what to
>  # answer,so we try hard to limit the available choices.  Also the use of a
> @@ -927,6 +930,7 @@ config MIPS_TX3927
>  config MIPS_RM9122
>  	bool
>  	select SERIAL_RM9000
> +	select GPI_RM9000

See my earlier reply to http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20070911122005.GC24679%40linux-mips.org

Technically the patch is ok but please only introduce new config symbols
only together with an actual user.

  Ralf
