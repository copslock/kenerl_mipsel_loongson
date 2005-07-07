Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 13:12:29 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:42400 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226161AbVGGMMM>;
	Thu, 7 Jul 2005 13:12:12 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DqVF6-0000s5-00; Thu, 07 Jul 2005 14:12:36 +0200
Received: from ths by hattusa.textio with local (Exim 4.51)
	id 1DqVF5-0007VW-Pu; Thu, 07 Jul 2005 14:12:35 +0200
Date:	Thu, 7 Jul 2005 14:12:35 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050707121235.GV1645@hattusa.textio>
References: <20050707091937Z8226163-3678+1737@linux-mips.org> <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 7 Jul 2005 ths@linux-mips.org wrote:
> 
> > Log message:
> > 	Hack to make compiles for the other endianness easier.
> 
>  Why have you complicated it that much?  AFAIK:
> 
> cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -meb
> cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mel
> 
> would work just fine with all GCC versions supported (i.e. including 
> 2.95.x).  It's true "-EL" and "-EB" are broken, also with 4.0.0 (not sure 
> if afterwards) -- it's related to an incorrect setup for the default specs 
> for Linux, but it can be avoided using these alternative options as above.

-mel/-meb aren't documented.


Thiemo
