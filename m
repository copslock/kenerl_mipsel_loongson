Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 18:38:51 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55976 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20026719AbXLCSin (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 18:38:43 +0000
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id lB3IYJGI030243;
	Mon, 3 Dec 2007 18:34:19 GMT
Date:	Mon, 3 Dec 2007 18:34:19 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	akpm@linux-foundation.org, wim@iguana.be
Subject: Re: [PATCH] Add support for SB1 hardware watchdog.
Message-ID: <20071203183419.3213d551@the-village.bc.nu>
In-Reply-To: <20071203181658.GA26631@onstor.com>
References: <20071203181658.GA26631@onstor.com>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.10.14; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> +	  on such processors; this driver supports only the first one,
> +	  because currently Linux only supports exporting one watchdog
> +	  to userspace.

Yep. Perhaps that should change.

> + * wdog is the iomem address of the cfg register
> + */
> + void
> +sbwdog_set(char __iomem *wdog, unsigned long t)
> +{
> +	__raw_writeb(0, wdog - 0x10);
> +	__raw_writeq(t & 0x7fffffUL, wdog);
> +}

What guarantees you don't get a pair of these calls at once or
interleaving ?



> +		 * return the bits from the config register
> +		 */
> +		ret = put_user(__raw_readb(user_dog), p);

Should return the translated status bits ?



Alan
