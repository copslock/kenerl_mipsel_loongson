Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 03:29:11 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57608 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492747Ab0CMC3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 03:29:08 +0100
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
        by metis.ext.pengutronix.de with esmtp (Exim 4.71)
        (envelope-from <wsa@pengutronix.de>)
        id 1NqH60-0004Zy-FS; Sat, 13 Mar 2010 03:28:56 +0100
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NqH5z-0002na-Op; Sat, 13 Mar 2010 03:28:55 +0100
Date:   Sat, 13 Mar 2010 03:28:55 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arch/mips/txx9/generic: init dynamic bin_attribute
        structures
Message-ID: <20100313022855.GD4034@pengutronix.de>
References: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de> <1268377431-11671-2-git-send-email-w.sang@pengutronix.de> <20100312183450.GC8736@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20100312183450.GC8736@core.coreip.homeip.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2010 at 10:34:51AM -0800, Dmitry Torokhov wrote:
> On Fri, Mar 12, 2010 at 08:03:49AM +0100, Wolfram Sang wrote:
> > Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this require=
ment.
> > Found with coccinelle, but fixed manually. Compile tested on X86 where
> > possible.
> >=20
>=20
> Regarding all 3 - it looks like these dynamically alocated attributes
> could be converted to statically allocated ones. I'd recommend doing
> that instead (in fact, I posted patch for the firmware_class couple days
> ago).

I agree for the firmware-patch. Regarding the MIPS one, 'size' might differ=
 and
'private' will differ per instance. Regarding the RTC driver, 'size' might =
also
differ. I don't know if somebody really wants two RTCs or the SRAM for MIPS=
 can
be instantiated more than once. Unless somebody with actual hardware jumps =
in,
I'd say better safe than sorry.

Thanks for the comment!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkua+GcACgkQD27XaX1/VRsmUgCgxpG37bpkUetDGyW/fT8vhGaU
9XoAoIbuIfLRmEolrdu01v0d4cjAMYZJ
=pKV6
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
