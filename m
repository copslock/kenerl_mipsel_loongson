Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 15:38:11 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:50326
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225248AbTDDOiJ>; Fri, 4 Apr 2003 15:38:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 4C9AE2BC2D; Fri,  4 Apr 2003 16:38:08 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 19638-08;
 Fri,  4 Apr 2003 16:38:07 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 028722BC32; Fri,  4 Apr 2003 16:38:06 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 337391735C; Fri,  4 Apr 2003 16:35:34 +0200 (CEST)
Date: Fri, 4 Apr 2003 16:35:34 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Erik J. Green" <erik@greendragon.org>
Cc: linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Unknown ARCS message/hang
Message-ID: <20030404143534.GG11906@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	"Erik J. Green" <erik@greendragon.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <20030404131935.GF11906@bogon.ms20.nix> <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 04, 2003 at 04:19:44PM +0200, Maciej W. Rozycki wrote:
> On Fri, 4 Apr 2003, Guido Guenther wrote:
> 
> > > > Obtaining /vmlinux.64 from server
> > > > 1813568+1150976+172144 entry: 0xa8000000211c4000
> > > > 
> > > > *** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018 RA=0xffffffff9fc5ace4
> > [..snip..] 
> > > 
> > >  0x211c4018 is a mapped address, which you can't use that early in a boot.
> > Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
> > seems to look at the lower 32bits of PC though.
> 
>  0xa8000000211c4000 is indeed in XKPHYS but the code jumps to 0x211c4018.
So either the PROM or (more likely) the start address in the kernel is
bogus. What does
 objdump -x vmlinux | grep 'start address'
say?
Regards,
 -- Guido
