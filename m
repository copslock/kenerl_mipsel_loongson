Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 02:39:23 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36329 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009751AbcBMBjU2GnEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 02:39:20 +0100
Received: from [2a02:8011:400e:2:a11:96ff:fe28:a980] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUPB4-0003bj-7v; Sat, 13 Feb 2016 01:39:14 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUPAy-0007gv-W3; Sat, 13 Feb 2016 01:39:08 +0000
Message-ID: <1455327543.2801.79.camel@decadent.org.uk>
Subject: Re: [PATCH net-next v8 02/19] test_bitmap: unit tests for
 lib/bitmap.c
From:   Ben Hutchings <ben@decadent.org.uk>
To:     David Decotigny <ddecotig@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Date:   Sat, 13 Feb 2016 01:39:03 +0000
In-Reply-To: <1455064168-5102-3-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
         <1455064168-5102-3-git-send-email-ddecotig@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-dMEmN+NpsyqIDHiwxqFo"
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:a11:96ff:fe28:a980
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52030
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


--=-dMEmN+NpsyqIDHiwxqFo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-02-09 at 16:29 -0800, David Decotigny wrote:
> From: David Decotigny <decot@googlers.com>
>=20
> This is mainly testing bitmap construction and conversion to/from u32[]
> for now.
>=20
> Tested:
> =C2=A0 qemu i386, x86_64, ppc, ppc64 BE and LE, ARM.
>=20
> Signed-off-by: David Decotigny <decot@googlers.com>
[...]
> diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selfte=
sts/lib/bitmap.sh
> new file mode 100644

This needs to have mode 755.

Ben.

> index 0000000..2da187b
> --- /dev/null
> +++ b/tools/testing/selftests/lib/bitmap.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +# Runs bitmap infrastructure tests using test_bitmap kernel module
> +
> +if /sbin/modprobe -q test_bitmap; then
> +	/sbin/modprobe -q -r test_bitmap
> +	echo "bitmap: ok"
> +else
> +	echo "bitmap: [FAIL]"
> +	exit 1
> +fi
--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
--=-dMEmN+NpsyqIDHiwxqFo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVr6JN+e/yOyVhhEJAQoreg/8CyAqnMX0OsvT/Kq3OZbYtJ+ox8k0w7lY
QF1kUm532EjcM+eS0ebXuzngeuty2jMLnJ7d4jI6ZtMqCVt5jY4vxvsELPbYut3W
zFVW1WRatPwQA7aa4TUDprR5CuvYqpEp+EVoVUdoMRIgBgOSHHEJJSS1E2Esm4IY
7rtk1thYjbSSXqEFSR5SvVVZ+E8gkh5Awkmr2t67oxhw2aU6kzDq4TD4NP/6OeXu
OFx+hCh7BCu3kkUdkVswWvISiDbXcgKy7khDcAJSI6pvjmMz13Sl9UEOdsqwV/H9
5BRQM4FXyG6Mmc1u6M6vIwWKL5DNcstr0Zp9WA8xwkFimdA/uphCONzWTb4PQZ41
Y0PkQ3qbvAsPsuCyKIxAKi815RzYCbiUn1nhLgXvmJVCw5NHD3lkjJjqh4ejaFIP
nyUOpCJWLPeKAxmH0P1C4827mGJCAbd9zUEjamWqJ6E+NhjyTW7u6VI9yAqQv9oQ
T5cwgec4O2trPqTD2JYLxeXPTtiJQxIBh8ofW9s1V3cdIw5v3or3t2JRvKwNIy2Y
kgXpjr433jhbrxL+cgwX9bRzOmbKlK1xvJpzVze+SO7Vay8tnqlHQu3R5eoNASWs
1jNTYHbo0ARZMMqZDpS0vIAvoBJLG7oBir6qjj2NYT6aby24No5BLNALr8KZMi7X
EFKHaJ7Brcg=
=hORQ
-----END PGP SIGNATURE-----

--=-dMEmN+NpsyqIDHiwxqFo--
