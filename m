Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 16:59:22 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([IPv6:2400:8900::f03c:91ff:fedb:4f4]:44182
        "EHLO mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdDUO7QQv6Um (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 16:59:16 +0200
Received: from [2001:470:1f1d:6b5::3] (helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1d1a1Y-00014U-O2; Fri, 21 Apr 2017 14:59:07 +0000
Received: from broonie by debutante with local (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1d1a1V-0005sM-O1; Fri, 21 Apr 2017 15:59:01 +0100
Date:   Fri, 21 Apr 2017 15:59:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        gregkh <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-build-reports@lists.linaro.org
Message-ID: <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ovrjfzp4i2ezu2q7"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: NeoMutt/20170306 (1.8.0)
X-SA-Exim-Connect-IP: 2001:470:1f1d:6b5::3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57758
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


--ovrjfzp4i2ezu2q7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)

> > 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
> > than 1024 bytes [-Werror=frame-larger-than=]

> This is a result of a newer compiler version, combined with the -Werror
> flag that is applied to arch/mips/, and two of the mips defconfigs overriding
> CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
> accident).

I'm wondering how good an idea it is to leave -Werror on in stable
kernels given that they're very likely to get used with newer compilers
at some point.  But then I've never been a fan of -Werror in the first
place.

--ovrjfzp4i2ezu2q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj6HjQACgkQJNaLcl1U
h9CH8gf/UL06jraLF6g8YmE3noky7qfgRGYNgnPPs/dbHNZoYtTS/gsKaCrnm1zL
MvhWuRFNXQYZXKFl06cPY5nfL/2+y2xdVQ0WP5+1SgXu8EYcx2jv/9C+rampFMfL
hqW85pYztlpZczbUgf0YArR61OAppAVF6IUR+IL5JipsNLSjuGJoOd9GxM8zXX08
1YAulbN6qHin6COLuCdd8izWLFUq+V/n9ZSNUssXqdcEjTjZewyqhAXZL9RYG7A+
hQ0XktHPelK+RJxYjaja9DNVTeTvIH1FANPLAoSBKFkleM2eq0hJkxcRz7krbw1A
g9G3Kr0k45KdvCIckshval72LjP57g==
=tXaD
-----END PGP SIGNATURE-----

--ovrjfzp4i2ezu2q7--
