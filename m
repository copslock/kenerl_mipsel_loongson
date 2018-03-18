Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 00:49:52 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33478 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994697AbeCRXtp6fugC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 00:49:45 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1exi3c-0004rD-O9; Sun, 18 Mar 2018 23:49:44 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1exi3X-0002GU-HL; Sun, 18 Mar 2018 23:49:39 +0000
Message-ID: <1521416975.2495.186.camel@decadent.org.uk>
Subject: Re: 3.16.55-stable breaks yeeloong
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Sun, 18 Mar 2018 23:49:35 +0000
In-Reply-To: <ortvtd4gxf.fsf@lxoliva.fsfla.org>
References: <ortvtd4gxf.fsf@lxoliva.fsfla.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-lxC3UALExLCrJBVljXXa"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63040
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


--=-lxC3UALExLCrJBVljXXa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-03-18 at 11:06 -0300, Alexandre Oliva wrote:
> Commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 AKA
> https://patchwork.linux-mips.org/patch/9705/ was backported to 3.16.55
> stable as 8605aa2fea28c0485aeb60c114a9d52df1455915 and I'm afraid it
> causes yeeloongs to fail to boot up.  3.16.54 was fine; bisection took
> me to this patch.
>=20
> The symptom is a kernel panic -- attempt to kill init.  No further info
> is provided.
>=20
> Is this problem already known?  Is there by any chance a known fix for
> me to try, or should I investigate further?

Guenter Roeck reported the same problem on QEMU Malta emulation.
I haven't yet ivnestigated why this causes breakage.  I will aim to fix
this in the next update (will be 3.16.57 now), if necessary by
reverting that and whatever depends on it.

Ben.

--=20
Ben Hutchings
Logic doesn't apply to the real world. - Marvin Minsky


--=-lxC3UALExLCrJBVljXXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqu+w8ACgkQ57/I7JWG
EQmHxxAAmAN84Moc0nGUUamQrKHmTxPra8XJym1YNr0K7KJPuX1RW9s0vP9DySG+
kOjzNL7T5FKcuI+AKhdRsqygSM8eWwo26XPKb4T8DuRFMzyL3OR4KZ15vAeZnlGY
wHvtq3jJ8MViAgfy2IOpNb4dQ6FKrMeXRnUa7PIHAxhlh9C69sIGDb/6rEj7gXoF
xRylyxr1Zkk4AMwyAcygMGnSs0U/nkjVWm1DN7zLWxu9vNxUhiy1dWCRoQSu3rev
ufCnLrlTJN2odLWzZSL9BJtFc97YwKIr+9llT+S0WG951XiCYAajgaKIOszPzsC0
vCmxOabJS8PhVAKDqqtjqLyy+ccGtGX2I8+Z+V0oDS1bBmrAZH+Qt2uSx9t3Ri8B
KXP8aLRYUi/Ug/KvQZ5DxqmFztmVWNv4WJjvaeWPOAriwAC5r/rah7s9aptmTK+g
He8bEEaXMNCW2Rwf7l01M83GL89erEbyFVmUCXqEEAJFcttZQLOlcpbBRNvWLJxP
iOwirBlXkI53z8DRfoy4iAAMDIudvg2ITuEedV9c2ufV2TkQZGa3yNjWvnJHlJZA
ciBAt8+GokEEmSOjfBewhf3AZ0ePJ3f42sAUh8RNVv4YHz9sHQ6J/dJQPEF8TueD
2BgMrLLARdP/F8kR1QOGDhCbDB+IQNGALjuWhjbgL86r4JjwoFE=
=Mx5w
-----END PGP SIGNATURE-----

--=-lxC3UALExLCrJBVljXXa--
