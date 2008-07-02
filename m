Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 11:14:05 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:14793 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S62065707AbYGBKN6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 11:13:58 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id AE71448916;
	Wed,  2 Jul 2008 12:13:57 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KDzLY-00026W-LX; Wed, 02 Jul 2008 11:13:56 +0100
Date:	Wed, 2 Jul 2008 11:13:56 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080702101356.GB7007@networkno.de>
References: <87y74pxwyl.fsf@firetop.home> <20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zlp149ot.fsf@firetop.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> > We've shipped our version.  Richard's version has presumably also
> > shipped.
> 
> Right.
> 
> > We did negotiate the ABI changes with MTI; this is not quite
> > as good as doing it in full view, but it was the best we could manage
> > and MTI is as close to a central authority for the MIPS psABI as
> > exists today.
> >
> > Richard, what are your thoughts on reconciling the differences?  You
> > can surely guess that I want to avoid changing our ABI now, even for
> > relatively significant technical reasons - I'm all ears if there's a
> > major reason, but in the comparisons I do not see one.
> 
> I suppose I still support the trade-off between the 5-insn MIPS I stubs
> (with extra-long variation for large PLT indices) and the absolute
> .got.plt address I used.  And I still think it's shame we're treating
> STO_MIPS_PLT and STO_MIPS16 as separate; we then only have 1 bit of
> st_other unclaimed.
> 
> However, IMO, your argument about MTI being the central authority
> is a killer one.  The purpose of the GNU tools should be to follow
> appropriate standards where applicable (and extend them where it
> seems wise).  So from that point of view, I agree that the GNU tools
> should follow the ABI that Nigel and MTI set down.  Consider my
> patch withdrawn.
> 
> TBH, the close relationship between CodeSourcery and MTI
> make it difficult for a non-Sourcerer and non-MTI employee
> to continue to be a MIPS maintainer.  I won't be in-the-know
> about this sort of thing.
> 
> I've been thinking about that a lot recently, since I heard about
> your implementation.  I kind-of guessed it had been agreed with MTI
> beforehand (although I hadn't realised MTI themselves had written
> the specification).

The specification is a co-production of MTI and CS. I believe the
reason why it wasn't discussed in a wider audience is that it occured
to nobody there could be a parallel effort going on after all those
years!

> Having thought it over, I think it would be best
> if I stand down as a MIPS maintainer and if someone with the appropriate
> commercial connections is appointed instead.  I'd recommend any
> combination of yourself, Adam Nemet and David Daney (subject to
> said people being willing, of course).

FWIW, I believe a person who is _not_ in the midst of the commercial
pressures adds valuable perspective as a maintainer.


Thiemo
