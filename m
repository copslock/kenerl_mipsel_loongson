Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 17:05:53 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:55477 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225205AbUKBRFs>; Tue, 2 Nov 2004 17:05:48 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP
	id E9DE51EFE3; Tue,  2 Nov 2004 18:05:41 +0100 (CET)
Message-ID: <4187BED1.2060208@enix.org>
Date: Tue, 02 Nov 2004 18:07:29 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Custom kernel crashes
References: <4187AF03.5030606@enix.org> <4187BB44.4030508@mvista.com>
In-Reply-To: <4187BB44.4030508@mvista.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7ECF95088FC6689CE7C69BB4"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7ECF95088FC6689CE7C69BB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Manish Lachwani a écrit :

> This may or may not apply to your case. Is this board still the one that 
> has the Marvell Discovery ethernet device? If yes, Marvell Discovery has 
> its SRAM located at 0xfe000000. So, make a check in the ethernet driver 
> or other board specific sources and see if there is any access to this 
> SRAM location.

The DMA buffers and DMA buffer descriptors used for the serial driver 
are all located in the SRAM of the Marvell, which is mapped using a 
wired uncached TLB entry.

Here's the code that wires the entry :

   add_wired_entry(ENTRYLO(NPP_BOARD_INTERNAL_SRAM_BASE),
                   ENTRYLO(NPP_BOARD_INTERNAL_SRAM_END),
                   NPP_BOARD_INTERNAL_SRAM_BASE,
                   PM_256K);

I would like to use ioremap() instead of wired TLB entries, but for the 
moment, I'm focusing on this crash.

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig7ECF95088FC6689CE7C69BB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh77X9lPLMJjT96cRAqoXAJ933959DI0HCYt2iA3uwjOGJUbU0gCfWDa5
C8OhunQoE9ux79awYJNCB0Q=
=6XXq
-----END PGP SIGNATURE-----

--------------enig7ECF95088FC6689CE7C69BB4--
