Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 13:48:56 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:26045 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20026852AbXKNNsr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 13:48:47 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 7519848BCD;
	Wed, 14 Nov 2007 13:34:16 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1IsIbg-0008Ol-MK; Wed, 14 Nov 2007 13:48:40 +0000
Date:	Wed, 14 Nov 2007 13:48:40 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero()
Message-ID: <20071114134840.GN8363@networkno.de>
References: <4736C1EA.2050009@gmail.com> <20071111130130.GB8363@networkno.de> <473AB0B6.2070208@gmail.com> <20071114115807.GL8363@networkno.de> <473AEB52.40501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473AEB52.40501@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
> > In general we do (think of stack unwinding etc.).  I believe this
> > implementation should move to C, as it doesn't need an assembler
> > implementation:
> > 
> > void *memset (void *s, int c, kernel_size_t n)
> > {
> > 	__fill_user(s, c, n);
> > 	return s;
> > }
> > 
> > It looks much nicer that way. :-)
> > 
> 
> Sure but memset.S was a really good place to implement memset(), wasn't
> it ?

What about using memset.c and fill_user.S ?

> And since the implementation should have been trivial,

As you found out now, nothing is trivial in assembler. :-)

> I thought it was ok to implement in assembly.

As a general rule, assembly should only be used when C doesn't cut it.


Thiemo
