Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 16:37:19 +0200 (CEST)
Received: from luonnotar.infodrom.org ([195.124.48.78]:2317 "EHLO
	luonnotar.infodrom.org") by linux-mips.org with ESMTP
	id <S1123926AbSJWOhS>; Wed, 23 Oct 2002 16:37:18 +0200
Received: by luonnotar.infodrom.org (Postfix, from userid 10)
	id 88DCA366B57; Wed, 23 Oct 2002 16:37:11 +0200 (CEST)
Received: at Infodrom Oldenburg (/\##/\ Smail-3.2.0.102 1998-Aug-2 #2)
	from infodrom.org by finlandia.Infodrom.North.DE
	via smail from stdin
	id <m184MUx-000og9C@finlandia.Infodrom.North.DE>
	for geert@linux-m68k.org; Wed, 23 Oct 2002 16:28:39 +0200 (CEST) 
Date: Wed, 23 Oct 2002 16:28:39 +0200
From: Martin Schulze <joey@infodrom.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Correct monochrome selection
Message-ID: <20021023142839.GG14430@finlandia.infodrom.north.de>
References: <20021019170534.GS14430@finlandia.infodrom.north.de> <Pine.GSO.4.21.0210231612060.2882-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210231612060.2882-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Return-Path: <joey@infodrom.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joey@infodrom.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Sat, 19 Oct 2002, Martin Schulze wrote:
> > please apply the patch below which will add proper handling for
> > monochrome graphic cards.
> > 
> > Both changes are required since there are graphic cards out in the
> > voi^Wwild that are monochrome but have bits_per_pixel set to something
> > else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
> > it.
> > 
> > Since currently no such card is supported, this change wasn't
> > required.  However, we developed support for the PMAG-AA card and we
> > would like to add support for it to the Linux kernel, of course.
> 
> HP300 TopCat uses a similar scheme, and is supported by Linux/m68k.

*cough*  Is there a working machine running Linux out somewhere?  If
so, I wonder why this oddity wasn't noted/didn't appear etc.

HP300 is not a really working port iirc.

Regards,

	Joey

-- 
If nothing changes, everything will remain the same.  -- Barne's Law
