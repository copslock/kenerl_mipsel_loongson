Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 18:45:55 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34038 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcLNRpsNpfUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2016 18:45:48 +0100
Received: from [2001:470:1f1d:6b5::3] (helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHDcc-00015t-TT; Wed, 14 Dec 2016 17:45:45 +0000
Received: from broonie by debutante with local (Exim 4.88)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cHDcZ-0006Yf-Tm; Wed, 14 Dec 2016 17:45:39 +0000
Date:   Wed, 14 Dec 2016 17:45:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Message-ID: <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
 <20161214160609.GA15191@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pme7352aoyqgs7t5"
Content-Disposition: inline
In-Reply-To: <20161214160609.GA15191@linux-mips.org>
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
X-archive-position: 56051
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


--pme7352aoyqgs7t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 05:06:09PM +0100, Ralf Baechle wrote:
> On Wed, Dec 14, 2016 at 01:52:14PM +0000, Mark Brown wrote:
> > On Wed, Dec 14, 2016 at 12:39:18AM -0800, kernelci.org bot wrote:

> > > mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)

> > These MIPS builds have been failing in kernelci ever since MIPS was
> > added.  This means that we've got a constant level of noise in the
> > results which makes them less useful for everyone - people get used to
> > ignoring errors.  Is there any plan to get these fixed?

> I wonder if these are also toolchain-related issues.  allnoconfig and
> tinyconfig do build fine for me with GCC 6.1.0 and binutils 2.26.20160125.

> generic_defconfig requires mkimage of uboot-tools or it will fail like this:

>   ITB     arch/mips/boot/vmlinux.gz.itb
> "mkimage" command not found - U-Boot images will not be built
> arch/mips/boot/Makefile:159: recipe for target 'arch/mips/boot/vmlinux.gz.itb' failed
> make[1]: *** [arch/mips/boot/vmlinux.gz.itb] Error 1
> arch/mips/Makefile:365: recipe for target 'vmlinux.gz.itb' failed
> make: *** [vmlinux.gz.itb] Error 2

Ah, you don't have a separate uImage target?

> What binutils are you using and can you send me the build errors messages?

You can see logs for all the trees we build via the web interface:

   https://kernelci.org/job/

I don't have access to the builders to check the binutils version
without going and finding/downloading the CodeSourcery release.  Where
did your toolchain come from, is there something specific recommended
for MIPS?

--pme7352aoyqgs7t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRhUMACgkQJNaLcl1U
h9CPxwf8Cx5RptBgdNeguXpQjCHhKZzK2dFOhvurcs70MFUKjOeCLjWhqviWy+ry
1wsQQWVFxiQ5vCPknhAq8yu/CmYMKB1y4BrDd3zJEcw9B3s51V04XHSZEBtoGDkg
lt3AIG+kZoFmbPgIOzaw3X8TeSsrHMPu15sgHhMAMjLRjdu8hlDI3KnredQYaI91
M2r1R7eBZXyx/hK0NbtD113OCIW9CLhfubj3S9MWqzFQOhMo1jCV6qgJJBRu5ACp
i1RIf8f86cSnRKzIVjQt0BMSCCJMQebWVoZftz1P9Njm5we/0VGNUey1Fr2GPyhS
/CIBnDQwniXXbRZqot7XhsSYuQa45g==
=/f0M
-----END PGP SIGNATURE-----

--pme7352aoyqgs7t5--
