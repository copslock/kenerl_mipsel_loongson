Received:  by oss.sgi.com id <S42257AbQGRVs6>;
	Tue, 18 Jul 2000 14:48:58 -0700
Received: from u-87.karlsruhe.ipdial.viaginterkom.de ([62.180.21.87]:50949
        "EHLO u-87.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42235AbQGRVsS>; Tue, 18 Jul 2000 14:48:18 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S640294AbQGRDS2>;
        Tue, 18 Jul 2000 05:18:28 +0200
Date:   Tue, 18 Jul 2000 05:18:28 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000718051828.A12440@bacchus.dhis.org>
References: <20000716182428.A972@foobazco.org> <20000717100534.D6424@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000717100534.D6424@chem.unr.edu>; from wesolows@chem.unr.edu on Mon, Jul 17, 2000 at 10:05:34AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 17, 2000 at 10:05:34AM -0700, Keith M Wesolowski wrote:

> Responding to my own mail, yeesh. I was obviously suffering a dumbass
> attack when I wrote this.
> 
> > Code;  8801eb1c <r4k_flush_cache_page_s128d16i16+74/324>
> >    8:   8ce5003c  lw      $a1,60($a3)
> > Code;  8801eb20 <r4k_flush_cache_page_s128d16i16+78/324>   <=====
> >    c:   8c62003c  lw      $v0,60($v1)   <=====
> > 
> > The fault address is 0x3c. The offset of mm in current is 0x2c. Thus
> > the immediate cause appears to be that current->mm is 0x10, obviously
> > nonsense.
> 
> The interesting bit is not current->mm, but current->mm->context. The
> offset of context is 60 as shown above in the disassembly. 60 = 3c, so
> it's clear that current->mm is in fact NULL.
> 
> Hope this makes things a bit clearer.

Indeed, it does.  I've commited a patch for this bug to cvs and would like
to hear reports.

  Ralf
