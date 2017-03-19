Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Mar 2017 17:06:31 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37420 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993417AbdCSQGWPjAqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Mar 2017 17:06:22 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cpdLZ-0007Ru-1P; Sun, 19 Mar 2017 16:06:21 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cpdLY-0005AP-6f; Sun, 19 Mar 2017 16:06:20 +0000
Message-ID: <1489939579.2852.72.camel@decadent.org.uk>
Subject: Re: [PATCH 4.4 08/35] MIPS: Update lemote2f_defconfig for
 CPU_FREQ_STAT change
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Sun, 19 Mar 2017 16:06:19 +0000
In-Reply-To: <20170316142907.261390617@linuxfoundation.org>
References: <20170316142906.685052998@linuxfoundation.org>
         <20170316142907.261390617@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-+x+bc76ugfGLc/BR+66R"
X-Mailer: Evolution 3.22.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57390
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


--=-+x+bc76ugfGLc/BR+66R
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
> commit b3f6046186ef45acfeebc5a59c9fb45cefc685e7 upstream.
>=20
> Since linux-4.8, CPU_FREQ_STAT is a bool symbol, causing a warning in
> kernelci.org:
>=20
> arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid=
 for CPU_FREQ_STAT
>=20
> This updates the defconfig to have the feature built-in.
>=20
> Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
[...]

So not needed for 4.4?

Ben.

--=20
Ben Hutchings
Power corrupts.=C2=A0=C2=A0Absolute power is kind of neat.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0- John Lehman, Secretary of the US Navy
1981-1987


--=-+x+bc76ugfGLc/BR+66R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAljOrHwACgkQ57/I7JWG
EQkZ5Q/9ENYycYTpAIvdqcAPbpphrRgd68B4G4RcZVRWHDr+0nQ7k7tNGGUhIupy
5HAo+Cki1LJbUK+Zq+WszdkPjc1thh1g78W6KTA4ooG/J8LVg2zPfbyNOuwg8yg1
eX1a+G3Skgu9keqpyBuvmeunu4IkziRs5izVPbTKx7nQYcjl3EHTnQi3ox6aGRhR
vEJmSKvd8LTJjU6wu9jphSQ9/DGETfVLwvbNTJto3z9gOJ+k487h0x7h+CX5DsoW
9FrU4pBHYKlDukqlJZ3CkYsltG1TcNbPG+9VvRGphkF/OhyHBZV7ccpmQNfoW/AJ
so6D470PjazWZdSD4yme+KtHMWGX7rYJcFVgfdLAAE9K71mY1TS9uxW0VpUl6aWX
dwAsGc/CSJJy8NM9vKdoBK0JpcGJKuFKt/Gs3Iz3aHWul1QpG0PsS0atHZXIze5A
GVEArYAtWS6nFYgQPSv+l0I9vh/T9ArhixmE6X/ReRKZvjjFHsFojJgpZ0PHeB3y
WKNODlBrMqcKp0vIaFU2Ch5n2rrM9usPTVilvbRJjowxRMNAbhkMAtN09G+zG8jU
rcqO0ffnxjeypp5ydXnh+L6BbTjPbzGtR3Yft9nWDZyemYtsOXVmYJ3a8B1Jueul
f5O7EpJjr/mcOw9O9mjBQpnsG2j7mXOe5mhchP4S7qGfQUdoF6Y=
=5xww
-----END PGP SIGNATURE-----

--=-+x+bc76ugfGLc/BR+66R--
