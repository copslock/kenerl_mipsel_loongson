Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 18:45:37 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991172AbeAZRpaF8Ypx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 18:45:30 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28DD217AB;
        Fri, 26 Jan 2018 17:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28DD217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 26 Jan 2018 17:45:18 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Sven Joachim <svenjoac@gmx.de>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ssb: Do not disable PCI host on non-Mips
Message-ID: <20180126174517.GA7637@saruman>
References: <87vafpq7t2.fsf@turtle.gmx.de>
 <20180126100902.GN5446@saruman>
 <87fu6su1mv.fsf@kamboji.qca.qualcomm.com>
 <87tvv8r1tu.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <87tvv8r1tu.fsf@purkki.adurom.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62341
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


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 07:01:49PM +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
>=20
> > James Hogan <jhogan@kernel.org> writes:
> >
> >> On Fri, Jan 26, 2018 at 10:38:01AM +0100, Sven Joachim wrote:
> >>> After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
> >>> wlan0 interfaces had disappeared.  It turns out that the b43 and b44
> >>> drivers require SSB_PCIHOST_POSSIBLE which depends on
> >>> PCI_DRIVERS_LEGACY, a config option that only exists on Mips.
> >>>=20
> >>> Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
> >>> Cc: stable@vger.org
> >>> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
> >>
> >> Whoops, thats a very good point. I hadn't twigged that
> >> PCI_DRIVERS_LEGACY was MIPS specific (one of the disadvantages of using
> >> "tig grep" I suppose!).
> >>
> >> Reviewed-by: James Hogan <jhogan@kernel.org>
> >>
> >> I think this is obviously correct, so it'd be great to squeeze it into
> >> 4.15 final.
> >
> > I'm not sure if I'm able to get it to 4.15 as it has go via the net
> > tree, and we have only two days before the (likely) final release, but
> > I'll try.
>=20
> Too late, Dave already sent his last pull request for 4.15. This will be
> in 4.16.

Okay, thanks anyway (and sorry again!).

Cheers
James

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpraQwACgkQbAtpk944
dnpSLQ/9Gg3MY7IqQYTE9ZHANZ6fyDd3B890rU4BNFoqtiAnckGlRonyWc7mhfaf
0/L3N9LDzJchxY+h8WLdzWEXm4l2tZkmnHExK8H4cfM7Ge3GGf+NUqHb8cYC4bN7
Obx7/rxJhhdQFHNOlKq4ZVyLARZ4fIn9nrCU0/qOZvCeIj1Yf2lR7Jwfa19MnVuQ
ewPt6DY1iYxeAVYOVNAetCkvOBAsQepa9LTFNY/7WQcD1MlHU3TDeH3+/nmGHDX9
CrRlezScTP2nK9dBA+NuYlJMzzsevkg29tUW2N328lS2gLF3WzoEXkDJW5/9ZeV6
WGZlVkpTThqp8/XT3yVCKwUPegQFHDtx52dxDWapedq+elvdP+c+k3yBfIq6nMsP
HfZ2xJMDKNoKAsCykcANeJC3tFm3LDEwaoq1lScmV75WfSX+cFAHitiuopa0taZ+
5C//vGuTFbug505UxgGm8tmAReL7i15fPwYr2fTLSGakop66uMuKxa7LnYNrJT9d
R9Y9EE5wONMByu/Ga9429IqlsO6+D2VQccW0FchebIqeAVnC8JsSnnCXCUiUJQPS
KsIBeavuOHOkba2w869+OWFjNEO6MKOhkCWHGVChg9/nVMpGfGxAsjJ65FKn2Wo/
8oxSrzovGxdclJCcrLr6jP2Dn7FNmobkOTUpncuc/57c+sJ0Kmc=
=+Osn
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
