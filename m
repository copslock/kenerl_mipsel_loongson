Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 12:12:49 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:44856
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992408AbeF1KMlqAzeP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 12:12:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sLjAomOtuXWvaVG1ZuEX/AKvLyO6tTFXTKIwkqcWhYk=; b=WsYyHwaNTDQr6oUW6GvL9V05u
        hSprlOmzWI4z61FBx1z13PJo+drHSOz0gXIkDI5Rsd7Hjd8ErV8J5XzlGphSHLUZYelFiutNYZJwX
        XiDm3tFPg3k6SunEelcB/4dOgfByTSQHBAi4rqe9AJ4prUsloEj9+fq/0Fa43W0GOJ3vg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTun-0005CX-I9; Thu, 28 Jun 2018 10:12:37 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTum-0003hG-Jd; Thu, 28 Jun 2018 11:12:36 +0100
Date:   Thu, 28 Jun 2018 11:12:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     John Crispin <john@phrozen.org>, linux-spi@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Applied "spi: ath79: drop pdata support" to the spi tree
Message-ID: <20180628101236.GA14040@sirena.org.uk>
References: <20180625171823.4782-1-john@phrozen.org>
 <20180626145959.C26D7440070@finisterre.ee.mobilebroadband>
 <20180627160723.bhdiz5xmuuuz6fnr@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20180627160723.bhdiz5xmuuuz6fnr@pburton-laptop>
X-Cookie: Money is the root of all wealth.
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64487
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 09:07:23AM -0700, Paul Burton wrote:
> On Tue, Jun 26, 2018 at 03:59:59PM +0100, Mark Brown wrote:

> > Once Acked, this patch should ideally go upstream via the mips tree to
> > avoid merge order conflicts with the series converting the target to
> > OF.

> Could you possibly drop this from your tree & ack it to go through the
> MIPS tree along with the relevant platform/board changes?

Like I said in reply to John that says "should ... to avoid conflicts"
not "must because of build dependencies", in general it is better to
just wait for the removal to hit mainline with things like this as it
makes everything simpler and there's no urgency about something like
removing platform data support.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0tJEACgkQJNaLcl1U
h9CZJQf/d7ifrfNMW+tzOv+bx10WQFfJIUlkPVKPIONEq20U5G/YmGdNUgJEGPak
SKMENXVONSkXPtYFXKmiXLoP/df/Mjf5LmzGuXSzZt7weTdozlRD5glaNPzX/w5W
mTfycdyJCxhxSh3puZDUHSp/2CjeMi0fivu6V0r9mZxyde6sjr69j4+5MlFTIJuU
R+mMXe2SWfhGl2A6sX9wYAikGCH/5+eJrRGdnVazEcBsQINBpwF6BOmPMTe3tIZO
zncnxqW5aDZ/mGFXaFdpwOy+loTVg6G6DN8ZWfrQN9Capqdt9PvNRXDMugGttPLh
mSZz6BKOhN1kqtVM6+Yu9d6tf+FKpQ==
=xZ+H
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
