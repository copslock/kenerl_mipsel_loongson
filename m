Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:19:26 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48357 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819447AbaDWLTWWBy4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:19:22 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante.sirena.org.uk)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1WcvCk-0000MJ-Rk; Wed, 23 Apr 2014 11:19:15 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1WcvCh-0006g4-QP; Wed, 23 Apr 2014 12:19:03 +0100
Date:   Wed, 23 Apr 2014 12:19:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org
Message-ID: <20140423111903.GQ12304@sirena.org.uk>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-5-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6cefKH10kddc8n4c"
Content-Disposition: inline
In-Reply-To: <1398199596-23649-5-git-send-email-lars@metafoo.de>
X-Cookie: You will be successful in your work.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 5/6] ASoC: qi_lb60: Use GPIO descriptor API
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39907
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


--6cefKH10kddc8n4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:46:35PM +0200, Lars-Peter Clausen wrote:
> The new GPIO descriptor API is now the preferred way for handling GPIOs. It also
> allows us to separate the platform depended code from the platform independent
> code (Which will make it possible to increase build test coverage of the
> platform independent code).

Applied, thanks.

--6cefKH10kddc8n4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6GkAAoJELSic+t+oim9IGUP/3quTPiKLPFnpEZ1sD/c4sya
TbLPa5OMaWJGFgkUzbNhjyjzYxG2k7PWMpaV9bilPE+IWyX6COnssnnYPimikTtY
6sEAz0Akg0TMvkoBf0GDJCyskV6blb8EEk43NGn+rvDebqCV2jO3rw+vEK2usV1n
QeWZ5HfiFaehwv2RQo7ZC55Ag3hybcWh5Q7SYbgsCpmliMmEvFi6KedPD0HSlQj/
nPfdRAkqLPQph3n2Y+PAPb/47KLkKBODhb1Kwk+NJWR5Qzai5Dmu8aekqw0Vh//i
2BS1Vbzz4v1TZG6ywbAivx5aqj0jZbR9LRypAm1ILIjvxoBfeT4x845yif3viv7D
q5fN7DQdvxCvFpQj/3hY4ffN4lg86KyTApXmwFhTm8/+AX5ZH0DSbOjkbmB3t7S+
sMjGRf8ZErdI3lpvo4vCZSzoVK7T9BLU/IbtBms4BDOoAEG125qgf1higFT9LalS
g6jRJRKevKc88N4WFPOzj6gBEoPHBXzv2J0yHKGVCBKvxIKlc+QhonInS/cpE4O4
hUcmfF4UAvY54ToBxuCc3ejC7OZhLC+FCWXbGq0bhDbl45/ui86JkC7jJ4jlV7uO
038g3OMxWruGJCl8iG3JrXE77DQz2otscB1Zz7Ki2TtlueRTGdktq0l3IK7fRf2y
8ad+GB5igo4+UDMP1BjI
=+TjX
-----END PGP SIGNATURE-----

--6cefKH10kddc8n4c--
