Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 17:21:14 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:18358 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225220AbUKBRVK>; Tue, 2 Nov 2004 17:21:10 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP
	id D34C51EFE3; Tue,  2 Nov 2004 18:21:03 +0100 (CET)
Message-ID: <4187C26E.1090402@enix.org>
Date: Tue, 02 Nov 2004 18:22:54 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Custom kernel crashes
References: <4187AF03.5030606@enix.org> <4187BB44.4030508@mvista.com> <4187BED1.2060208@enix.org> <4187BFF8.6000905@mvista.com>
In-Reply-To: <4187BFF8.6000905@mvista.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2AD1789E08A6E7C679DEE325"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AD1789E08A6E7C679DEE325
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Manish Lachwani a écrit :

> What are these values: NPP_BOARD_INTERNAL_SRAM_BASE, 
> NPP_BOARD_INTERNAL_SRAM_END and NPP_BOARD_INTERNAL_SRAM_BASE.

#define NPP_BOARD_INTERNAL_SRAM_BASE 0xfe000000UL
#define NPP_BOARD_INTERNAL_SRAM_SIZE (256*1024)
#define NPP_BOARD_INTERNAL_SRAM_END  \
         (NPP_BOARD_INTERNAL_SRAM_BASE + NPP_BOARD_INTERNAL_SRAM_SIZE)

Do you think it's a problem related to the SRAM ?

> Also, what is ENTRYLO() defined as?

static inline unsigned long ENTRYLO(unsigned long paddr)
{
         return ((paddr & PAGE_MASK) |
                (_PAGE_PRESENT | __READABLE | __WRITEABLE | _PAGE_GLOBAL |
                 _CACHE_UNCACHED)) >> 6;
}

This code is taken from the jaguar_atx setup.c file.

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig2AD1789E08A6E7C679DEE325
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh8Jz9lPLMJjT96cRAtjSAKCA9UcrgTyv2FzL/I2TSKAhQ99tWQCdGDpS
DdoS9AJx3nn6of7qXYcc1Lo=
=5KAl
-----END PGP SIGNATURE-----

--------------enig2AD1789E08A6E7C679DEE325--
