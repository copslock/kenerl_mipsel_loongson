Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 21:54:45 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41331 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdJHTyiywX7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 21:54:38 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1Hen-0005Pk-C0; Sun, 08 Oct 2017 20:54:37 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1Hei-0001yV-2z; Sun, 08 Oct 2017 20:54:32 +0100
Message-ID: <1507492460.2677.85.camel@decadent.org.uk>
Subject: Re: Building older mips kernels with different versions of
 binutils; possible patch for 3.2 and 3.4
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 08 Oct 2017 20:54:20 +0100
In-Reply-To: <05e37183-f6a6-d141-5dad-9d4b161953b1@roeck-us.net>
References: <573936E3.3050003@roeck-us.net>
         <1507486329.2677.81.camel@decadent.org.uk>
         <d7d60beb-4875-7cbf-0fd6-26317b97115d@roeck-us.net>
         <05e37183-f6a6-d141-5dad-9d4b161953b1@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-CtvzUo0iHQnSwjoH3h+Y"
X-Mailer: Evolution 3.26.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-CtvzUo0iHQnSwjoH3h+Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2017-10-08 at 12:01 -0700, Guenter Roeck wrote:
> On 10/08/2017 11:49 AM, Guenter Roeck wrote:
> > On 10/08/2017 11:12 AM, Ben Hutchings wrote:
> > > On Sun, 2016-05-15 at 19:56 -0700, Guenter Roeck wrote:
> > > [...]
> > > > For 3.4 and 3.2 kernels to build with binutils v2.24, it would be n=
ecessary to
> > > > apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_pa=
ge' functions").
> > > > It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It m=
ight
> > > > make sense to apply this patch to both releases. Would this be poss=
ible ?
> > > > This way, we would have at least one toolchain which can build all =
3.2+ kernels.
> > >=20
> > > I'm finally queueing this up for 3.2.
> > >=20
> > > Ben.
> > >=20
> >=20
> > mipsel images in 3.2.y-queue are now crashing for me. Should I have a l=
ook ?
> >=20
>=20
> Turns out the culprit is qemu. I had switched from qemu 2.9 to qemu 2.10.
> Something has changed in qemu that causes a qemu boot failure with 3.2 mi=
psel
> (but not in more recent kernels). I'll switch back to qemu 2.9 for the af=
fected
> builds.

Thanks.  I did notice these failures but didn't think they were related
to the few MIPS patches in the 3.2 queue.

Ben.

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source


--=-CtvzUo0iHQnSwjoH3h+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlnagmwACgkQ57/I7JWG
EQksng/+Ii7w56BUaxsCvSQ4VcFJOUb8ZQlDkcc3pmAngjOyztebfndA/mFAxxGF
Qxn85qb7EQ8Y/Q1sN39aUCP82zYXGCTsj/xyzZ11fqzENQ54gfudjBmEyytim9Yt
XuCPXQ+9OdnrV4OELsCQIroOa32dNb1Ysm3AO4vrpeKiZtXXCAWP3otqo6Y6ggGr
gJBFoN7evTN9U8T7/qaKJLOrZAqjivM7jyLuT1o06/8gCtGm/DzCLWdex+4b7p/n
/a2wuUmgpJjTP/b6kQtv/3WfdkqjPNbQb/BntIrZJsu0z3st120QPMB5X2xlUjXE
iuZH8LgAo5ZL2/+SnLMA3ZPMcAahrRl+ofHAPzk7kttk81DMAiYKWysdgLAqzDxw
nTnCyCcSzIdKhkgmXKXigoODS1HY0P/bmkyHnTrfoVDzldkx6IWfB3QpIaYkmeqM
QOFJLJ7DHVSArHzfxGFW0k0yq2ztXjtBBPHEZ6u+2AtaJP0TU9ZhrRxvfYpftnN2
cR/sf7EZjbD4WVG45JjCXf5SZaAh+SN+peXgdf3f0IYWZA9eXVkJQcqHJWCxMO+3
UJOQvgcuuSRKIaZC5HB8+rLtirOQ7GUr3dZoUoIb0Cmkq9xR50Z9bRJEJhjRIvIB
BGF8rAwETwYihENuMtANrn4ZMzymigTByug9/DwxNQub02yOS2c=
=Y1Zz
-----END PGP SIGNATURE-----

--=-CtvzUo0iHQnSwjoH3h+Y--
