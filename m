Received:  by oss.sgi.com id <S553856AbRAHQv1>;
	Mon, 8 Jan 2001 08:51:27 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:25592 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553685AbRAHQvF>; Mon, 8 Jan 2001 08:51:05 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHQlL>; Mon, 8 Jan 2001 14:41:11 -0200
Date:	Mon, 8 Jan 2001 14:41:11 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108144111.F886@bacchus.dhis.org>
References: <20010108142729.D886@bacchus.dhis.org> <Pine.GSO.3.96.1010108174155.23234M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010108174155.23234M-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 08, 2001 at 05:43:24PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 05:43:24PM +0100, Maciej W. Rozycki wrote:

> > >  What's wrong with cacheflush(addr, count, which) that actually checks if
> > > <addr; addr+count> lies within the caller's address space before
> > > performing the flush and returns -EPERM otherwise?  It would make the
> > > caller crawl like a turtle if it wished to but it would leave other
> > > processes alone. 
> > 
> > cacheflush(2) actually is supposed to handle things that way.
> 
>  Didn't I write it clearly-enough? ;-) 

return -EOVERBLOODINCAFFEIN;

  Ralf
