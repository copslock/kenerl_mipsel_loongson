Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 11:58:58 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:64820
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225221AbUHWK6y>; Mon, 23 Aug 2004 11:58:54 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NAwoQX019799;
	Mon, 23 Aug 2004 12:58:50 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NAwoHH019798;
	Mon, 23 Aug 2004 12:58:50 +0200
Date: Mon, 23 Aug 2004 12:58:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040823105850.GA19125@linux-mips.org>
References: <20040820120223Z8225206-1530+8785@linux-mips.org> <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl> <4129BECB.7000508@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129BECB.7000508@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 05:54:19AM -0400, Kumba wrote:

> procps is probably the trigger of this.  Me and some other Gentoo/MIPS 
> devs/users got into a bit of a heated discussion w/ the procps 
> maintainer, who didn't quite like the fact that A) We don't use 
> "sanitized" kernel headers B) PAGE_SIZE was hidden on MIPS and C) 
> "properly sanitized" headers would provide PAGE_SIZE.  We opted instead 
> for a patch to procps that used sysconf(_SC_PAGESIZE) to fetch the 
> value, and I guess this just didn't rub the right way w/ the maintainer. 

Who happens to be Albert Calahan, just to mention the name.

As for the sanitized kernel headers package he's probably right.  At the
current state of Linux kernel headers - all architectures, not just MIPS -
mail threads like this will be unavoidable if we try to continue
supporting kernel headers in userspace.  I can be convinced to support
such use to the same point as i386 but not a single symbol beyond that.

> I can post the discussions for those interested (or just looking for 
> amusement), and anyone curious enough can look at proc/procps.h in the 
> procps tree for a rather amusing (IMHO) comment on MIPS at the top of 
> the source.

Whoever wrote that has a very screwed idea of the MIPS realities.

  Ralf
