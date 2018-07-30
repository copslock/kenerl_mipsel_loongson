Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 17:35:11 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:54894
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993057AbeG3PfH7GddK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2018 17:35:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AsfBezTL97gH4iDO4Ep6SUWk4Dz4Szv31UCxcOEM1EU=; b=FtgcCgoSUvW4QKEZCC7iRahR9
        latWwGhjHOeJVCxvS6W+o2uGJutXEy3GzjBbO7Q8jxf+cDjhklb2xLI2wzcKZCAymU7LkMeFrZXIT
        OFF9oB5fHdgduuIrl9C/NgO1M04snObra6wV7lQcOC3EG5j/ZDGtWuGfh/+NUPL3PlojU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkACN-0005XJ-Ag; Mon, 30 Jul 2018 15:35:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 09B931124216; Mon, 30 Jul 2018 16:35:03 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:35:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 14/15] spi: img-spfi: Finish every transfer cleanly
Message-ID: <20180730153503.GO5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-15-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-15-afaerber@suse.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65258
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


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:09PM +0200, Andreas F=E4rber wrote:
> From: Ionela Voinescu <ionela.voinescu@imgtec.com>
>=20
> Before this change, the interrupt status bit that signaled
> the end of a transfer was cleared in the wait_all_done
> function. That functionality triggered issues for DMA
> duplex transactions where the wait function was called
> twice, in both the TX and RX callbacks.

Again, is this not a fix?

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfMCYACgkQJNaLcl1U
h9BZmAf/QwgRuAnirIDhBewibP4c4V9oElrLpan9KExyh8toALsp037PJxbaO9oN
sCnn3i2vHYQPNmM92QOn24RQf5wE3KbuqDeS+5podX+Js+xX7VBqTT6X63KvtR6j
5R1wZ8XD0Nla/K8eNPoG55mbVNgFxeSwkVeQy2HU3JYo0Bzx6ShxDqkaBKFnoMkC
I0RoWsX2xV0DLcfRhQRRSpEIe2dtV++GR48Nfs2Auw8ZpAYukTZBik4DQ9ZwgEro
pP9MYuuGcW6TNGIqIDybg2DK2snVR9QBmCQv96IpTI9grZJiKBEQimOtw3eJ0qip
6RdZjmm9JC60Ejak/3jBUqfQTbuH7Q==
=ZyLh
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
