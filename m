Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 04:30:50 +0100 (CET)
Received: from forward106p.mail.yandex.net ([77.88.28.109]:47973 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbeARDanVHi3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 04:30:43 +0100
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 9BBDA2D82D05;
        Thu, 18 Jan 2018 06:30:33 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hacqDg0MbX-UWjupbSA;
        Thu, 18 Jan 2018 06:30:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516246233;
        bh=i+K5eXL7q8ZG32rudBpohJwQOBdJPp2VC5ls+1pvnG8=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=idGIVVFQWbCvss2kDhixRo1wz0BiDCTBeiGxEeKcIL4y3q66DE9AteRhjGfbGTF82
         KTq6Ot+o/xLFDP/Hdv5AgGASw60IvffIY0cmEnQq79o84mBnWWFyc79+EKL3xu91UN
         0AS0I628cVoxrw+l+oGKZeU7snRq21Ql8b+Dlo08=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 9z0J0CK4o6-UUviTxaO;
        Thu, 18 Jan 2018 06:30:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516246231;
        bh=i+K5eXL7q8ZG32rudBpohJwQOBdJPp2VC5ls+1pvnG8=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=p7KXMwCKjUMsQvHOZC49sCSL346LSrYtem1xKComCmyMcGpZjiXxh3+PQmdOL2zI2
         kLpcnmVDzaQnOj3qCAaHgilyQi5lRxQ9g1E6MPNhtvx7XahU64+gnmqZ2qjY/BmZAz
         SQt7LqhE7rSZupj+jA68XUYwcnsKfOzV291P0T40=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: About Loongson platforms' directories
Date:   Thu, 18 Jan 2018 11:30:24 +0800
Message-ID: <2742517.CtLEXR2uX9@flygoat-x230>
User-Agent: KMail/5.2.3 (Linux/4.14.0-2-rt-amd64; KDE/5.37.0; x86_64; ; )
In-Reply-To: <CANc+2y4-Y9vb26K4Re8seR8vwrp4v2v8EzqsO9i-iZqWPuf41Q@mail.gmail.com>
References: <1516182767.23672.1.camel@flygoat.com> <2307410.P6mT3GKBU8@flygoat-x230> <CANc+2y4-Y9vb26K4Re8seR8vwrp4v2v8EzqsO9i-iZqWPuf41Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4642449.heELgOEIkd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--nextPart4642449.heELgOEIkd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On 2018=E5=B9=B41=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=89 CST =E4=B8=
=8B=E5=8D=8810:04:46 PrasannaKumar Muralidharan wrote:

>=20
> It is possible to use DT even if boot loader does not supply it. The
> dtb can be append to the kernel and kernel can be configured to pick
> it up.

Hi PrasannaKumar

Yes I know about that. But I think it's not necessary to introduce DT suppo=
rt=20
for current Loongson platforms. Now, all machines with same SoC or CPU or M=
CU=20
can share their kernel. 2E/2F differ platforms by machtype, 3 is using EFI=
=20
just like DT. For loongson-mcu their is only one reference design in kernel=
=2E=20
Introduce DT support will make whole boot progress more complex.

Loongson-2K have DT support in bootloader.

>=20
> I think James is talking about having little to no platform code in
> arch/mips/loongson/. It is preferred to have Loongson specific drivers
> in driver/<hw-specific-framework> as it would help using common code
> the framework provides. Any change to driver will go via the
> respective framework maintainer (for example change to Loongson rtc
> driver can be submitted to the rtc maintainer) which will reduce mips
> maintainer burden and also increases responsiveness in getting the
> changes merged.

Yeah, some drivers should put into their own subsystems. That's what we'll =
do=20
during seprate the machs. But other drivers such as PM or PCI can only put =
in=20
MIPS arch. Platform code should be reduced by DT and EFI, but for older=20
systems (2e/2f), we still need some platform code. Since there will be no m=
ore=20
new device for these systems, I think it's acceptable.
=20
=2D-
Jiaxun Yang
--nextPart4642449.heELgOEIkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlpgFNAACgkQwRGUkHP8
D2cuXxAAlpeoMay/X8WOzuEKiNbWHCXHZBft2xFcMzkL31x4OpYmXgC9mHFThaXZ
+GW1cQl+UtYHR66owlvBq/6+rxEEnxRtgn0DnUxcHIxIRbG0l5OEpNTFBSq7gP+4
kyCnbSdGKRuDkxWQYQMbCb3Y38dRgVLTzqcVFkV378st9YGgOd6ZbY6JCEpCxUjK
nM++bP7vD774BeNKbNoZ/Os5L/UrmHgvErDnSXZOknNoKv0BqvU0wCqk8zctud6N
dnWvaNAfm8C+bAFKZXtoJRp6CkLuiiVNwUyufrYSTKGz3jrkAuRfruM1tzz94Utz
gen7DebQaLf8kN3r72n13BfIsz+UwjVub+uiverNYyc/xBF1BlZe+XhPAWByckyb
hi50ItmhqdDhjTcivYkwyUOzqEU7Icg2lK1yW/NGq6mmNJP6Rww00Tzph8x82L31
0SG4NJmLTZbSYxEdCzOrOQTAdbiRPiUCt8bx+V2tYhUwCKmF15vlWcWJpOuoC1cy
1MDG30Ewx8hwsTMwKlfxlicBSX300AO44QxnzjdcroAwj7Pf7efjNkSYUDCPQyK7
MWK98escFU5/jVuA8KAzazMZAeF5xrkhynHa2LZc82p7/BWIHOCxOetS62EAxnWY
P8RJ7UeEVu13dOzbtUuhzIe05dzvX50/nBWcNjFnv8mKAcI6788=
=P+Zr
-----END PGP SIGNATURE-----

--nextPart4642449.heELgOEIkd--
