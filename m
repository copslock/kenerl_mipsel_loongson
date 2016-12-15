Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2016 12:00:49 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59074 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991948AbcLOLAli-6YG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2016 12:00:41 +0100
Received: from [2001:470:1f1d:6b5::3] (helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHTm7-0003Fq-UA; Thu, 15 Dec 2016 11:00:38 +0000
Received: from broonie by debutante with local (Exim 4.88)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHTm4-0006LA-TW; Thu, 15 Dec 2016 11:00:32 +0000
Date:   Thu, 15 Dec 2016 11:00:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Message-ID: <20161215110032.aercfokgwvdkhs3m@sirena.org.uk>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
 <20161214160609.GA15191@linux-mips.org>
 <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
 <20161215032241.GB15191@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="euqmwtooczttz6z4"
Content-Disposition: inline
In-Reply-To: <20161215032241.GB15191@linux-mips.org>
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
X-archive-position: 56055
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


--euqmwtooczttz6z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2016 at 04:22:41AM +0100, Ralf Baechle wrote:
> On Wed, Dec 14, 2016 at 05:45:39PM +0000, Mark Brown wrote:

> > without going and finding/downloading the CodeSourcery release.  Where
> > did your toolchain come from, is there something specific recommended
> > for MIPS?

> I specifically avoid non-standard toolchains, that is I stick to the
> vanilla FSF releases with no feature patches.

We're really looking for prebuilt binaries here, if nothing else it
makes it a lot easier to debug problems if people are using exactly the
same binary as it eliminates the possibility of differences in the
builds (due to some dependency changing for example).

--euqmwtooczttz6z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhSd9AACgkQJNaLcl1U
h9AsKwf8CeNC/NKzaRonfd6tFKa+l0y87qPixsVTfbl/4tEho/SY910kLgtOcYd5
sCoKmfMhb93hPB4bJi/VjfHmMkd1CiR5KddVn8Howr9vvlxwpkroSZ9A7fdW5EPv
bhfy8KNul0IdYYo4AoBzLyrNZXd0XNXq/V/n2cwls6AARp78awiSzq6XXq7hL4do
AZtSadEzv0K18W+mbHLygYJTzNFHQHfvjB+15LQF7MajT2St5kGPAGpuXMymZn9N
scv5WackQim5pvMISFaxEXT1iI8AE7u61fi+8EznDkyxJhbvO8INdRGwv51TeAyB
eOfILSkSJ6ehTbS8k92BEMd15b84lA==
=FSNh
-----END PGP SIGNATURE-----

--euqmwtooczttz6z4--
