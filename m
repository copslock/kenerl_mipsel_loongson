Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 12:51:21 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:54662
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeGRKvSrI9i5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wiZs7vtTpmFEdg5hRz+A7mtBW33+kxmnwW72OLDvzEU=; b=XrOPruhy210Ri6pYYq3KCQ6k0
        Fp85F6sDbpmkM8T4J1sOkUc9NhxxLa2sxPMb8M4N0mEra3qx5ce1a5KXwIKqA3mIWEAoaPwYiLhKx
        MzZ95KLyzNwxUrcpNAm3nuMSWoDtDtpmun5VzvKVPbvtQ8ltK5byKmlUKRSHJjsNFW/x8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffk36-0003S4-Js; Wed, 18 Jul 2018 10:51:12 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffk36-0003G1-5m; Wed, 18 Jul 2018 11:51:12 +0100
Date:   Wed, 18 Jul 2018 11:51:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
Message-ID: <20180718105112.GF5700@sirena.org.uk>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20180717142314.32337-2-alexandre.belloni@bootlin.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64918
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


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 04:23:10PM +0200, Alexandre Belloni wrote:
> It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
> does spi_controller_get_devdata(master) and expects it to be different th=
an
> NULL. However, spi_controller_set_devdata() is called after request_irq(),
> resulting in the following crash:
>=20
> CPU 0 Unable to handle kernel paging request at virtual address 00000030,=
 epc =3D=3D 8058e09c, ra =3D=3D 8018ff90
> [...]
> Call Trace:
> [<8058e09c>] dw_spi_irq+0x8/0x64
> [<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
> [<80190128>] handle_irq_event_percpu+0x34/0x8c
> [<801901c4>] handle_irq_event+0x44/0x80
> [<801951a8>] handle_level_irq+0xdc/0x194
> [<8018f580>] generic_handle_irq+0x38/0x50
> [<804c6924>] ocelot_irq_handler+0x104/0x1c0
> [<8018f580>] generic_handle_irq+0x38/0x50

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPG58ACgkQJNaLcl1U
h9BvoAf/f/6rtJgyme3vvCowQ16IZAJN774h4L9HXBSudyiaol+mrAx4ZlJdHxzB
OYZwbbqeHHLqr9E9wdQCHDfNz0gAwXzg/kt5BbuNBx5oHLj7JESirezasI5GidMK
nnW92RtEwrt5ygajIO33E/cWeNwLBo3Au0H2/hJnMA4L6RakTJoRT0h6+80XUkJR
q5cHWMH8+kcvPk344EvZ/VkN3bNGo3I1jvcFSYYRwmHe42JWiQSYURBbDynJnI3t
Bx/vo5KR+aA5n3uYfbwMD/Gj9ZbjU3pt/4P4Xhp0u4TkMKZSu3sEuO5EuIbQZ0Fn
Fcu9kqKRVRq5DMt91jBRMEjjEP7HzQ==
=nPpa
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
