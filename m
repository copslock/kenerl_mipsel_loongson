Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 14:22:11 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:16534
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225202AbTDDNWK>; Fri, 4 Apr 2003 14:22:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 27EC92BC30
	for <linux-mips@linux-mips.org>; Fri,  4 Apr 2003 15:22:08 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 19269-04
 for <linux-mips@linux-mips.org>; Fri,  4 Apr 2003 15:22:07 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 3086B2BC2D
	for <linux-mips@linux-mips.org>; Fri,  4 Apr 2003 15:22:07 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 457C51735C; Fri,  4 Apr 2003 15:19:35 +0200 (CEST)
Date: Fri, 4 Apr 2003 15:19:35 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Unknown ARCS message/hang
Message-ID: <20030404131935.GF11906@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <1049427871.3e8cff9f9c50e@my.visi.com> <Pine.GSO.3.96.1030404142811.7307B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030404142811.7307B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 04, 2003 at 02:58:02PM +0200, Maciej W. Rozycki wrote:
[..snip..] 
> > Obtaining /vmlinux.64 from server
> > 1813568+1150976+172144 entry: 0xa8000000211c4000
> > 
> > *** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018 RA=0xffffffff9fc5ace4
[..snip..] 
> 
>  0x211c4018 is a mapped address, which you can't use that early in a boot.
Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
seems to look at the lower 32bits of PC though.
Puzzled,
 -- Guido
