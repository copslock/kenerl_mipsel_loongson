Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 15:45:05 +0100 (BST)
Received: from p508B6C3C.dip.t-dialin.net ([IPv6:::ffff:80.139.108.60]:31980
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225193AbTGUOoy>; Mon, 21 Jul 2003 15:44:54 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6LEipDB023064;
	Mon, 21 Jul 2003 16:44:51 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6LEioch023063;
	Mon, 21 Jul 2003 16:44:50 +0200
Date: Mon, 21 Jul 2003 16:44:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030721144450.GB22774@linux-mips.org>
References: <Pine.GSO.3.96.1030721124445.13489A-100000@delta.ds2.pg.gda.pl> <02a701c34f81$4f32ca50$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a701c34f81$4f32ca50$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 21, 2003 at 02:12:07PM +0200, Kevin D. Kissell wrote:

> >  Any justifiable reason for getting rid of arch/mips64?
> 
> In my opinion, it should never have existed.  The vast majority
> of MIPS-specific kernel code can be identical for 32-bit and 64-bit
> versions of the architecture.  Creating arch/mips64 (as opposed
> to arch/mips/mips64 or Ralf's arch/mips/mm-64) caused duplication 
> of modules that then needed to be maintained in parallel - but which 
> often were not.

In retroperspective it was a good think to start with and allowed us to
do some of the really intrusive change necessary without disturbing
the 32-bit stuff.  Now that things are settling down it's time to cleanup.

  Ralf
