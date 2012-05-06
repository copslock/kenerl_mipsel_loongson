Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 09:34:57 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48483 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2EFHex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 09:34:53 +0200
Received: by lbbgg6 with SMTP id gg6so3592568lbb.36
        for <multiple recipients>; Sun, 06 May 2012 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=4dx8ECKyeY/p99+ZQuaB5XCz8zsx60Voaxr+w6/5O1k=;
        b=pYDtzSsmMfHyPd6UTKHiB9AprZ5E+3/uy8OlBbBx3mqwdnOg9Q+aqXLTgt13mHTHhV
         cFHoTFPPtTCz2wg8Wg4sCt3eZbODL1+Jek5m9iEg6embSwN6s1n9XxYy7NYzWdNvBS6c
         u2FjCZ9y+4tUSiFAZNh6k5BFod/4h+rRWakDvErAU0XV/oc+cnNLKIQ2pvsGBkSVmKi6
         czZRZOG3ynZP2pHGO/HMmDKdxBQbMkioAyoCQtx6SaFtXKF4ACVh7p5R++KB7CjfD5mo
         SaNfuLoNUP2O89l6OsVNeYRDBagyDZ7BWUC71vNpWeW7L/uZ5Dy5CK1zNbY9ACdZUi1D
         veKw==
Received: by 10.112.17.233 with SMTP id r9mr5368146lbd.67.1336289687443;
        Sun, 06 May 2012 00:34:47 -0700 (PDT)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id u4sm14916893lad.5.2012.05.06.00.34.45
        (version=SSLv3 cipher=OTHER);
        Sun, 06 May 2012 00:34:46 -0700 (PDT)
Message-ID: <1336289676.1996.3.camel@koala>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Sun, 06 May 2012 10:34:36 +0300
In-Reply-To: <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
         <4F9AD14E.9060008@gmail.com>
         <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-XPE24xsvL2NdTEv8aqjS"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-XPE24xsvL2NdTEv8aqjS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-05-06 at 08:04 +0100, Maciej W. Rozycki wrote:
> On Fri, 27 Apr 2012, David Daney wrote:
>=20
> > > MIPS build fails with the standard W=3D1 Kbuild switch with because o=
f the
> > > -Werror gcc switch.
> > >=20
> > > This patch removes the gcc switch to make W=3D1 work. Mips is the onl=
y
> > > architecture I know which does not build with W=3D1 and this upsets m=
y aiaiai
> > > scripts. And in general, you never know which warnings newer versions=
 of gcc
> > > will start emiting so having -Werror by default is not the best idea.
> > >=20
> > > Signed-off-by: Artem Bityutskiy<artem.bityutskiy@linux.intel.com>
> >=20
> > I think the warning messages are enough, we don't need to break things.
>=20
>  I disagree.  People generally don't fix their broken code just because i=
t=20
> triggers warnings.  The cases where GCC is genuinely confused are the=20
> minority -- and even if so, chances are the human reader of that code wil=
l=20
> also be.

Aggressive opinion, nothing more. A patch which fixes the real issue a
better way would be way more respectful.

--=20
Best Regards,
Artem Bityutskiy

--=-XPE24xsvL2NdTEv8aqjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPpimMAAoJECmIfjd9wqK0GLUP/2jpVnGbazRmuOKdKpUJPB5m
zKeIVQIi2tuSOo2VZjE69kc3pr1Jml65v6moF3yh3j9Dke9soUVuuB3g5fayxFxb
eDqamNWLTi+z2xotRVQz8/gSibytvF0I06AQQb4eA7bV22nz996lHdzGsxA6q8AG
MD4lvPdzGw9UzX6FMad9p40M1uWtuqdHQedLQQIGrk6RnnpQw54S9IHiha2fVSx+
xBHC9CqwGDm9vyrYaduMSOV6CVxLDhyB3nKHaR43itjSjnNz5rbvnzDulP4Pj0JB
gd+E1Z2RBRfUku0+yPu6o2pThGXu8BkAwbzXpPRY9ljic2mIZdAAaRKPLyycegv/
iT6xQOR/qjPfKXlAu61zbE03OUszj9y05unMe5jLeSoid2M2JXrvMDgMM8G2ibuY
VVY/g9/bYXAwUiyBmNYprK8kpDWRt4EHA34A7sS2Wp1IyRlQlJdIBAZykdIM/bre
xePOplM3US+b+EbSFjZ0z823FLmdOrtZ40qdVFmo/4qS+chGWUJekBF2KAhCxggp
WCuqdjx+yPM9X1TpCddRVukT8VkywjPQ6sIibPgrlkh2z+GIp2uNOLm0ojpysd7v
FF16jIF984ic+GgFkwtSYfxz236hGmACsLE1b78BEa63/Z+dLyRKz9bAou44X5A6
1Yzc8yLIgqJylRkONE3E
=U2uA
-----END PGP SIGNATURE-----

--=-XPE24xsvL2NdTEv8aqjS--
