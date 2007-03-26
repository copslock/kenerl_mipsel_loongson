Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 13:10:18 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32778 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022767AbXCZMKQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 13:10:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 570BAE1CC8;
	Mon, 26 Mar 2007 14:09:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PP+TerIgrTkL; Mon, 26 Mar 2007 14:09:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EA305E1C79;
	Mon, 26 Mar 2007 14:09:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2QC9gPQ023102;
	Mon, 26 Mar 2007 14:09:42 +0200
Date:	Mon, 26 Mar 2007 13:09:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>, Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
In-Reply-To: <20070326115656.GA12086@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0703261257590.16083@blysk.ds.pg.gda.pl>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp>
 <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
 <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
 <20070325144515.GB21439@networkno.de> <Pine.LNX.4.64N.0703261234260.16083@blysk.ds.pg.gda.pl>
 <20070326115656.GA12086@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2931/Mon Mar 26 10:43:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007, Ralf Baechle wrote:

> > > AFAICS this loses -mno-explicit-relocs completely, but it is needed for
> > > all non-ckseg0 CONFIG_64BIT builds.
> > 
> >  Why?  I reckon GCC should support them just fine these days.
> 
> Please remember that we officially only require GCC 3.2 or newer.  3.2
> turned out to be too broken to be supported for 64-bit builds but as long
> as there is no significant problem I'd like to keep support for these
> compiler antiques alive.

 Hmm, from the back of my head I think it should not be a problem -- IIRC 
the versions of GCC that did not support explicit relocs for 64-bit ELF 
would force "-mno-explicit-relocs" internally even if asked otherwise.  
They did not support "-msym32" either, which went in later, and then 
non-PIC support for 64-bit explicit relocs went in earlier than for PIC -- 
quite unsurprisingly, as %higher() and %highest() are not necessarily 
rocket science unlike %disp() and friends.

 If anybody cares I could probably make the excavations needed to verify 
the above.

  Maciej
