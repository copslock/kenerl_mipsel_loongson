Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 08:35:35 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:24465 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025308AbXLDIfZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Dec 2007 08:35:25 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IzTFQ-0004S7-00; Tue, 04 Dec 2007 09:35:20 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4A812DE4C4; Tue,  4 Dec 2007 09:25:35 +0100 (CET)
Date:	Tue, 4 Dec 2007 09:25:35 +0100
To:	Arjan van de Ven <arjan@infradead.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Andy Whitcroft <apw@shadowen.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Message-ID: <20071204082534.GA5938@alpha.franken.de>
References: <20071202194346.36E3FDE4C4@solo.franken.de> <20071203155317.772231f9.akpm@linux-foundation.org> <20071203155746.2dc4506d@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071203155746.2dc4506d@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Dec 03, 2007 at 03:57:46PM -0800, Arjan van de Ven wrote:
> > > +#define SC26XX_MAJOR         204
> > > +#define SC26XX_MINOR_START   205
> > > +#define SC26XX_NR            2
> 
> did lanana assign these numbers officially?

I tried to numbers several months ago and didn't get any response :-(

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
