Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 18:13:30 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:3090 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133604AbWA3SNM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 18:13:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UIHsf9032383;
	Mon, 30 Jan 2006 18:17:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0UIHsMa032381;
	Mon, 30 Jan 2006 18:17:54 GMT
Date:	Mon, 30 Jan 2006 18:17:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matt Porter <mporter@kernel.crashing.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix vgacon oops on 64-bit
Message-ID: <20060130181754.GA29634@linux-mips.org>
References: <20060130083321.B3098@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130083321.B3098@cox.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 30, 2006 at 08:33:21AM -0700, Matt Porter wrote:

> Although I'm not running a VGA card, I noticed this building
> a working malta 32-bit defconfig (vgacon enabled) for 64-bit.
> Without it, the vgacon probe will access unmapped space when
> looking to see if a vga card is present.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> 
> diff --git a/include/asm-mips/vga.h b/include/asm-mips/vga.h
> index ca5cec9..1390ab6 100644
> --- a/include/asm-mips/vga.h
> +++ b/include/asm-mips/vga.h
> @@ -13,7 +13,11 @@
>   *	access the videoram directly without any black magic.
>   */
>  
> +#ifdef CONFIG_64BIT
> +#define VGA_MAP_MEM(x)	(0xffffffffb0000000UL + (unsigned long)(x))
> +#else
>  #define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
> +#endif

Looks like driving out the devil with beelzebub.  The 0xb0000000 address
is totally platform specific and nobody ever noticed ...

  Ralf
