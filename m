Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 23:47:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENVrqNZIBv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 23:47:46 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F232021739;
        Mon, 14 May 2018 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526334459;
        bh=hvPJWKQot90vFMN44s6/jKLDvA/8Ge0kfbAUgisdFcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndpSggj7Xn3zH+uda+vplP69sbSZoSJvfZ/DLTcwxo2scwDeG99r7F1Qqnd9SK4rQ
         TRcskHaYWBAbkFeKH4PqOeCx7xz4DAG+PI2H4PApD+VH+tVnJkkyhnalVyotx9CuOH
         SPFFRoFiBhuLIjTe9pcBuNTTROJW+pBV7XrbhAuA=
Date:   Mon, 14 May 2018 22:47:35 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Message-ID: <20180514214734.GB29541@jamesdev>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514205844.GG1057@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20180514205844.GG1057@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:58:44PM +0200, Andrew Lunn wrote:
> Hi Alexandre
> >=20
> > The ocelot dts changes are here for reference and should probably go
> > through the MIPS tree once the bindings are accepted.
>=20
> For your next version, you probably want to drop those patches, so
> that David can apply the network patches to net-next.

Since it sounds like the net patches are ready now, I'll apply the MIPS
DTS ones for 4.18.

Thanks
James

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoD9QAKCRA1zuSGKxAj
8l6fAQCuGpJjEOto9b3UOmR7TvOLsGFlm/DBKjHz5NONozRKmAEAkyvOnQnccFsc
xJ4i2tuIwAqXO+rCOHn6V8wHKzKZjAw=
=bOdD
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
