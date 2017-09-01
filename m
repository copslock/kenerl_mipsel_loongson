Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 18:40:19 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:39164
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdIAQkKtC9Yv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 18:40:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7pElQ/EEua0qiD3YwyLR8qDOtIjVUZ3KyIZr/zzQWQE=; b=sCZXYShXH9z5lCFhpeWf/dQHx
        OLrCTSeaYesz/56a/m26T96YaeHtlGaJgxC06JBfusOPukiJFjUqdEzqn7UHiM89BIWQDoyVbqmwq
        Us17kLYnkYQs8jhdF3/rPsxJZnIHOdw2b5/8mNfj8+1I1gLxlVXEE9vQCnbfXy1YmaoJM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dnoz5-0005kQ-OA; Fri, 01 Sep 2017 16:39:55 +0000
Received: from broonie by debutante with local (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dnoz4-0006rb-Tt; Fri, 01 Sep 2017 17:39:54 +0100
Date:   Fri, 1 Sep 2017 17:39:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        hauke.mehrtens@intel.com
Subject: Re: Applied "spi: spi-falcon: drop check of boot select" to the spi
 tree
Message-ID: <20170901163954.zj2kpqhag7vakucp@sirena.org.uk>
References: <20170417192942.32219-4-hauke@hauke-m.de>
 <E1dnjTy-0006AD-Ox@debutante>
 <20170901142355.GB31297@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yz2qmbdgrt2zqrtv"
Content-Disposition: inline
In-Reply-To: <20170901142355.GB31297@linux-mips.org>
X-Cookie: No Canadian coins.
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59911
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


--yz2qmbdgrt2zqrtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2017 at 04:23:55PM +0200, Ralf Baechle wrote:

> Thanks Mark - but there are some ordering dependencies in Hauke's
> patch series so it would be great if I could have an Acked-by to merge
> this patch through the MIPS tree along with the rest of Hauke's series.

Ah, I see - I wasn't copied on the cover letter so I didn't know about
this.  Here's a pull request:

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-falcon-no-board-check

for you to fetch changes up to 1a41aa1376df9e24d0c760df1a6f59765316c457:

  spi: spi-falcon: drop check of boot select (2017-09-01 11:33:22 +0100)

----------------------------------------------------------------
spi: Remove board check from the Falcon driver

MIPS is removing this board check so support a cross tree merge.

----------------------------------------------------------------
Hauke Mehrtens (1):
      spi: spi-falcon: drop check of boot select

 drivers/spi/spi-falcon.c | 5 -----
 1 file changed, 5 deletions(-)

--yz2qmbdgrt2zqrtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmpjVoACgkQJNaLcl1U
h9BV1gf7Bb/eqetoXini9Wo2ec8W/Faq3iyNLJsm5sq6kdEmyfgg45y+VPDzER/s
S2zaLpkahr6nOhFZVCc+ZuJ0/ONB3j1zKeCul8E0Jquh8R2UhNSIxla2VRnDHDxG
NlCM9pk0eI6NJ4ad78DcIf8q7eeikuFchw66pMIzeZj02AWurYj6Vf15iZxwv/Im
PxAT5C5XG8roa3FRCXNjI+m0sT1jBkjHNFpINm6mj9tUQ3nWW14vjKDjAbyH0ymR
bqLmqWA/TKhZX8Ek4BgQRIcAc8qPPs4atb07cDvahDjvZUZEREik5qe9Vh0wtLXi
D09hfGioArLwS0+IGC2PQ3K95sr7VA==
=Yz51
-----END PGP SIGNATURE-----

--yz2qmbdgrt2zqrtv--
