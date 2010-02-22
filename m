Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 21:25:46 +0100 (CET)
Received: from [193.201.54.104] ([193.201.54.104]:59274 "EHLO hauke-m.de"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491791Ab0BVUZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2010 21:25:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 742818586;
        Mon, 22 Feb 2010 21:25:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fJzzj8Az0qBg; Mon, 22 Feb 2010 21:25:17 +0100 (CET)
Received: from [192.168.0.10] (dyndsl-085-016-167-242.ewe-ip-backbone.de [85.16.167.242])
        by hauke-m.de (Postfix) with ESMTPSA id 5D1F07E29;
        Mon, 22 Feb 2010 21:25:17 +0100 (CET)
Message-ID: <4B82E827.8030005@hauke-m.de>
Date:   Mon, 22 Feb 2010 21:25:11 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Bcm47xx: Fix 128MB RAM support
References: <1266691880-372-1-git-send-email-hauke@hauke-m.de> <20100222191440.GA12818@linux-mips.org>
In-Reply-To: <20100222191440.GA12818@linux-mips.org>
X-Enigmail-Version: 0.95.2
OpenPGP: id=95C58E7B;
        url=http://www.hauke-m.de/pgp-pubkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig419BDB8C38C823CA19751534"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig419BDB8C38C823CA19751534
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ralf Baechle wrote:
> On Sat, Feb 20, 2010 at 07:51:20PM +0100, Hauke Mehrtens wrote:
>=20
>> Ignoring the last page when ddr size is 128M. Cached
>> accesses to last page is causing the processor to prefetch
>> using address above 128M stepping out of the ddr address
>> space.
>=20
> Is this a hardware issue prefetching issue?  The kernel should not try
> CPU prefetch instructions at all on non-coherent CPUs such as the
> BCM47xx.

This is a hardware issue on the bcm47xx when 128MB ram is present. This
workaround is out of broadcom's kernel sources and is included in
OpenWRT for some months. Without this patch the kernel does not even
print out anything and with this patch it is working.

Hauke


--------------enig419BDB8C38C823CA19751534
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIcBAEBAgAGBQJLgugsAAoJEIZ0px9YPRMyjCIP/RD4Z122pNakR3zM8Bri8AyO
nHaRb0QhiSXfcbTCbKOabwWQIXoVK7p4UHqBn25zC494/NFCnc9TppDhitNrd5ey
FC3S8FAA/SQAoObPSKOdYHY2pIUWASd2V6y4iN5npEgtVCATFX2bPYepO3UWlvR5
Ib2SYPxlvUCB2B4ugAStZ6rJ9FiLou5zV6Y0/DdsuAUiZCFvEfF6Wn8h2KJmKTNV
IwUlY/xQ5P1BRZRk9+nzV20xavBCyur1Ip+TOVoeuU4n1Uircgl1q0MUXD1xmVVn
i5Yqv/4S8tVYmzORQ7ihMj6Gu7DaGmy3Q0mFzmdDA9BAfQ9mj6y8Q8n3MwQwaJ44
PaXY9l0LOvhnQOOjeO9e1m4xVA5Uh21paVYzRHVTbro+olpVgI1IGaK47648wkub
Dp5hdst/vJNfxcnHTVGvFN1Apmos3AfuoVdDlCcLt2DUEqJ25Cf8usRzhzKYeHnj
WcCixtHbBCnDomiTAsGBt2YG+AXEEk1F2CwLveQLmqgae2UYcSUZMCovkYkxJcMI
G1x9Az6r6Cu7PkSNy/kkphnXDIxeFnJkbbUkT3goYpzOXUwe6GZNpEXbsyit7NPp
cOorceTjdRcCL44YRDOQbZowx64fBxcXPneEI8qZCzzHdNqIbibw2cr1sa3CqUz7
c8smT52nKZpErm52BtpH
=EchS
-----END PGP SIGNATURE-----

--------------enig419BDB8C38C823CA19751534--
