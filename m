Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 01:07:06 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:43688 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855028AbaG3XHBK0soy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 01:07:01 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 183D71400D7;
        Thu, 31 Jul 2014 09:06:56 +1000 (EST)
Date:   Thu, 31 Jul 2014 09:06:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        Alex Smith <alex@alex-smith.me.uk>,
        "Huacai Chen" <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
Message-ID: <20140731090650.2f1c255c@canb.auug.org.au>
In-Reply-To: <53D9169D.3020705@imgtec.com>
References: <53D9169D.3020705@imgtec.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.24; i486-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pnPHiMbaeCkUor0_3hDfy6E"; protocol="application/pgp-signature"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Sig_/pnPHiMbaeCkUor0_3hDfy6E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Wed, 30 Jul 2014 17:00:29 +0100 James Hogan <james.hogan@imgtec.com> wro=
te:
>
> v3.16 is fast approaching and there are quite a few important MIPS
> patches pending. Since Ralf appears to be unavailable at the moment I've
> reviewed and applied some of those patches which are least controversial
> to a fixes branch with the intention of sending a pull request to Ralf &
> Linus so that one of them can hopefully merge it before the release.
>=20
> Please could the following branch be added to linux-next:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
> branch: mips-fixes

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/pnPHiMbaeCkUor0_3hDfy6E
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJT2XqPAAoJEMDTa8Ir7ZwV9eMP/0QTglmlKOO8PYgnemNkFUME
akCJpfPIaj+FJHQFUaRdYU4Y/Xp0p6s11DN1CBfkQZAR+I4WYPhsYSFq2d/ddhX0
GrHpXIL7B7TPwgeAfBmP7uFTbTtfV2wKj0Ct4aTpFjUpQ1QW0PkjRptMFSqKcXVd
Bp7ymI3KxxdzgzCamPUWvZLwkWfxswXuN56kc1UNLcNojIA75TuJVdtjdg052BuL
C+SiyXe1e4qmeDjgEe91bAyOEVT8HEvpuOQlfvSltyhraOHn/YEUwc4LD3tj+e33
8uuHDB4bbz1swCajj1sbo98PEpCAMAijAeKjQdIBaRqNmtsrcn3DkOw5SjPtihhy
CzJdLIPqabohIE0kp4+Fenux61EfPyL83HHvRfkOaY3LoLLysHpb/b5nSH3nMwXV
WpMl0b77lrFy2hZBCDiYYbYooqpPTMdNmuXDf6/FeLCY6bsOknvRGl2ILS2gppti
nfG5CKF+ehCjIvrGxnbitV4TPkS7OVsFcibl+ecYOUerA6GrKKaNipERE6UAl/sE
jxT+oW+igRLdGyw0nB6aiISIOViDYnCucJxevKFE5YnI4lQni4pvdnqVDbl3CvTq
xgnC5dN6koQjJWo7QRaJQaDkx0HBliPJQy2snluB4yJ4Vps7xG2yS5kFB1SLe4AP
uOg7EEhUXBEBCLSKQaHC
=5qDw
-----END PGP SIGNATURE-----

--Sig_/pnPHiMbaeCkUor0_3hDfy6E--
