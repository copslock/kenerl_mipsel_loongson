Received:  by oss.sgi.com id <S553751AbRCGTPI>;
	Wed, 7 Mar 2001 11:15:08 -0800
Received: from ns.snowman.net ([63.80.4.34]:24585 "EHLO ns.snowman.net")
	by oss.sgi.com with ESMTP id <S553726AbRCGTPB>;
	Wed, 7 Mar 2001 11:15:01 -0800
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id OAA05183;
	Wed, 7 Mar 2001 14:14:51 -0500
Date:   Wed, 7 Mar 2001 14:14:51 -0500 (EST)
From:   <nick@snowman.net>
X-Sender: nick@ns
To:     Rafal Boni <rafal.boni@eDial.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Problem makeing an O2 run bootp 
In-Reply-To: <200103071911.OAA15309@ninigret.metatel.office>
Message-ID: <Pine.LNX.4.21.0103071414220.2408-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Thanks much.  I'll try that.  It has also been suggested that O2s probably
refuse all packets with DF set, so I will attempt to fix that as well.
	Nick

On Wed, 7 Mar 2001, Rafal Boni wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> In message <Pine.LNX.4.21.0103062231010.23542-100000@ns>, you write: 
> 
> - -> I've got an o2 that I'm trying to make netboot, and it seems to work,
> - -> however the o2 never acks the tftp packets.  The tcpdump is attached.  If
> - -> anyone has suggestions/ideas I'd love to hear them.  I booted the o2 and
> - -> ran "bootp():" from the arc prompt.
> 
> I had issues with my Indigo2 where the PROM rejected all TFTP packets 
> from ports > 32767 (but that's with a stone-age PROM, I imagine O2's 
> would have a somewhat more modern PROM).  
> 
> Also, try 'setenv DEBUG 1' (dunno if that does or doesn't work on the
> O2, it does on the Indigo2) in the PROM and see if it gives any tell-
> tale output.
> 
> - --rafal
> 
> - ----
> Rafal Boni                                              rafal.boni@eDial.com
>  PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
>     Need to get a hold of me?  http://800.edial.com/rafal.boni@eDial.com
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.0 (GNU/Linux)
> Comment: Exmh version 2.1.1 10/15/1999
> 
> iD8DBQE6pofVEeBxM8fTAkwRAmNfAKDsC3yF1WmIZUK9i7Pu+VCR/iy3DACfQjIq
> NlO8XXf87pp0cJkVDTw/tAY=
> =gc8M
> -----END PGP SIGNATURE-----
> 
