Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 13:22:26 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:33732 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8226161AbVGGMWD>;
	Thu, 7 Jul 2005 13:22:03 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DqVOd-00047i-00; Thu, 07 Jul 2005 14:22:27 +0200
Received: from ths by hattusa.textio with local (Exim 4.51)
	id 1DqVOc-0007Yq-N0; Thu, 07 Jul 2005 14:22:26 +0200
Date:	Thu, 7 Jul 2005 14:22:26 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050707122226.GW1645@hattusa.textio>
References: <20050707091937Z8226163-3678+1737@linux-mips.org> <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio> <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 7 Jul 2005, Thiemo Seufer wrote:
> 
> > -mel/-meb aren't documented.
> 
>  They are:
> 
> $ gcc -v --help 2>/dev/null | egrep 'mel|meb'
>   -mel                      Use little-endian byte order
>   -meb                      Use big-endian byte order
> 
> They are not in the info pages, but that should probably be considered an 
> accidental omission.  Is using something that's documented but doesn't 
> work, to the contrary, any better?

Probably not. It's just that I've never seen actual use of -mel/-meb yet.


Thiemo
