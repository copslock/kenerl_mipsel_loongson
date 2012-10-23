Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 11:22:55 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45027 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817088Ab2JWJWyLcfG8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 11:22:54 +0200
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id EFC3C110A00;
        Tue, 23 Oct 2012 10:22:46 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1TQahC-0003dX-7T; Tue, 23 Oct 2012 10:22:46 +0100
Date:   Tue, 23 Oct 2012 10:22:46 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20121023092245.GR4477@opensource.wolfsonmicro.com>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJhJPsV0rnE+K-9bWFy85T36H+PfbibrsGQ_mN_miqttyQJNhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <CAJhJPsV0rnE+K-9bWFy85T36H+PfbibrsGQ_mN_miqttyQJNhw@mail.gmail.com>
X-Cookie: Just to have it is enough.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2012 at 10:10:09AM +0800, Kelvin Cheung wrote:
> Hi Mark,

Don't top post!

> But the common clock infrastructure of Loongson1 has been implemented and
> enabled in previous patches.
> http://patchwork.linux-mips.org/patch/4268/
> Please remove this arch from your patch.

Done.

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhmG4AAoJELSic+t+oim92SUP/3Nb6fOaMW5uFKSJMifluBPG
jBC+4sUNF6OyC9zF6GQcw9+EasY9J0drkWlmsJnau8KzGPDTonCnBjBXk2rVAG6t
vqnmMuK7R+ErO7/DOCiyKxZ73JaRCNHOMPB2sAsYFiUI8MZElyZZJ48BdqndD1EV
4lIJ404Sc4GHFoLNb2ELVCmFhe6FH1Wr0v2vqhCx7FvKLvwLNJAv0eT9355hEPdg
Mhe4tJC8eFnmIM14OoOgUDuv8izHUst7ak+tYZy2fuZmScccHGUGbMurqCmJhEmf
F56fcT4VajWHbPI6euEAsYdJHg677hWn6cMGMT2wN2cRSjOKzb+Tu4oeRWSpSgTZ
z5iYU2q+hFDCDk6FKBN9vmPurCn3yCjUfSHFaw1fJhjRzv1pAKNIH6egLGamYpBA
Xu7PBwcMFHB0yA8JJEaKy/l59IBJoVxCkhRS/hvwja1WFAjgdEzobepRLgvRoa13
gbXxnvlEi6yheaF6P2Bue3Yw7xDIvnwk8MzMbhBJlT+uX6IGOG5Sszk88AoxT7JS
SUBWj+gu4FCGq+4Bh9tD2aT/S8UoCkO97mCIOGR+6QR64U33dKfU7tzfkPShpSWM
SiVHXzJmvFQ+XLQu97Fwmu20J0TXbvbUnNjIf4Dtn37b1OUIS2LdYvtDYPbMmzAw
SZ32wAM5iAE62WIvyGm4
=VZg6
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--
