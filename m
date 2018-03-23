Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 11:26:25 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994667AbeCWK0NOWid6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 11:26:13 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56502177B;
        Fri, 23 Mar 2018 10:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56502177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Mar 2018 10:26:02 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.16-rc7
Message-ID: <20180323102601.GA11796@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63167
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


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Please pull the following MIPS fixes for 4.16-rc7.

Thanks
James

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.16_5

for you to fetch changes up to a63d706ea719190a79a6c769e898f70680044d3e:

  MIPS: ralink: Fix booting on MT7621 (2018-03-22 00:06:30 +0000)

----------------------------------------------------------------
MIPS fixes for 4.16-rc7

Another miscellaneous pile of MIPS fixes for 4.16:

 - lantiq: fixes for clocks and Amazon SE (4.14)

 - ralink: fix booting on MT7621 (4.5)

 - ralink: fix halt (3.9)

----------------------------------------------------------------
Mathias Kresin (3):
      MIPS: lantiq: Fix Danube USB clock
      MIPS: lantiq: Enable AHB Bus for USB
      MIPS: lantiq: ase: Enable MFD_SYSCON

NeilBrown (2):
      MIPS: ralink: Remove ralink_halt()
      MIPS: ralink: Fix booting on MT7621

 arch/mips/lantiq/Kconfig        |  2 ++
 arch/mips/lantiq/xway/sysctrl.c |  6 ++---
 arch/mips/ralink/mt7621.c       | 50 +++++++++++++++++++++--------------------
 arch/mips/ralink/reset.c        |  7 ------
 4 files changed, 31 insertions(+), 34 deletions(-)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq01jkACgkQbAtpk944
dnplbQ//XUSg+C8C58hBOkwVcsODlMix6+pB6t3fpe0ut/Le/o90+koJLSvgAmjX
HDstUHZMjtXa/J51vd2TtksAbmZWGNSk92xXBJNLvIqCNf0nw+ZM25wP54itIDq9
w1e6jzh6ftwVARcaw+K8E/Vce2+ID3U/5kv1XBKvuCCaLZRfI4iZPBksd7Ro1Eio
rksbOOquzu1Hf/dcK1I2d6cUjgTuI7icwMXXewQya3m46od8WgDIN14tpMmrmJ66
48j9OWoIuaAWMPzCPsyGEYLqkWqoL6JrtZKW5AAZbR72sa009EqMnVKUuG2593fh
QCv9y+yMsAsOVZeEEcQm7gSNT0N8//X9OYZ7trvyyM7QM6XBgt7exw9HxoiC36IU
rZQl1/IcWBgndAjMvlAcF37X9af4yZeTqs99KhKHRO6TFtItcevzBmViLcRUxHEw
72R30LqxMju3Eu2B2kOjk0QJ8hgb1JfDGgCtoUHHWwRE4zA07c4AHuPjjEnwGojM
wv25WNB1amQV1nx+P0P14EgV3+dD7zcrHdG3nDgza8pwbqPUE4yijf0IJ//8vpxf
B/6OZlnWTnTksY2asC2/KXJqGyUro9tAGL67lSX6ZFx564bAW/LRcNhC8jH+HCbW
7kcg6ZUfv5s8KlykhxtQItZHZBflDqEhJm6IQuVIFtyqKm+MCD0=
=dxp2
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
