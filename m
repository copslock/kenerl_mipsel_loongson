Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 14:31:24 +0100 (CET)
Received: from forward105p.mail.yandex.net ([77.88.28.108]:48382 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeABNbQX1Ou2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 14:31:16 +0100
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 661CD4082AD6;
        Tue,  2 Jan 2018 16:31:10 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id a1Mw8NY5Xn-V97CbTIM;
        Tue, 02 Jan 2018 16:31:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514899870;
        bh=kY362TJwvfpm/RKdTDXeygP5ZUlIXVg9sx5TijnXdvE=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=S6gZ7h5/sDB51qIIAu/sJnn7gc8rotOQnW57TKolZd7baJ2kqCWCHOVGp88jmVT94
         qy/EZM4qwY7Q96/xz+Gtyqqq+rrONYf2N2mIKt2+ROXEzC1ZE6xORUOjNzEv5zfoL2
         uOPtHgwwgismCZfgcsgdfOK8dL8ZyZAQOrwhYjsg=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nAU1d9GSIs-V5jaVLDg;
        Tue, 02 Jan 2018 16:31:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514899868;
        bh=kY362TJwvfpm/RKdTDXeygP5ZUlIXVg9sx5TijnXdvE=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=vruGbL/mpzovmOC22Aem7Odt3QIOZvpXEM2NPyDUrM4ELTvert8f6ItqgKpsvskrT
         eELtldgdYzUkkf/Q6wqRDJcMBycuwJ/jb/jCSPFHn0EtkYlWOYet9A98HI1g6Vh6nb
         mBSLNd/XQnTHv8pPGwDIIaMxyCrpCx/Bcroc9MPs=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1514899786.1694.6.camel@flygoat.com>
Subject: Re: [PATCH] MIPS: Loongson64: Drop 32-bit support for Loongson
 2E/2F devices
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Jan 2018 21:29:46 +0800
In-Reply-To: <20180102084759.GL5027@jhogan-linux.mipstec.com>
References: <20171226042138.13227-1-jiaxun.yang@flygoat.com>
         <20180102084759.GL5027@jhogan-linux.mipstec.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LNNzY7WAO/8auJxPJvMY"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61826
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


--=-LNNzY7WAO/8auJxPJvMY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2018-01-02 Tue 08:48 +0000=EF=BC=8CJames Hogan Wrote=EF=BC=9A
> On Tue, Dec 26, 2017 at 12:21:38PM +0800, Jiaxun Yang wrote:
> > Make loongson64 a pure 64-bit mach.
>=20
> Please expand to provide some rationale behind the change. Was 32-bit
> support broken at runtime, or broken at build time, or are we simply
> no

The 32-bit support was broken at runtime, it doesn't boot anymore,
witch is hard to debug because even early printk isn't working, also
there are some build warnings. Some newer bootloader may not support
32-bit ELF. So we decide to drop 32-bit support.

Jiaxun

> longer interested in supporting it?
>=20
> Cheers
> James
>=20
> >=20
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  arch/mips/loongson64/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/arch/mips/loongson64/Kconfig
> > b/arch/mips/loongson64/Kconfig
> > index 0d249fc3cfe9..a7d9a9241ac4 100644
> > --- a/arch/mips/loongson64/Kconfig
> > +++ b/arch/mips/loongson64/Kconfig
> > @@ -17,7 +17,6 @@ config LEMOTE_FULOONG2E
> >  	select I8259
> >  	select ISA
> >  	select IRQ_MIPS_CPU
> > -	select SYS_SUPPORTS_32BIT_KERNEL
> >  	select SYS_SUPPORTS_64BIT_KERNEL
> >  	select SYS_SUPPORTS_LITTLE_ENDIAN
> >  	select SYS_SUPPORTS_HIGHMEM
> > @@ -49,7 +48,6 @@ config LEMOTE_MACH2F
> >  	select ISA
> >  	select SYS_HAS_CPU_LOONGSON2F
> >  	select SYS_HAS_EARLY_PRINTK
> > -	select SYS_SUPPORTS_32BIT_KERNEL
> >  	select SYS_SUPPORTS_64BIT_KERNEL
> >  	select SYS_SUPPORTS_HIGHMEM
> >  	select SYS_SUPPORTS_LITTLE_ENDIAN
> > --=20
> > 2.15.1
> >=20
--=-LNNzY7WAO/8auJxPJvMY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlpLiUoACgkQwRGUkHP8
D2fAaBAAhdChxcc5FO55HxcBavFetEQadYehVWZUoKDzo/SPfAWkQJJ4hvXBJoOX
DH/0YelGB+wCOIJuD9N9nIhOQ5TkooL1K0MYZc8WGMd86hpOiRySshClBYy/U+t8
AhS0yRwifGeOkoCr6RdlCPidlAZQYOE00f/ir3oNWtK+XFGn3psf5q9LxfjuE/Rc
510a+Jb6VNnOULUWohFvbRHW7MsTrGECUH/z7F8wJD5XOh0LcU/ESnloxRYQTJWC
1nsuXteeakvp6WZqt5E+2cPqYgp0nUYsDbNK1noJGlg2u9M5ep8FCmy3w78DnY+Q
LCBmvpDdstgT+bd9G/ZsmmCzHWL9aC5dR8VWlULDKMtat0lgQkXVRetn2kWEhGyB
T0mZMrnrFt0TUvGMf3s+2Hvvc/ccfSVCCdxBpsnKgn1n4YKXWTl4XwEgi4g3mdCP
ogEBBcmKk2Yaz6lq88/MSIRpjvBKjAspM+nD4QNstP2s3nc8bzqlVAUY2DapVlek
etwjRgIHtLduqSgVG+rVhzJrThsCghFfuXd2NTNVyo7bRn2dbAFvSiGADm2yrXFX
x1m5uh4goqqH2fREdTXMSYw6ijBOOHj52CzJOdr14Vh6qjHqlK+0o8DcgCu9T4BZ
kSqFX7K48KiYI7FQr8s7qgI2Gdjr6om06CYcwwlMGAxhuAN8POI=
=X4Js
-----END PGP SIGNATURE-----

--=-LNNzY7WAO/8auJxPJvMY--
