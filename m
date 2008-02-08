Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 19:05:33 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:42920 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28576310AbYBHTF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 19:05:26 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 9F2AE48916;
	Fri,  8 Feb 2008 20:05:20 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JNYXH-0004s2-E6; Fri, 08 Feb 2008 19:05:19 +0000
Date:	Fri, 8 Feb 2008 19:05:19 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, Kumba <kumba@gentoo.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080208190519.GA2188@networkno.de>
References: <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org> <20080206085610.GA20751@paradigm.rfc822.org> <20080206142217.GA7633@linux-mips.org> <20080208172316.GD25893@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080208172316.GD25893@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> On Wed, Feb 06, 2008 at 02:22:17PM +0000, Ralf Baechle wrote:
> > On Wed, Feb 06, 2008 at 09:56:10AM +0100, Florian Lohoff wrote:
> > 
> > > No - the very same GLIBC does not work on mips1 machines and vice versa.
> > > Might by okay for gentoo but debian needs a run everywhere glibc which
> > > means some ld.so tricks like with the libc6-i686 to load a different
> > > glibc from my understanding.
> > 
> > There is the long standing plan to generate a shared library on on the
> > fly during kernel initialization and move atomic operations and performance
> > relevant functions like memcpy to it.  Thiemo's latest work on tlbex.c
> > got us a tiny step closer to that.
> 
> You mean a single page in every processes address space or some
> /proc/sys/kernel/libatomic.so which would be a really cool hack?

We probably want to call it librandom-stuff.so. :-)


Thiemo
