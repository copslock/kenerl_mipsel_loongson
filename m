Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2016 13:20:03 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37390 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbcLPMT4i3ef8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2016 13:19:56 +0100
Received: from [2001:470:1f1d:6b5::3] (helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHrUM-0000d1-Lp; Fri, 16 Dec 2016 12:19:52 +0000
Received: from broonie by debutante with local (Exim 4.88)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHrUJ-0005hr-KL; Fri, 16 Dec 2016 12:19:47 +0000
Date:   Fri, 16 Dec 2016 12:19:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Message-ID: <20161216121947.uen37mkbbqxtvtpt@sirena.org.uk>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
 <20161216005606.GD15191@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ccmdvxsh3n6zkici"
Content-Disposition: inline
In-Reply-To: <20161216005606.GD15191@linux-mips.org>
X-Cookie: I represent a sardine!!
User-Agent: NeoMutt/20161126 (1.7.1)
X-SA-Exim-Connect-IP: 2001:470:1f1d:6b5::3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
 warnings (next-20161214)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--ccmdvxsh3n6zkici
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2016 at 01:56:06AM +0100, Ralf Baechle wrote:
> On Wed, Dec 14, 2016 at 01:52:14PM +0000, Mark Brown wrote:

> > These MIPS builds have been failing in kernelci ever since MIPS was
> > added.  This means that we've got a constant level of noise in the
> > results which makes them less useful for everyone - people get used to
> > ignoring errors.  Is there any plan to get these fixed?

> I had to "bisect" binutils versions to hit the allnoconfig and tinyconfig
> build issues.  Turns out it's a problem specific to binutils 2.25 which
> when generating 32 bit ELF does not permit the use of 64 bit constants,
> not even when explicitly to the 64 bit instruction set, for example:

> 	.set	mips3
> 	dli	$1, 0x9000000080000000

> The only fix I was able to find that will work with all binutils, is
> open coding the dli macro instruction as

> 	li	$1, 0x9000
> 	dsll	$1, $1, 48

> Which is pretty much what the assembler should have generated from the dli
> anyway.

Thanks - someone should probably tell the purpl people, it's their
toolchain we're currently using.  We did have a bit of a look yesterday
for other prebuilt ones but didn't come up with anything so I guess a
lot of people are going to be using that one.

--ccmdvxsh3n6zkici
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhT2+IACgkQJNaLcl1U
h9BG7wf/ZydDsxxLdYmZn8SBf/kjxEnjIyFbeT4NQXPmoBjv/66O+nMZYZm0WKa/
SFZWmXbt8SythcfINzoQY4BBBYBVg1id/I+ggJCc5Vk6ZoY69QYeRTLDO6vFTeqh
cMW6+ywgVdE7irTHOr4cG1ySgyPLDIeYhkipUOfpZq970BSwevg7sZk7gxrJ5vFi
KXDL/PvMQ0l8nheLcltuessBpsQEEPp27AESQAcvF+zQxtlGRJyIHa6qw4LBw1Vg
Zsdxn5DfVy+217ueEywve5GHgzj3KI/bW1bm2DSHztsn1uOr10Una9x7Bs/AZwIJ
mhK5VtCt0eQ/T+JQmPf/CCxMSqmiEw==
=9vkL
-----END PGP SIGNATURE-----

--ccmdvxsh3n6zkici--
