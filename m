Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Mar 2017 17:05:34 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdCSQFYgHRGm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Mar 2017 17:05:24 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cpdKb-0007Qx-I6; Sun, 19 Mar 2017 16:05:21 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cpdKa-00059u-N2; Sun, 19 Mar 2017 16:05:20 +0000
Message-ID: <1489939516.2852.71.camel@decadent.org.uk>
Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for
 NF_CT_PROTO_DCCP/UDPLITE change
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Sun, 19 Mar 2017 16:05:16 +0000
In-Reply-To: <20170316142906.994447562@linuxfoundation.org>
References: <20170316142906.685052998@linuxfoundation.org>
         <20170316142906.994447562@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-AwAI9QrjXVRk/IPasf40"
X-Mailer: Evolution 3.22.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57389
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


--=-AwAI9QrjXVRk/IPasf40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-03-16 at 23:29 +0900, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.=C2=A0=C2=A0If anyone has any objections, please =
let me know.
>=20
> ------------------
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> commit 9ddc16ad8e0bc7742fc96d5aaabc5b8698512cd1 upstream.
>=20
> In linux-4.10-rc, NF_CT_PROTO_UDPLITE and NF_CT_PROTO_DCCP are bool
> symbols instead of tristate, and kernelci.org reports a bunch of
> warnings for this, like:
>=20
> arch/mips/configs/malta_kvm_guest_defconfig:63:warning: symbol value 'm' =
invalid for NF_CT_PROTO_UDPLITE
> arch/mips/configs/malta_defconfig:62:warning: symbol value 'm' invalid fo=
r NF_CT_PROTO_DCCP
> arch/mips/configs/malta_defconfig:63:warning: symbol value 'm' invalid fo=
r NF_CT_PROTO_UDPLITE
> arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for=
 NF_CT_PROTO_DCCP
> arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for=
 NF_CT_PROTO_UDPLITE
>=20
> This changes all the MIPS defconfigs with these symbols to have them
> built-in.
>=20
> Fixes: 9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite"=
)
> Fixes: c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
[...]

I don't think this was needed for 4.4 or 4.9, as those symbols were
still tristate type.

Ben.

--=20
Ben Hutchings
Power corrupts.=C2=A0=C2=A0Absolute power is kind of neat.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0- John Lehman, Secretary of the US Navy
1981-1987


--=-AwAI9QrjXVRk/IPasf40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAljOrDwACgkQ57/I7JWG
EQk+MQ/+Ljo+iMVN+U5Uon4qv/b/DyVFhgiVnBI5uZLFd2ts6M4j5TvtzlUnyTZR
u2Czrf5slrwsTbriiZ9+5qGB3ZEBEyt8UHP7+wY6VLnMQRcpMowptZeRamzPzIeN
/PKP8dsmJCmr/PqsAJ0wmj/fY47Ljip9H27JZ5xj68IYT/T9oFD5+LuQ50wfdwlY
JOINNl2Q54q8p3owbDAci9EkpRWLk7MDlKYm1XRt8ZPucOL5+NpDhZ3qiTC1OyxG
5ZeTx1tdhtXTsZnVZmJ0ctjIXNvMw/LxVaujy8UyfIpX/DhAH12bji+R2O+6FJ9i
+r4t7vAnjrwotvUBQp2Bd2zeqZlmzPq/O9pZEOzp0snoCnto6oEGhZKpOVIU8xUZ
T4YEj+7x6jdIEeqgtYyo67NQl2qMyIhor9lUWW5SLEmywfxM6hDg1LOZoiWwxRBc
SDn5AFRBzAlkNYBsomTHgoJd1nPECbAkXZHRyn2+aQAyAiCOZ9YjEDsIEAaC+Wvm
LFeJ6Se3jd6RpxZL5z4Otkn8xCxpuHZErpeuMucZgxCoCzfn6sQANuw5GBrID1bY
OwbUjagSx6uP6X85c/SwoxPYWZez+p2OmisUwubjAL58H+1GnVX4IoDpYg/sLBHx
r8pmNAcSUtIBNZE0DUw2po4EUDx/tiDaxtPQjboCGvGY3goDato=
=s7xs
-----END PGP SIGNATURE-----

--=-AwAI9QrjXVRk/IPasf40--
