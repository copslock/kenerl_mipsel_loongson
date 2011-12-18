Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 12:45:52 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:53550 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab1LRLps (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 12:45:48 +0100
Received: by iadk27 with SMTP id k27so6676256iad.36
        for <linux-mips@linux-mips.org>; Sun, 18 Dec 2011 03:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=eKjRWjBGbk53rad6ZTmEMFuJzAHC27UQZkfoeTTt5TI=;
        b=h4srjOCPseLDGW3rrm5DL7idT7o4tyhhwTG2y/bCzM/k44N+0DGOCtHCGRvDhCltwr
         V/zNmGPpzokWMx983jpeVoJMNREyUxQivlBZoxPt4dULSRoPKHB48vzBHumArAKE76/p
         JRi1VIfnmgofNVinMvNUWGBRt9/IlF0QHu8A0=
Received: by 10.50.171.5 with SMTP id aq5mr20232268igc.76.1324208742232;
        Sun, 18 Dec 2011 03:45:42 -0800 (PST)
Received: from [127.0.0.1] (jfdmzpr01-ext.jf.intel.com. [134.134.139.70])
        by mx.google.com with ESMTPS id mb4sm26037528igc.1.2011.12.18.03.45.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 03:45:41 -0800 (PST)
Message-ID: <1324208821.17534.0.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM
 partitions are at least 64K
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Date:   Sun, 18 Dec 2011 13:47:01 +0200
In-Reply-To: <CAOiHx=nwZ27ByyLDOXcy21x3_NJZKWU4AEJo3m3SfcposAbucA@mail.gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
         <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
         <1324157643.2240.2.camel@koala>
         <CAOiHx=nwZ27ByyLDOXcy21x3_NJZKWU4AEJo3m3SfcposAbucA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-E+Nd6eqYg0UMJjsoC+P8"
X-Mailer: Evolution 3.2.2 (3.2.2-1.fc16) 
Mime-Version: 1.0
X-archive-position: 32135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14420


--=-E+Nd6eqYg0UMJjsoC+P8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2011-12-17 at 22:57 +0100, Jonas Gorski wrote:
> On 17 December 2011 22:33, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > Not that I have any knowledge about BCM platform, but still, I think
> > it is good idea to explain why these partitions have to be at least
> > 64KiB. Could you please do this, just for the sake of having good
> > commit messages?
>=20
> Sure, no problem. Should I sent the whole series again or is a V2 of
> this one enough?

Just one patch is better - less traffic.

--=20
Best Regards,
Artem Bityutskiy

--=-E+Nd6eqYg0UMJjsoC+P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7dK1AAoJECmIfjd9wqK0MIwQAICLA0YfLdDzGAVJRknYBXYb
WP25czqUN/5tZ4jUbasSfQp/WTGyDOL6aZljCJaJ2FXDtYYNoZQgB7+i613Nn/gu
wwdRphbrjqxhfxqzSLliBxp5ltyr5Dbi6nhCSx4Yx8PIfsuG7B9gvUDfvrFnaQRc
2r+zaYnoTIINS14wwRC0KXaXGTxRnyMJryyH7BYqhTtN23Plb4MfG6uNgmScv9+8
5+pwK+dFloEAitgbhU91/wfPtp6+zdJUTwWP3bQS68GopZAf/+1UFmzOs/+fMXNV
EnBGKu9Tqedg0f7Y95xr5w3Hp6NjZYsuN/Sh3i2vxnaIyFLt0g9IOPjaJCeX8jNZ
K/jlAluVi3jnYCB0aD7siljdR+7k5NEjSBeT6EyfaRm6a71OMTFSKN3+drmf6Dpa
EYMjuL/Ic/DZtGtKoDggF8ZVSDv1pIkagSFnQz2gBmpkrDsl9nM6BozeAfXStjCh
aMUXGUMSFmzJ4ST4MoMJstJdZ9lWZkOOVhwCoYgl2ViR/Npgp5lzzIwdqy4kzHjT
oOj874RuyL7QAVqYsf4sva0F2XhGhfPEr0pHYfpAT7xGj2EY9416tbfKeXcYDOLl
KvRXZjYmxtN3Fo9oH28e9cTZ6RmqGlczI8h46tyF1/hKl8YIO/KsbefNUnO9Bv8t
Z3dOcwd3UPX3cvEGGJLV
=mlpg
-----END PGP SIGNATURE-----

--=-E+Nd6eqYg0UMJjsoC+P8--
