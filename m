Received:  by oss.sgi.com id <S553728AbRCGTMI>;
	Wed, 7 Mar 2001 11:12:08 -0800
Received: from [63.148.55.4] ([63.148.55.4]:14580 "EHLO
        ninigret.metatel.office") by oss.sgi.com with ESMTP
	id <S553695AbRCGTLz>; Wed, 7 Mar 2001 11:11:55 -0800
Received: from ninigret.metatel.office (IDENT:rafal@localhost.metatel.office [127.0.0.1])
	by ninigret.metatel.office (8.9.3/8.8.8) with ESMTP id OAA15309;
	Wed, 7 Mar 2001 14:11:17 -0500
Message-Id: <200103071911.OAA15309@ninigret.metatel.office>
From:   Rafal Boni <rafal.boni@eDial.com>
To:     nick@snowman.net
Cc:     linux-mips@oss.sgi.com
Subject: Re: Problem makeing an O2 run bootp 
In-Reply-To: Your message of "Tue, 06 Mar 2001 22:36:45 EST."
             <Pine.LNX.4.21.0103062231010.23542-100000@ns> 
X-Mailer: NMH 1.0 / EXMH 2.0.3
Date:   Wed, 07 Mar 2001 14:11:17 -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

In message <Pine.LNX.4.21.0103062231010.23542-100000@ns>, you write: 

- -> I've got an o2 that I'm trying to make netboot, and it seems to work,
- -> however the o2 never acks the tftp packets.  The tcpdump is attached.  If
- -> anyone has suggestions/ideas I'd love to hear them.  I booted the o2 and
- -> ran "bootp():" from the arc prompt.

I had issues with my Indigo2 where the PROM rejected all TFTP packets 
from ports > 32767 (but that's with a stone-age PROM, I imagine O2's 
would have a somewhat more modern PROM).  

Also, try 'setenv DEBUG 1' (dunno if that does or doesn't work on the
O2, it does on the Indigo2) in the PROM and see if it gives any tell-
tale output.

- --rafal

- ----
Rafal Boni                                              rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
    Need to get a hold of me?  http://800.edial.com/rafal.boni@eDial.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6pofVEeBxM8fTAkwRAmNfAKDsC3yF1WmIZUK9i7Pu+VCR/iy3DACfQjIq
NlO8XXf87pp0cJkVDTw/tAY=
=gc8M
-----END PGP SIGNATURE-----
