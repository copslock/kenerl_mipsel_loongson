Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 15:32:43 +0100 (BST)
Received: from p508B7EE4.dip.t-dialin.net ([IPv6:::ffff:80.139.126.228]:49083
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225252AbTFDOcl>; Wed, 4 Jun 2003 15:32:41 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h54EWXbY007586;
	Wed, 4 Jun 2003 07:32:34 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h54EWWwH007561;
	Wed, 4 Jun 2003 16:32:32 +0200
Date: Wed, 4 Jun 2003 16:32:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Krishnakumar. R" <krishnakumar@naturesoft.net>,
	linux-mips@linux-mips.org
Subject: Re: Single stepping in mips
Message-ID: <20030604143232.GF25456@linux-mips.org>
References: <20030604055319.GB8778@linux-mips.org> <Pine.GSO.3.96.1030604161038.18707C-100000@delta.ds2.pg.gda.pl> <20030604142548.GA19282@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604142548.GA19282@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 10:25:48AM -0400, Daniel Jacobowitz wrote:

> >  In a more finegrained but also more complicated example, you probably
> > want to insert a breakpoint in the delay slot first and at the second step
> > evaluate the branch's condition and put a breakpoint at the next
> > instruction to be executed.  I'm not sure if the current version of gdb
> > does the first step, but it inserts a single breakpoint in the second one
> > only.  For branch likely instructions adjust the two steps as necessary. 
> 
> Does that actually work reliably across MIPS processors?  I don't
> believe that it will.  I suppose you could re-execute the branch to get
> the delay slot executed...

It should.

  Ralf
