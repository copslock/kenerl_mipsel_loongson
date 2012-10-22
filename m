Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 15:55:00 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58349 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824842Ab2JVNy7LYmvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 15:54:59 +0200
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 4FF3F750004;
        Mon, 22 Oct 2012 14:54:53 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1TQISy-0002g6-NM; Mon, 22 Oct 2012 14:54:52 +0100
Date:   Mon, 22 Oct 2012 14:54:52 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20121022135452.GJ4477@opensource.wolfsonmicro.com>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121022130556.GM21164@n2100.arm.linux.org.uk>
 <20121022132711.GE4477@opensource.wolfsonmicro.com>
 <20121022135024.GN21164@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20121022135024.GN21164@n2100.arm.linux.org.uk>
X-Cookie: Just to have it is enough.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34734
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


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 22, 2012 at 02:50:24PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 22, 2012 at 02:27:11PM +0100, Mark Brown wrote:

> > If we're worrying about that there's the larger point that the effect of
> > this patch is to make HAVE_CLK meaningless as there will be no platform
> > for which it's not true.  I was just leaving HAVE_CLK alone for now
> > ready to circle around on it if we ever manage to get the enabling bit
> > sorted.

> Are you sure that all architectures are fine with having that permanently
> enabled?  What about nommu architectures?

There's already stubs present so the main use case for depending on it
(checking if code can build) is already covered without requiring that
the API actually be built on all platforms.

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhVAlAAoJELSic+t+oim9wHkP/3pjlUZYyEHL/+8l9R1Dbbsz
2KyQ5ysAuyIN9csGAEpdLz1UO3TQDOVtNlTF2L6GVO6U2h3ollWkUS7PjNMOgaG7
G+/wrnmL2Yz2DVYD77Yt97OfOU86z407xIi4BldBkn2iTNxAycLJKPQnJgUGdHRA
aWr3BLsITwh8KHoA6DQU0MdOYzrIyKDuRuorPsKwI2MSzoHxxQMUN4XB9KuYg/rP
GhjS4TQ4wrgWHyiexZoqokflKZy47qMh90HKZa5qLOeIjQDayJf2x6//74vGohEC
kT6gAbZWcICpOribDs4BOoOwndn2LkGhQtohM9EVUf0MXf0oWxe6GhRz453/GD9h
qxTDyh4isI54N0AFhhIJYj08HnTkMzZgZHNsmgTKXF4M7t45bAnJ8pl5tcy5Oui7
xOHTVK6YnLaspOGS31hBTbJ3D9h3IJZNT5NPB4Jb51Xs4q1BT0n+jngoyqFIUMGl
dYpHT7PVAydDr2IbETqZHzfbG9xNvFu/a5lx/vwY5vag0m5Nz7+Bzp7erWG3kqly
sPFx3Wj0YT+f325IBKDdw0YFlUX0ieADA0VqqzpRoYDr8a7KHH4Jyn/xWo6jl5fr
wULv/EyVQA5VurCEQ6hQJ0fYPJVd98PNvMV0RnuE1AkqnjIr8uGEQD5y4Tuef1zk
FPqIsY70r00ijVnenqYz
=DIO5
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
