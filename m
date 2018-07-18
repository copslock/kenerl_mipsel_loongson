Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 14:24:29 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:41540
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeGRMY0PaH9S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 14:24:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dCyXj/uVZYwoNnk54f6bSih9QXBGzYOOctuBBeCWh0w=; b=HoYB2qptb289RhYl5MTtyvAvh
        ezNiQdVu763T4dfOpyff8Z7kqnt7zzJoC29eIxr9QsoJYiwvQSrW011RdSDlqOygaAfUyUEVf//FS
        A1yM44y6bWuWDqqMiukXDXhQrLRrOzQc/nTxKTLBo4qxo/m1mNwHmiJmei4ZjY6soTuyo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflVG-0003U4-Ki; Wed, 18 Jul 2018 12:24:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflVF-000745-Vk; Wed, 18 Jul 2018 13:24:21 +0100
Date:   Wed, 18 Jul 2018 13:24:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH 2/5] spi: dw: allow providing own set_cs callback
Message-ID: <20180718122421.GK5700@sirena.org.uk>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <20180717142314.32337-3-alexandre.belloni@bootlin.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64919
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


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 04:23:11PM +0200, Alexandre Belloni wrote:
> Allow platform specific drivers to provide their own set_cs callback when
> the IP integration requires it.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-dw-set-cs

for you to fetch changes up to 62dbbae483b6452e688b8e26c4d024d484117697:

  spi: dw: allow providing own set_cs callback (2018-07-18 13:22:37 +0100)

----------------------------------------------------------------
spi: dw: Allow custom set_cs_callback

Allow platform specific drivers to provide their own set_cs callback when
the IP integration requires it.

----------------------------------------------------------------
Alexandre Belloni (1):
      spi: dw: allow providing own set_cs callback

 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 4 insertions(+)

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPMXUACgkQJNaLcl1U
h9BWsgf9FOP0W6xbxEz+Z9Vym3Fbf6vuznYgCsxHhqV79EP6lRLrdJOllZTSXOSy
dkYUwpR0MlLDukWBvPPwmDM2m/BR6rHfzMWXqyWh4+wj6CD9KZlm7hMqauANfSoC
6zV2IdBSVw3d0QHfiMRB2WuVBAnTlTFaPPik66NJo/VngEEvBrnsV3KjuECtdeKZ
KgHtmh0O/D674R8OdfKJ4BjpHAl2BCHJnyjr0fm1X/doqci62vM2Oq6WQWSA6Z2w
W9BgQzxMgFEiXNVAikwYAT2g/wos85wiqRFPMqUQDC0I0KTxZJjsL4yogxSiIEVZ
WUMcnYQ6Qzbwj83eD7krc7hVaCVYLw==
=I9ay
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
