Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 02:04:53 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36212 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011744AbcBMBEvsOoFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 02:04:51 +0100
Received: from [2a02:8011:400e:2:a11:96ff:fe28:a980] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUOdf-0001yF-CI; Sat, 13 Feb 2016 01:04:43 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUOda-0007b4-4v; Sat, 13 Feb 2016 01:04:38 +0000
Message-ID: <1455325472.2801.73.camel@decadent.org.uk>
Subject: Re: [PATCH net-next v8 01/19] lib/bitmap.c: conversion routines
 to/from u32 array
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
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Date:   Sat, 13 Feb 2016 01:04:32 +0000
In-Reply-To: <1455064168-5102-2-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
         <1455064168-5102-2-git-send-email-ddecotig@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-SoZ15GJO7MTtLdasxqMl"
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:a11:96ff:fe28:a980
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52029
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


--=-SoZ15GJO7MTtLdasxqMl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-02-09 at 16:29 -0800, David Decotigny wrote:
> From: David Decotigny <decot@googlers.com>
>=20
> Aimed at transferring bitmaps to/from user-space in a 32/64-bit agnostic
> way.
>=20
> Tested:
> =C2=A0 unit tests (next patch) on qemu i386, x86_64, ppc, ppc64 BE and LE=
,
> =C2=A0 ARM.
>=20
> Signed-off-by: David Decotigny <decot@googlers.com>

Reviewed-by: Ben Hutchings <ben@decadent.org.uk>

[...]

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
--=-SoZ15GJO7MTtLdasxqMl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVr6BIOe/yOyVhhEJAQqiyQ/8D8DlXKxG4ASRdvf3Gte7dXZDg8Bv/oQG
M8Cc6bJjkqAPaIvUBuSEQNYc0kVWoRE0B4nz0hN8tb/OKHW7lw6JOvButoU7eaTS
05tpY35akzhIawmy7E9h5dk+6f0dPAwPdAOyHqN0nZPfpxPr9PntByoW/yRiXsW7
+3pKi8OAi49gdMJiC+0EsfpD6X+t/hw/sg7iU0+YwQjhaHhU1B+Mba8SFq9Vxl+q
dZe2MvZbSn1UwhDbnKK5WWrcLJgSg2OVb6WyuYx0b/ntjnC57mFt4UPd8suwFkXa
mooS9XQxaTILYNrDBBpHXs+l4ZE6WAIlqRTQKWe3sImfdYqsvG0aclPHQgtNY6He
CGIudsz/6x9mrhe48aY+L961XHJNDZpGb665qK6Qvw/u0VTW8xw0yD+mMKbza6Pn
g9VwRz+VBET1/ZZW3BPBziyvW4W0GS5Jsi7g2QxaVugBQ6Oc5Qkronx1/GQCXS1W
vfU/vzRnyTkZrZOMg5o4uUcM/2RspQiznc+KpstRn7SgIcklBPQ76ArSfaWdD+i3
UlkrJUih+OAHFlsCyre6jGd9ThnYyuNDvXA7kVzAgT//Yhj01ynu0YgVr7YJ7PtY
OTyEQjy1U89EOBsRlwvdV+zexnbrpwe5bqSjMSXrdXAfKXq8H+uvaRv0XlydS1ZO
0uU79RpTMaI=
=tBPL
-----END PGP SIGNATURE-----

--=-SoZ15GJO7MTtLdasxqMl--
