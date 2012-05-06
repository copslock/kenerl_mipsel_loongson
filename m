Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 09:37:13 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35146 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2EFHhH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 09:37:07 +0200
Received: by lbbgg6 with SMTP id gg6so3593000lbb.36
        for <multiple recipients>; Sun, 06 May 2012 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=JyXRzu0dOWBcfuz1EeIf9gEDV2VNuX3olol0Osvus2g=;
        b=k6S7aCLtqVUMdMlSSOC8NiPU/nac2OsObp+QvqWV1V1OLNy+SHH3dqtvB4lwq4vAhh
         0IV+ATSF+fC0APR9Haqzx3Hn+Rs7OiSXYzgH+wr7U0uII2b92/cjQ1OK23et/KiZrqm0
         gDiTcl5feSJXEGPdWYdH5neK3/tGKf/JDfcoLgVojMSP4Xgdf+cjyrVrPABYYJA/lSON
         HEddswRBYwSK+f3B4iWb1HrtXT4VivBgzO3wK2tYYaqZ1wa5l+N4A7r3KsE8oWf0Jeyn
         QBsN3u3UCxMMRjnLeOgoDBvpIAUO4r1jEOnIqWAWgRc8yPVQn+K4LdkFp1VVDDlCpID4
         8qrg==
Received: by 10.152.123.111 with SMTP id lz15mr10826391lab.18.1336289821459;
        Sun, 06 May 2012 00:37:01 -0700 (PDT)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id uc6sm18262549lbb.3.2012.05.06.00.37.00
        (version=SSLv3 cipher=OTHER);
        Sun, 06 May 2012 00:37:00 -0700 (PDT)
Message-ID: <1336289819.1996.5.camel@koala>
Subject: Re: [PATCH 2/2] MIPS: bcm63xx: kbuild: remove -Werror
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Sun, 06 May 2012 10:36:59 +0300
In-Reply-To: <alpine.LFD.2.00.1205060804400.19691@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
         <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
         <alpine.LFD.2.00.1205060804400.19691@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-yeAv7sbnRzUmnPVNgf5D"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-yeAv7sbnRzUmnPVNgf5D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-05-06 at 08:06 +0100, Maciej W. Rozycki wrote:
> On Fri, 27 Apr 2012, Artem Bityutskiy wrote:
>=20
> > From: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>
> >=20
> > I cannot build bcm963xx with the standard Kbuild W=3D1 switch:
> >=20
> > arch/mips/bcm63xx/boards/board_bcm963xx.c: At top level:
> > arch/mips/bcm63xx/boards/board_bcm963xx.c:647:5: error: no previous pro=
totype for 'bcm63xx_get_fallback_sprom' [-Werror=3Dmissing-prototypes]
> > cc1: all warnings being treated as errors
> >=20
> > This patch removes the gcc switch to make W=3D1 work. Mips is the only
> > architecture I know which does not build with W=3D1 and this upsets my =
aiaiai
> > scripts. And in general, you never know which warnings newer versions o=
f gcc
> > will start emiting so having -Werror by default is not the best idea.
>=20
>  If the function has no prototype, then it cannot be reasonably used from=
=20
> outside -- perhaps you meant to mark it static instead?

No, I meant what I meant - MIPS does not build with W=3D1.

--=20
Best Regards,
Artem Bityutskiy

--=-yeAv7sbnRzUmnPVNgf5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPpiobAAoJECmIfjd9wqK0CWgP/09IEFhQNvpYLax535k9UJp8
l7BHh7CoIUy8UOqwz/ofe/oG7mdUgap+Lf6SV97jfGGm5wEhrqrgwFPSo1G/wv0K
MYOPcoRVizR+0WsHoksonhQ/34DlVUV7hIiOQPWv4aYeZD+npv9c49icW6z37tny
DcYuSASQs0X6MEa1Y724LD7xYqvwTB+hcnnO/C6CsPT5VKf/Ul0NeFM0eojUsuWz
lEVOps/GetRSqXLl7ft3M0kpIIk2CDJZir3QWeJyMKDGMC+r0rSaeS/bTiZDNcU7
CPx3puJKdBk2qyAz7kSG7PZSnRWLgWCdZ/n9+pa/R0YxVF+gTl1Uo2vGDGbnWJ9B
V+8cG8kFJr4bH/ZLCG/n78252tTkow555eSH1WnGJJ4DGkP2w7LlcoY13Wse+2vQ
x/2nGnFq0WPasxsv/I8iQ0JHC3jqG2bkTDqfbYbswzgAAhDsRU41OooUCIFGSSdq
mrqQoJTIYPwWiSBIJQUSJLA6UQkNT5vbSeJ4Ia4xtBCDJOa2SKiQXv48+XSos3GC
kxa9oa34EpsPiSIOb0T7gMS+f/sm3GycU7w3Dnme7WxfQT/MGmV8OB2dVhG0TmEb
Z9MYry6Lj5GhsFoiI46MLFfnUI/eQT9kOuJLnvv+x4dC5BFAGWW15Ha4Ub0ayfls
hkwaAo78S4DMR941lWpY
=sbZ9
-----END PGP SIGNATURE-----

--=-yeAv7sbnRzUmnPVNgf5D--
