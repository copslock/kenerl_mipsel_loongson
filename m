Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:40:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeCLVkKZXVZf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:40:10 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ECCC204EF;
        Mon, 12 Mar 2018 21:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECCC204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Mar 2018 21:39:39 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
Message-ID: <20180312213938.GC21642@saruman>
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-3-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20180311174123.2578-3-hauke@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62929
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


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 11, 2018 at 06:41:23PM +0100, Hauke Mehrtens wrote:
> From: Mathias Kresin <dev@kresin.me>
>=20
> Enable syscon to use it for the RCU MFD on Amazon SE as well.
>=20
> Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use i=
t for the RCU MFD")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

I'm just trying to dig around to find some context. Just a bit more
information to say what DT / driver / device this helps with would make
all the difference :)

Does this directly benefit mainline (maybe for DTs other than those
in arch/mips/boot/dts/), or is it mainly for the sake of out-of-tree
code?

Do you want it tagged for stable backports, and if so how far back?

Cheers
James

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqm85oACgkQbAtpk944
dnp9uw//W7xNzWDF8oQLrdlTLh3gB6mF0PzDErYBjTQ+stY44qRC0DmuXn/qb+Ex
axBHBuHGwEa6u/589gS1LgQTUKhnaeT3QSqufCT67A5BvoQBpdGGd09WGIsywA7j
gBjocI7UXARrl3H1aKvzJHZKCYXdAuwSqe8VuJ9qu/EGQtme6lU514cETYsTToE7
URAJbE6HWOpTVqA5qE1UnWGWDaTfpWxxLAvJNkWfo9nFq0qSZRq3HATc1NgDmJq9
GKCzgaFJYMg05kAUDL3bNMaKJCzJxov5awueEmIH88Ql6ejZXbRq24zRg+owccwE
BtcIxy/UnRwwCAw4WyP+yUzpnMiN1yb0bXJRlybNo6MzjgAZKPnzpDTfznx2PICp
CnReb2uyK/0V8QFaSg0TjDm/iZqfuy/hnWI8ezTqam+Vt+9J96PHidFVSd3+xpgx
bTHqUJSm930xiYw41m9YcyBsw5Mq41XpFOZHJqnumB/viNIEtifSHoVa5T4P2fiq
Ah/tbV7eWA9mxBMhSpAfd6Fh7Mbu8NzPzoFGrP7Y1Ujyu627tc0zFhHKUTNOfhYE
jsFEVhVkMAMqYoJFnQe7e2qlaOJ3RSbvVwvD6DPD25ZxAGrvxEUgXMybFo06PdpV
LRRW7Em0xDf/GesK/ZjrKXNmde6opduzVXAl42KRuEsr6V251ek=
=rCbv
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
