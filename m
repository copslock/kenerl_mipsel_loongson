Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 08:45:41 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:7652 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225210AbULJIpg>; Fri, 10 Dec 2004 08:45:36 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id E28871ED43;
	Fri, 10 Dec 2004 09:44:50 +0100 (CET)
Message-ID: <41B96281.2050806@enix.org>
Date: Fri, 10 Dec 2004 09:46:57 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Matthew Starzewski <mstarzewski@xes-inc.com>
Cc: linux-mips@linux-mips.org, Steve.Finney@SpirentCom.COM
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode, revisited
References: <062301c4de41$5bf43cb0$0d00340a@matts>
In-Reply-To: <062301c4de41$5bf43cb0$0d00340a@matts>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig256EBE984477A4D7916A1FA9"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig256EBE984477A4D7916A1FA9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Matthew Starzewski a écrit :
> I've tried to enable HIGHMEM to access all 512MB of
> SDRAM on a BCM1125 based board as per this previous
> thread:
>  
> Using more than 256 MB of memory on SB1250 in 32-bit mode :
> http://www.spinics.net/lists/mips/msg14396.html
> BCM1125 Board: XPedite3000 PrPMC
> http://www.xes-inc.com/Products/XPedite/XPedite3000/XPedite3000.html

I'm really unsure of what I'll say, but I've seen people on this list 
talking about CONFIG_DISCONTIGMEM, an option for the kernel, which is :

"Say Y to upport efficient handling of discontiguous physical memory,
  for architectures which are either NUMA (Non-Uniform Memory Access)
  or have huge holes in the physical address space for other reasons.
  See <file:Documentation/vm/numa> for more."

Maybe it's what you're looking for, maybe not.

I'm still very surprised that Linux cannot handle strange physical 
memory configuration simply (holes in physical memory, DMA memory at 
higher addresses than normal memory).

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig256EBE984477A4D7916A1FA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBuWKE9lPLMJjT96cRAhepAKCJXMrSWgpCpPzY5te6FaRItuB9MwCfd5v+
wc8HN2ZcddQrQosHBnkMQXs=
=RAZP
-----END PGP SIGNATURE-----

--------------enig256EBE984477A4D7916A1FA9--
