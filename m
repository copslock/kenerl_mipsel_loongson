Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 09:32:05 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:65175 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022638AbXLEJb5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 09:31:57 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Izqbh-0004k7-00; Wed, 05 Dec 2007 10:31:53 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 65573C2EB0; Wed,  5 Dec 2007 10:25:06 +0100 (CET)
Date:	Wed, 5 Dec 2007 10:25:06 +0100
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Andy Whitcroft <apw@shadowen.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Message-ID: <20071205092506.GA6691@alpha.franken.de>
References: <20071202194346.36E3FDE4C4@solo.franken.de> <20071203155317.772231f9.akpm@linux-foundation.org> <20071204234112.GA12352@alpha.franken.de> <20071204192738.54e79a97.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071204192738.54e79a97.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Dec 04, 2007 at 07:27:38PM -0800, Andrew Morton wrote:
> grumble.
> 
> These:
> 
> > +#define READ_SC(p, r)        readb((p)->membase + RD_##r)
> > +#define WRITE_SC(p, r, v)    writeb((v), (p)->membase + WR_##r)
> 
> and these:
> 
> > +#define READ_SC_PORT(p, r)     read_sc_port(p, RD_PORT_##r)
> > +#define WRITE_SC_PORT(p, r, v) write_sc_port(p, WR_PORT_##r, v)
> 
> really don't need to exist.  All they do is make the code harder to read.

but they make the code safer. The chip has common register and port
registers, which are randomly splattered over the address range. And
some of them are read only, some write only. Read only and Write
only register live at the same register offset and their function
usually doesn't have anything in common. By using these macros I'll
get compile errors when doing a READ_SC from a write only register
and vice versa. I will also get compile errors, if I try to access a
common register via READ_SC_PORT/WRITE_SC_PORT. 

If there is a better way to get more readable code for you and
the safety I'd like, just tell me.

> Think of the poor reader who sees this:
> 
> 		status = READ_SC_PORT(port, SR);
> 
> and then goes madly searching for "SR".

which he then finds by this name in the data sheet. All the register
names are named as close to the datasheet as possible. And I consider
consulting datasheets when looking at drivers a pretty good idea.

> Code is written once and is read a thousand times.  Please optimise for
> reading.

it's no big deal to change that, but is getting bitten by stupid chips
worth it ? I'd prefer to get a compile error than debugging a runtime
error.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
