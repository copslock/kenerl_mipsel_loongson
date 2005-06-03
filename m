Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 12:32:51 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:9240 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226156AbVFCLcg>; Fri, 3 Jun 2005 12:32:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j53BUn84014007;
	Fri, 3 Jun 2005 12:30:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j53BUl2R014006;
	Fri, 3 Jun 2005 12:30:47 +0100
Date:	Fri, 3 Jun 2005 12:30:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050603113047.GB11061@linux-mips.org>
References: <20050603022113Z8226140-1340+8064@linux-mips.org> <20050603092205.GA4573@linux-mips.org> <20050603102140.GA1610@hattusa.textio> <Pine.LNX.4.62.0506031311200.16362@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506031311200.16362@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 03, 2005 at 01:12:03PM +0200, Geert Uytterhoeven wrote:

> On Fri, 3 Jun 2005, Thiemo Seufer wrote:
> > --- include/asm-mips/hazards.h	3 Jun 2005 02:21:07 -0000	1.1.2.3
> > +++ include/asm-mips/hazards.h	3 Jun 2005 10:16:28 -0000
> > @@ -46,6 +46,7 @@
> >  #define mtc0_tlbw_hazard						\
> >  	b	. + 8
> >  #define tlbw_eret_hazard
> 
> Missing backslash at end of line?


Some processors have a 0-cycle hazard between a tlb write and eret.

  Ralf
