Received:  by oss.sgi.com id <S553839AbRAHQhs>;
	Mon, 8 Jan 2001 08:37:48 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:55797 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553830AbRAHQhf>; Mon, 8 Jan 2001 08:37:35 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHQ13>; Mon, 8 Jan 2001 14:27:29 -0200
Date:	Mon, 8 Jan 2001 14:27:29 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108142729.D886@bacchus.dhis.org>
References: <010701c07986$ac768180$0deca8c0@Ulysses> <Pine.GSO.3.96.1010108162406.23234I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010108162406.23234I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 08, 2001 at 04:40:06PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 04:40:06PM +0100, Maciej W. Rozycki wrote:

> > than flushing the caches - so long as by "flush" we mean invalidate
> > with writeback (on copyback caches), of course.
> 
>  What's wrong with cacheflush(addr, count, which) that actually checks if
> <addr; addr+count> lies within the caller's address space before
> performing the flush and returns -EPERM otherwise?  It would make the
> caller crawl like a turtle if it wished to but it would leave other
> processes alone. 

cacheflush(2) actually is supposed to handle things that way.

  Ralf
