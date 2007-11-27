Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 08:28:25 +0000 (GMT)
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:38542 "EHLO
	hoboe2bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022456AbXK0I2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 08:28:16 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe2bl1.telenet-ops.be (Postfix) with SMTP id 483EA12408A;
	Tue, 27 Nov 2007 09:28:16 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe2bl1.telenet-ops.be (Postfix) with ESMTP id DEF9E124037;
	Tue, 27 Nov 2007 09:28:15 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lAR8SF8f014982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Nov 2007 09:28:15 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lAR8SE37014979;
	Tue, 27 Nov 2007 09:28:15 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 27 Nov 2007 09:28:14 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] SGIWD93: use cached memory access to make driver work
 on IP28
In-Reply-To: <20071126223921.A566CC2B26@solo.franken.de>
Message-ID: <Pine.LNX.4.64.0711270927370.22167@anakin>
References: <20071126223921.A566CC2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 26 Nov 2007, Thomas Bogendoerfer wrote:
> --- a/drivers/scsi/sgiwd93.c
> +++ b/drivers/scsi/sgiwd93.c
> @@ -33,19 +33,27 @@
>  
>  struct ip22_hostdata {
>  	struct WD33C93_hostdata wh;
> -	struct hpc_data {
> -		dma_addr_t      dma;
> -		void		*cpu;
> -	} hd;
> +	dma_addr_t dma;
> +	void *cpu;
> +	void *dev;
>  };
>  
>  #define host_to_hostdata(host) ((struct ip22_hostdata *)((host)->hostdata))
>  
>  struct hpc_chunk {
>  	struct hpc_dma_desc desc;
> -	u32 _padding;	/* align to quadword boundary */
> +	u32 _padding[128/4 - 3];	/* align to biggest cache line size */
                     ^^^^^^^^^
(128 - sizeof(struct hpc_dma_desc))/4?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
