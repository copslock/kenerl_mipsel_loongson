Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 14:24:00 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:49293 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8224947AbVGTNXo>;
	Wed, 20 Jul 2005 14:23:44 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvEZg-0004SB-00; Wed, 20 Jul 2005 15:25:24 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvEZg-0006Nv-Fe; Wed, 20 Jul 2005 15:25:24 +0200
Date:	Wed, 20 Jul 2005 15:25:24 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alexander Voropay <alec@artcoms.ru>,
	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: bal instruction in gcc 3.x
Message-ID: <20050720132524.GL2071@hattusa.textio>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org> <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain> <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl> <f07e6e05072002197b529b72@mail.gmail.com> <010901c58d28$15e2a3b0$6cf9a8c0@ALEC> <Pine.LNX.4.61L.0507201347350.30702@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507201347350.30702@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 20 Jul 2005, Alexander Voropay wrote:
> 
> > 3) AFAIK (correct me), there is no MIPS-specific RELOC type for
> > the "branch"  instruction format in the BFD, so "bal" to the *external*
> > symbols is impossible.
> 
>  There is a reloc called BFD_RELOC_16_PCREL_S2 which is used for branches 
> by BFD internally, but unfortunately the original SysV ELF supplement for 
> MIPS failed to define an appropriate relocation for this purpose (there is 
> useless R_MIPS_PC16, though), so there is nothing to map this internal 
> relocation to.  There were discussions as to whether reuse R_MIPS_PC16 for 
> branches or not.  Unfortunately I don't remember the conclusion -- you'd 
> have to find it out yourself.

It is ok to reuse it, but nobody has done the work yet.


Thiemo
