Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 16:24:30 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:17619 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225410AbVAGQYY>; Fri, 7 Jan 2005 16:24:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id E6E064010D;
	Fri,  7 Jan 2005 17:25:06 +0100 (CET)
Message-ID: <41DEB874.8000809@enix.org>
Date: Fri, 07 Jan 2005 17:27:32 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: sjhill@realitydiluted.com
Cc: linux-mips@linux-mips.org
Subject: Re: Problem with MV64340 serial driver
References: <E1CmuxT-0002LO-TO@real.realitydiluted.com>
In-Reply-To: <E1CmuxT-0002LO-TO@real.realitydiluted.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig782374F8FC7C4109A39CC82D"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig782374F8FC7C4109A39CC82D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

sjhill@realitydiluted.com a écrit :

> My first question is, "Why?". You are aware that a serial driver already
> exists for PPC using the 64360 which is the same chip as the 64340
> except that it has a PPC 60x bus interface instead of MIPS? We do NOT
> want multiple drivers. We just went through this with the ethernet
> driver on 64340/64360. Go pull the latest stuff from:
> 
>    bk://source.mvista.com/linux-2.5-marvell
> 
> and look in 'drivers/serial/mpsc'. You should use this as your starting
> point and make the necessary changes to get it working on the 64340.
> Another serial driver will not be accepted into the kernel. Thanks.

Thanks for the information. I have been inside linux-2.5-marvell BK 
tree, but I couldn't find the drivers/serial/mpsc directory, nor to find 
the driver for the 64340 serial port.

I've used the Web interface at 
http://source.mvista.com:14690//linuxppc-2.5/src/drivers/serial?nav=index.html|src/|src/drivers

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig782374F8FC7C4109A39CC82D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3rh39lPLMJjT96cRAkm5AJ0eg8081j3+Kb7tzDLQycWZ20c6FQCdEdzP
zVLC297KxaHToPYpmt7PF5A=
=Etfg
-----END PGP SIGNATURE-----

--------------enig782374F8FC7C4109A39CC82D--
