Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 22:40:29 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993004AbeCBVkRizQDP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Mar 2018 22:40:17 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77262178D;
        Fri,  2 Mar 2018 21:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77262178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 2 Mar 2018 21:40:06 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] signals: Move put_compat_sigset to compat.h to silence
 hardened usercopy
Message-ID: <20180302214005.GC4197@saruman>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1519059306-30135-1-git-send-email-matt.redfearn@mips.com>
 <CAGXu5jKtrJ6Nmses_pM-qkXAkOPXAxwT+V3B+omqu0tx4xEh8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <CAGXu5jKtrJ6Nmses_pM-qkXAkOPXAxwT+V3B+omqu0tx4xEh8w@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 03:55:27PM -0800, Kees Cook wrote:
> On Mon, Feb 19, 2018 at 8:55 AM, Matt Redfearn <matt.redfearn@mips.com> w=
rote:
> > Move put_compat_sigset to compat.h, and mark it static inline. This
> > fixes the WARN on MIPS.
> >
> > Fixes: afcc90f8621e ("usercopy: WARN() on slab cache usercopy region vi=
olations")
> > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>=20
> Thanks for the catch and fix!
>=20
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks Kees. I've applied this on the assumption nobody objects to it
going via the MIPS tree.

Cheers
James

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZxLUACgkQbAtpk944
dnpRvw//YigCAwd1TNaLZzn3MXVqAOXsY6IAtAe7QASbMi+ovlu53XBYP74R+Kxp
8wgjmdA9SO8KjqUMWoi/M1fLnhVy/CFVE0rh4mU/4S/c3rN1gOcAAqI9C8AKApF/
yZqF40/3/1z9VzoRA3BXOcBI11iBkRbUWf3T70q0/OPlCS8eIM4dsGyRxbWPYVqs
2yYjagOQfccH68ZUPoHcWjgla5LgsreC5YPoVPtgjJO9ECxG0zFq4hcCRCUWInnu
iklEJ+E5Y/6YrwmiwiqLK3QqByKRNveXVJHnfgM07Y0C5dYPpKW1dTUxzb46A5GN
YK5IcIvaV/fzD5Q8o/ri5lu/ZmCIla5sy7CJ8hICDWWONuSBNFdqqhqCssNCAkT8
OxAHhaI4gLH4oBWRUok2ycyf/5i2BRP/zgPKVJyuTVQ/c8lurYZd51CzcPZaY558
p7FSo1YyZRp2+W6pMyqCp5Gq/BB5zu2pLKh3aB7xK8PpQxI0MDp90vG2edBZ4Qhb
LlIvcbUABn37OqvsaVvmh4XFtk3a5pFZIeBZvj6+n7+CmNHs5GVypOpqDfb92TA7
jHE4yjrvx6cDB5mZUezdinB3HRJKDr2ojvAkf7DPYrN2bina9jt6HnTcjc+DzhYj
WLT3w3H4tQGrg+AQegMo/KCUWzY3u3pqT7OR96JKp5jT/AuGfAk=
=4IQq
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
