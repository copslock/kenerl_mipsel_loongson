Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 14:36:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49099 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029272AbXI0NgJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 14:36:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8RDa8rE020589;
	Thu, 27 Sep 2007 14:36:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8RDa69e020549;
	Thu, 27 Sep 2007 14:36:06 +0100
Date:	Thu, 27 Sep 2007 14:36:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tbm@cyrius.com,
	linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070927133606.GA9562@linux-mips.org>
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl> <46FA5FFA.1060704@gmail.com> <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl> <20070927.003400.108121785.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl> <46FB65C5.2000202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FB65C5.2000202@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 27, 2007 at 10:11:49AM +0200, Franck Bui-Huu wrote:
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> Date: Thu, 27 Sep 2007 10:11:49 +0200
> To: "Maciej W. Rozycki" <macro@linux-mips.org>
> CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tbm@cyrius.com,
> 	linux-mips@linux-mips.org
> Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
> Content-Type: text/plain; charset=ISO-8859-1
> 
> Maciej W. Rozycki wrote:
> > On Thu, 27 Sep 2007, Atsushi Nemoto wrote:
> > 
> >> Current linux-queue code adds -msym32 if the load address was CKSEG0,
> >> so it can not be compiled with gcc 3.x.  I think this patch fixes the
> >> problem:
> >>
> >> http://www.linux-mips.org/archives/linux-mips/2007-03/msg00404.html
> > 
> >  It looks like it should -- why hasn't it been pushed?
> > 
> 
> I don't remember. I thought the last patchset had the fix.
> 
> Just to be sure I understand both of you correctly, could
> you confirm that in case of '-msym32' switch isn't supported,
> we should _silently_ drop this option ? That's what Atsushi
> was suggesting. But reading what Maciej wrote, it seems that
> we should notify the user...

-msym32 and previously the strategy to tell the compiler to generate 64-bit
code but the assembler to put it into 32-bit ELF was initially a hack
to get around the lack of proper 64-bit binutils support and later 
turned into a neat optimization with significant code size savings.  But
it's really just an optimization so there is nothing wrong with just
dropping the option (and whatever else goes along with it, I forgot all
the nasty details) on the floor if due to a vintage compiler it can't be
suported.

  Ralf
