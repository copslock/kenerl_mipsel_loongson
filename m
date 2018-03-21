Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 00:53:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbeCUXxBhxEuP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Mar 2018 00:53:01 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF27620685;
        Wed, 21 Mar 2018 23:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF27620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 21 Mar 2018 23:52:50 +0000
From:   James Hogan <jhogan@kernel.org>
To:     NeilBrown <neil@brown.name>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: remove ralink_halt()
Message-ID: <20180321235249.GC13126@saruman>
References: <87370v9mkg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <87370v9mkg.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63141
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


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 07:29:51PM +1100, NeilBrown wrote:
>=20
> ralink_halt() does nothing that machine_halt()
> doesn't already do, so it adds no value.
>=20
> It actually causes incorrect behaviour due to the
> "unreachable()" at the end.  This tell the compiler that the
> end of the function will never be reached, which isn't true.
> The compiler responds by not adding a 'return' instruction,
> so control simply moves on to whatever bytes come afterwards
> in memory.  In my tested, that was the ralink_restart()
> function.  This means that an attempt to 'halt' the machine
> would actually cause a reboot.
>=20
> So remove ralink_halt() so that a 'halt' really does halt.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>

Thanks, I've cosmetically tweaked the commit message (mainly reflow to
72 characters) and added:

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Cc: <stable@vger.kernel.org> # 3.9+

and applied for 4.16.

BTW, I'm intrigued to know if there's a particular reason you don't
author / sign-off as "Neil Brown"? Its supposed to be real names, though
"NeilBrown" is hardly difficult to figure out so I don't actually
object.

Cheers
James

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqy8FEACgkQbAtpk944
dnocMBAAwMcM/Wl7R8i+9/r0Vbda5XdgMxOVOjqEG2FRcxCy0XRSbQiwjvOBn1es
L4AnIIhYJxkb0UEPXo3E82yf6ZHwWVnTO1W+IpgiRzzDjySIE7K6Nksl2mCRH34O
isELVoDxMpiqkVVWsp37B5mILf5vmizFvhr/q1pJla6b+fSEb8TWmlN6rsA4vb6j
pJ6PBPLYLJUDlq0oORFsq12LikI3+kpn2ToHMV37IOSdTlB8n4w9T/jtOueQwYbu
NDP5BZUL8pABu/pcDq9XkqWgNcR9Wpee3SWFYSLYwoowFPeDYcUmAi7B3MqRCfbv
S8VJU/zxa5CoPWtDkVgfRrb6e+jhn2tNEpYWUTwo+mG8U+7vp99Tejtje/HWuBCN
QYOvZ9kjdJwjgmhngiP4SKrsJMuPVLCpmDf8Dv5KyZT226xROAiv5XFD2XmrR3jY
B+UV8kD5y6RhmMTQfl9cIMplYWqSIgdN2ugya8jsUGvn+7qauXnQP/hxqdga6lKW
cxQG4Hu8NpXjXSVMpYgcLaFEpPgK7ioL7oRoMC6hbE+Pq+MiOwAQUv2Sii3zr4lW
0KrGwb1yYpBfufKBRCoELIQPuFcKy5tJ/9C1UJbjqhZnDNXr1OF7NhetY9fZPwFK
esh4DLxQJMUO3Koij1swK+bRba/gpIOtDd93KgubH9+wqKNCnuc=
=1kWr
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
