Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 14:42:04 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeBGNl5HR1Cq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 14:41:57 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B7D21738;
        Wed,  7 Feb 2018 13:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B7D21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Feb 2018 13:41:24 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.16-rc1
Message-ID: <20180207134124.GB8649@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62453
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


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are a couple of MIPS fixes for v4.16-rc1. These are separate from
the main pull request as one of the bugs fixed was only recently
introduced in v4.15-rc8.

Please pull.

Thanks
James

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.16_1

for you to fetch changes up to 0cde5b44a30f1daaef1c34e08191239dc63271c4:

  MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS (2018-02-05 13:32:17 +0000)

----------------------------------------------------------------
MIPS fixes for 4.16-rc1

A couple of MIPS fixes for 4.16-rc1, including an important regression
in 4.15 and a rather more longstanding corner case build fix.

- Fix CPS regression on older binutils due to MIPS_ISA_LEVEL_RAW fix
  (4.15)
- Fix allmodconfig + CONFIG_MACH_TX49XX=y builds due to incorrect use of
  IS_ENABLED() (2.6.28)

----------------------------------------------------------------
James Hogan (1):
      MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout

Matt Redfearn (1):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

 arch/mips/kernel/cps-vec.S      | 17 ++++++++++++-----
 arch/mips/txx9/rbtx4939/setup.c |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp7AgMACgkQbAtpk944
dnrwGQ/+P2r7iDunJ1uhaRmEYVyOOEEObriMqK+n3Mip7uJX9ZW14HynW1RZ1QO6
lMhKVmFNT+Pp4EBHcztAfn0jizEEXQwWMSuPDj44ATwYVmlTZR1DNgMqnBr/S2vS
i1FOtN/wg5OboMQdr1LzlNnWSXJAECbPJ3ZaE0uJmZalqhpi2KkvojTM/CK2/X7i
UtXrhZFRu7V3A/mUdua2f0E0NeHdNXX04kl7JK++ZVzAaSh0zHEoqpvrg9baHaG0
pfNioaCoNJoUDVKvNVT4TJFsXLHbbVNalUSEdymqzAj71fgf+GajHX36XkTY39KD
VIv4DLx/5C+4ZGnkcp76emjt9xhuZiUSmkanPcpqj73egtQ5HX91whZTF9OyuqbJ
ANs+bAEKX0qqEoytOpWL6YgwEVKkh/pxreqRMCv3+4/aW1E6ObEJn4zWNInZVIIv
BAVzXtCEO77G60k9Oje+ZGN9erdDjfN5qfD4X6HwIh2dJ1g/vL0egqSOgymAj6Fq
QYqORVDaogAFKdP+iyQIJ4slPEZRlsdgvTjmoejDXGGr7F3mInQzVeNyRKFtOOQ4
8sx1NHeIw4VFK2pk4ahkOGO2C7Iw90oX34EvMaF8zdD6U7IpQyaUARs2ejcgLBYh
wLbkc/H6hrKZhidjBXV+0gmxFpW6PuL8e3TGRilj7dNa54ZqrJE=
=vjLX
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
