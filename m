Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 12:52:08 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:10159 "EHLO the-village.bc.nu")
	by ftp.linux-mips.org with ESMTP id S20032322AbXLDMv7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Dec 2007 12:51:59 +0000
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id lB4CjGVq000757;
	Tue, 4 Dec 2007 12:45:16 GMT
Date:	Tue, 4 Dec 2007 12:45:16 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Cc:	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Message-ID: <20071204124516.0120266a@the-village.bc.nu>
In-Reply-To: <20071204082534.GA5938@alpha.franken.de>
References: <20071202194346.36E3FDE4C4@solo.franken.de>
	<20071203155317.772231f9.akpm@linux-foundation.org>
	<20071203155746.2dc4506d@laptopd505.fenrus.org>
	<20071204082534.GA5938@alpha.franken.de>
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
X-archive-position: 17688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 4 Dec 2007 09:25:35 +0100
tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:

> On Mon, Dec 03, 2007 at 03:57:46PM -0800, Arjan van de Ven wrote:
> > > > +#define SC26XX_MAJOR         204
> > > > +#define SC26XX_MINOR_START   205
> > > > +#define SC26XX_NR            2
> > 
> > did lanana assign these numbers officially?
> 
> I tried to numbers several months ago and didn't get any response 

Please raise it with the relevant people. If our LANANA administrator is
not doing their job then the Linuxfoundation need to find a replacement,
or hand control of it over to someone outside.
