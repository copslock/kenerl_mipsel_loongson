Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 01:12:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbeCVAMHS7wNP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Mar 2018 01:12:07 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B931D21749;
        Thu, 22 Mar 2018 00:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B931D21749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 22 Mar 2018 00:11:56 +0000
From:   James Hogan <jhogan@kernel.org>
To:     NeilBrown <neil@brown.name>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: ralink: fix booting on mt7621
Message-ID: <20180322001155.GD13126@saruman>
References: <87efkf9z0o.fsf@notabene.neil.brown.name>
 <87605r9mwf.fsf@notabene.neil.brown.name>
 <871sge872l.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <871sge872l.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63142
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


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 02:02:10PM +1100, NeilBrown wrote:
>=20
> Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621
> has not been able to boot.
>=20
> This patched caused mips_cm_probe() to be called before
> mt7621.c::proc_soc_init().
>=20
> prom_soc_init() has a comment explaining that mips_cm_probe()
> "wipes out the bootloader config" and means that configuration
> registers are no longer available.  It has some code to re-enable
> this config.
>=20
> Before this re-enable code is run, the sysc register cannot be
> read, so when SYSC_REG_CHIP_NAME0 is read, a garbage value
> is returned and panic() is called.
>=20
> If we move the config-repair code to the top of prom_soc_init(),
> the registers can be read and boot can proceed.
>=20
> Very occasionally, the first register read after the reconfiguration
> returns garbage.  So I added a call to __sync().
>=20
> Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good. I've cosmetically tweaked commit message (mainly reflow),
added stable tag for 4.5+, and applied for 4.16.

Thanks
James

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqy9MsACgkQbAtpk944
dnpeRhAAgaN+l55tjGiZQDJHe1nyfKRmTuiLe1wjiQXvsWOnWX9AqujyYQQfZDbm
g8ETcjZ+7v5PBACougYqEsMCqAlxArltuZ5M0Gxf9fRbeWyLXNhUiD2mp28F6YeE
rxFU6Pmosfq5MV+4zRgGwu0nha6rAm4PYT/5MHud0/3ySXBLjwIYma5iPG3omyBH
Y2VupoBU/Bv514QhCI77JyYvRunbZjycOt0EaIIHXskJE8262lZDstuaOS1204BS
m8RIQFXCEnncQY3ctcarY7txb5kvh0r6Je1zoe/gHPnD0BSzneAd/kT5f+UDckcW
tkcqHzaVd7DCB7uiAOuvueVxFYnP27M0nEcO8betmqhYMqDK88AtSBZBD/P+NgHl
ZMhy0s1/+beSInIYNfzIOEXVhB8QxJZ1VdKx6KXgNfzr4K+VqhzAgitrhhluSrhr
QMnYhQU6Eu/xi55Q/zq9dPqzDMv/iEosEbBQJA5I4w4ds8JSNEaUVFFoeQwv8zoZ
5yyoiHQP0TbwwvBx8fdV9hyv9wBiMdcZtVaXjQ7Ve59Bv/21zBlNk17A4nMxG4Qb
g6BynzFlAe80bB8xYhr/ses2+Tjp4Cj8JjAjhXIVSGqkJlGOKXpoFL9AAXaLGS09
1gk4nX9DMplOT5+o3y4jB0izJs+Q3ETpWnRsF5g7tfKoPMWPHcQ=
=c5hx
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
