Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 13:01:13 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:34924 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993092AbcKVMBHV1Aux (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 13:01:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ku8Y0HXrntA+ZYm7ITMOkFU2Gg6J
        XLGrYOFxFtUpqJ4=; b=t+kSzKOmDiDJMFfAyYx7W4EQUMyyh72mI6VDWS2rAnvz
        bcQYEeD4rz58gzSvkxN5fDRM6HHaQVNxao/6NjGcSFNPQ0WBXI50SxmqQ88orL6f
        h6Jsv1nPKGRSzb+CPgjgLiymVt1PrHh6QqQuU9N7Q5t9C/x9Dw9WetBUKaGuQYo=
Received: (qmail 16098 invoked from network); 22 Nov 2016 13:01:06 +0100
Received: from p5b3853df.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@91.56.83.223)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 22 Nov 2016 13:01:06 +0100
Date:   Tue, 22 Nov 2016 13:01:06 +0100
From:   Wolfram Sang <wsa-dev@sang-engineering.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     Jan Glauber <jglauber@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161122120106.GB3993@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa-dev@sang-engineering.com
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


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> On 11/14/2016 12:50 PM, Jan Glauber wrote:
> >=20
> > Since time is running out for 4.9 (or might have already if you're not
> > going to send another pull request) I'm going for the safe option
> > to fix the Octeon i2c problems, which is:
> >=20
> > 1. Reverting the readq_poll_timeout patch since it is broken
> > 2. Apply Patch #2 from Paul
> > 3. Add a small fix for the recovery that makes Paul's patch
> >    work on ThunderX
> >=20
> > I'll try to come up with a better solution for 4.10. My plan is to get =
rid
> > of the polling-around-interrupt thing completely, but for that we need =
more
> > time to make it work on Octeon.
> >=20
> > Please consider for 4.9.
> >=20
> Hey Jan.
>=20
> This does not work on Octeon 71xx platforms. I will look at it more
> closely tomorrow.

What's the outcome here? It seems we want a bugfix for 4.9 but this
report keeps me reluctant to apply the series.


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNDOCAAoJEBQN5MwUoCm2EeIP/3bmRs70qfkSA8wpYVW6juiB
WnUF2+Dev/vKOGVKXiGuD8Uy58doMpTlpJyE6RSMbtq8f62usdbJHmc48HgfUn50
GCJt4FV/aJefvtEh3pFJd6ldut6XDoz7GEUq7ENwMW/VLYn2fasJYhzCsfUaf2b6
gDyLdrnmoJIzotxL2KDJZ1zop4awLkxTOVWD2LOTvigfZ59r9aFyuSrLo5boeNQv
Udc1iLnD/wgqqAhCCRWrlXJsCQVugwcC1IZEyjqbTevg/m7s+9PTmHZUiVzOoTQJ
Bg8UquVfMYi9o299EPRSkoAsxNSxFXcBekQjBOWbs4c+49M0MvUW2pPINcJRfgt+
jUu41J+otzW8ZO8b5/Ce7F7Fj634x/rNXK54KR8wWcUFNhUSbgy99UFBBuEEM5E+
YCRB3x6A9R4ZV3FONduZbb+OI6C+hZmoE9FkSG1y5Z+DNCuCllszXT+Ig7X6jfQ3
ja9p4kNuSnQ7irZBgkUxbADumq9+XvZEkDT//pGyw6Uthry4Ciouxdq4Wi1YX71T
AhEDZgk1qgqK3LK6wbnXoBvh/TLN4SqLBx3PSq+0ZVWybDDX685A2bNdPtzTsO2m
sM3Q81Jx5GoQqECjBd/06f1wGDHS+u3uPUb9bveFXCAtj3ZldEPxaNzFNto9Ofy/
CaYtT8+N+E9aV8/qG5Nu
=WWOz
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
