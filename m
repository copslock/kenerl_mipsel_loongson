Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 14:48:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65468 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022310AbXGINsy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 14:48:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l69Df6GF016516;
	Mon, 9 Jul 2007 14:41:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l69Df4B8016515;
	Mon, 9 Jul 2007 14:41:04 +0100
Date:	Mon, 9 Jul 2007 14:41:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fulong PCI updates
Message-ID: <20070709134104.GA14536@linux-mips.org>
References: <11838701474147-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11838701474147-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 08, 2007 at 12:49:07PM +0800, tiansm@lemote.com wrote:
> diff --git a/include/asm-mips/mips-boards/bonito64.h b/include/asm-mips/mips-boards/bonito64.h
> index cd71256..dc3fc32 100644
> --- a/include/asm-mips/mips-boards/bonito64.h
> +++ b/include/asm-mips/mips-boards/bonito64.h
> @@ -26,7 +26,12 @@
>  /* offsets from base register */
>  #define BONITO(x)	(x)
> 
> -#else /* !__ASSEMBLY__ */
> +#elif defined(CONFIG_LEMOTE_FULONG)
> +
> +#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
> +#define BONITO_IRQ_BASE   32
> +
> +#else
> 
>  /*
>   * Algorithmics Bonito64 system controller register base.

Okay, I've folded that into the existing Fulong patch in the -queue tree
and that'll also be the last thing I do on the -queue tree before merging
it into the main tree rsp. to Linus.

Note that the "mips-boards" in the filename was meant to mean
boards of MTI, so that mips-boards file would rather be moved around than
included via unobvious pathes that will eventually lead to breakage when
we change code for mips-boards/bonito64.h but I guess we can fix that
later.

  Ralf
