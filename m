Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 15:42:30 +0100 (BST)
Received: from p508B6C3C.dip.t-dialin.net ([IPv6:::ffff:80.139.108.60]:21228
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225193AbTGUOmS>; Mon, 21 Jul 2003 15:42:18 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6LEgFDB022995;
	Mon, 21 Jul 2003 16:42:15 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6LEgEQJ022994;
	Mon, 21 Jul 2003 16:42:14 +0200
Date: Mon, 21 Jul 2003 16:42:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030721144213.GA22774@linux-mips.org>
References: <20030720230140Z8224861-1272+3549@linux-mips.org> <Pine.GSO.3.96.1030721124445.13489A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030721124445.13489A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 21, 2003 at 12:49:55PM +0200, Maciej W. Rozycki wrote:

> > Log message:
> > 	Coarsly sort out 32-bit-only, 64-bit-only and ``portable'' MIPS memory
> > 	managment code.  Another few thousand lines of code bite the dust and
> > 	it could be even more ...
> 
>  Any justifiable reason for getting rid of arch/mips64?

Code duplication.  Thousands of lines.  I'm fedup of maintaining several
copies of a large number of files.  And stupid patches that keep forcing
things out of sync.  Multiply that pain with 2 for 2.4 and 2.6.  Not fun.

Btw, s390 also merged their two 32-bit and 64-bit architecture flavors
again; similar for parisc; it has been considered for x86-64 also.

  Ralf
