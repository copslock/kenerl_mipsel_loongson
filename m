Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 20:34:25 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:41704
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995072AbdH2SeHuUu-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 20:34:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5th27f3Z/c5hvTH0hxiESXnYQNNkJcvUwJPm4OFvAL0=; b=nbZSCVc2aUsoWy2p+kYQ275OH
        WEAW+BeRLri8gPFFC88tMA6hU40fkKFiGQ2+LeMULv2hBkjqRflFcdWHHiG9YC4ozbOZSvFDi3UgW
        ykOV9D3juhFXDasPC2nCHDRD5UEgj0cUijCdU1dio30bs9z4kw3l5KGp58alNi/haXx50=;
Received: from 188.29.165.33.threembb.co.uk ([188.29.165.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dmlKW-0003ox-Ly; Tue, 29 Aug 2017 18:33:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BB7654400E7; Tue, 29 Aug 2017 19:33:30 +0100 (BST)
Date:   Tue, 29 Aug 2017 19:33:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com, p.zabel@pengutronix.de, kishon@ti.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
Message-ID: <20170829183330.bw32izdgscs3qv7n@sirena.org.uk>
References: <20170819221823.13850-1-hauke@hauke-m.de>
 <20170819221823.13850-4-hauke@hauke-m.de>
 <20170828112327.GA15640@linux-mips.org>
 <40428f8d-f781-7952-30c6-41f65ec1096b@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="em6bza2p3zhdutf5"
Content-Disposition: inline
In-Reply-To: <40428f8d-f781-7952-30c6-41f65ec1096b@hauke-m.de>
X-Cookie: Often things ARE as bad as they seem!
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59881
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


--em6bza2p3zhdutf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 01:29:33PM +0200, Hauke Mehrtens wrote:

> Mark could you please have a look at the commit message if it is better n=
ow.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--em6bza2p3zhdutf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmls3kACgkQJNaLcl1U
h9B79gf/Wa/VFkXnOlBBNgm63YVzh2QsxE9mKHpvq1zfYnZKXeW4dHKXtXd0NT0T
WDNmcLPyxJ6nmEPAxsarDv86W1wQ6oS91N+17jgdkneocp290gLk6C/esWLR+AqZ
NU8f9FA+hl/YQ6ZLRiyz3EaB3kDGxGyIJCLgAj8MP0qogG8I5a05/fwc184qpG/I
98rvKfPPfZilzOeeK34nxoFTQrp7q9+HHS5I0ZtJuTeHBXnjofkBcNULZRUSP3db
jMnk1GqbA+FcGnAbwRAxHXzsCCAUsk+Y5V63hYyReFUo1nVwC0E5xLvF1wguhVv3
xilvTr6q7n8CeXYiyp8J4HIDf8VgUw==
=BO/Z
-----END PGP SIGNATURE-----

--em6bza2p3zhdutf5--
