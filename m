Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:24:55 +0200 (CEST)
Received: from bues.ch ([80.190.117.144]:54484 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6862813AbaGVPSPe-jDo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Jul 2014 17:18:15 +0200
Received: by bues.ch with esmtpsa (Exim 4.80)
        (envelope-from <m@bues.ch>)
        id 1X9boy-0005Mu-Hu; Tue, 22 Jul 2014 17:17:40 +0200
Date:   Tue, 22 Jul 2014 17:17:04 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval
 in driver
Message-ID: <20140722171704.71e34e9e@wiggum>
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/hrgAhs9Mivj2jERYWhjEYIr"; protocol="application/pgp-signature"
Return-Path: <m@bues.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m@bues.ch
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

--Sig_/hrgAhs9Mivj2jERYWhjEYIr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2014 17:08:13 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> >  drivers/ssb/driver_gpio.c                      |  3 ++-
>=20
> Michael can you (A) ACK this and

Acked-by: Michael B=C3=BCsch <m@bues.ch>

> (B) think of moving this driver to drivers/gpio... Patches welcome.

This is not that easy, as it is not a driver on its own, but integral part =
of ssb.
I don't think it's a good idea to move it out.

I'll accept well tested patches, though.

--=20
Michael

--Sig_/hrgAhs9Mivj2jERYWhjEYIr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzoBwAAoJEPUyvh2QjYsOuF8QAKSf5P1KzGQpBDdHpy/lCXaV
R2TFv+8h2wn2BfjBh+lKc3WV2FvdFwXNO/5kM6g7Nlku2bdjfGNeFyXVvEnESF3n
bFvmgNEI0AA65zZoxsKGcEFRxz9iijewT+ZpkbwwS2uscmRhKUhSyoz58CiyARxS
KBedPNO3SV++34XI9Jfrn7wpZs4CIiGcMqKIFGTV756Gb0luSLeaH9ThvZVS0poV
adME8vN50KL2hYN72J6WXDaZlKlQ22tqrMDq8DyYbfSyis2rDQPin9PDtw52TF4q
YU+QiqxlSSHPP7LVh6mJCMjC6jtrcOvzebKw5N6qpYSaNUsa2geB6VWMRzzUiu4b
tXZTgJQjdpdAtafdJLDUs+EynykaTvcZYX8wgtfen6NfxvbjerxI6OOvi1j4H3Z/
wZmIO6olkR1KA3PGj9OcCmIZoY2fjOf4EApWYngFWMiPkaIFBn+OiCAGrQpZPBWU
rFGCM3BeslULWldG5VSwwURgp3dQS/kHegnrddD9M1WH7CInBmHsWxQwocyh0RMu
gP4yGTtAYcp2SjY35SMnw9+L9BjRzqmBd74fJRD8iR7Iw7++14QArX3JBaXfbtok
OAZDoMPWIZxemzvP7L+QYb5LS6+H4FoRkNhbDYvodI0WtAng6UF/QFKjrr6gqfoy
wyRrZ5RjRjp2yMo4qnNm
=qF+A
-----END PGP SIGNATURE-----

--Sig_/hrgAhs9Mivj2jERYWhjEYIr--
