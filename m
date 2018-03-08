Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 14:46:43 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994745AbeCHNqflSZph (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Mar 2018 14:46:35 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353E0205F4;
        Thu,  8 Mar 2018 13:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E0205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 8 Mar 2018 13:46:24 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.16-rc5
Message-ID: <20180308134624.GB5187@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62857
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


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Please pull these MIPS fixes for 4.16-rc5.

Thanks
James

The following changes since commit 6ae1756faddefd7494353380ee546dd38c2f97eb:

  MIPS: Drop spurious __unused in struct compat_flock (2018-02-20 15:46:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.16_4

for you to fetch changes up to 06a3f0c9f2725f5d7c63c4203839373c9bd00c28:

  MIPS: BMIPS: Do not mask IPIs during suspend (2018-03-05 23:35:04 +0000)

----------------------------------------------------------------
MIPS fixes for 4.16-rc5

A miscellaneous pile of MIPS fixes for 4.16:
 - Move put_compat_sigset() to evade hardened usercopy warnings (4.16)
 - Select ARCH_HAVE_PC_{SERIO,PARPORT} for Loongson64 platforms (4.16)
 - Fix kzalloc() failure handling in ath25 (3.19) and Octeon (4.0)
 - Fix disabling of IPIs during BMIPS suspend (3.19)

----------------------------------------------------------------
Colin Ian King (2):
      MIPS: ath25: Check for kzalloc allocation failure
      MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Huacai Chen (2):
      MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_PARPORT
      MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_SERIO

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Matt Redfearn (1):
      signals: Move put_compat_sigset to compat.h to silence hardened usercopy

 arch/mips/ath25/board.c              |  2 ++
 arch/mips/cavium-octeon/octeon-irq.c |  2 ++
 arch/mips/kernel/smp-bmips.c         |  8 ++++----
 arch/mips/loongson64/Kconfig         |  6 ++++++
 include/linux/compat.h               | 26 ++++++++++++++++++++++++--
 kernel/compat.c                      | 19 -------------------
 6 files changed, 38 insertions(+), 25 deletions(-)

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqhPrAACgkQbAtpk944
dno59Q//bucsE/sIKgKSUpIVJILOA7v//feM96WIpPioSbxYVZ//J8Vn0jYwkjpx
dcNCsb31Oc9zdKAQ3tWcxmJWf/JiQL5khEJK/9pT6pjn4O0uI+EFcaZ/t/N46WXO
pLrGQUFkNTiMUQzmxvCy+zyd1cFb9M1K+mMZiQWgv+eOLxjB1yQSkZFdA6DpWAgV
RVc0DK2sj6zyprO4sDrlJVrQ19Bi96ZVEIQmyR+u894B3dCa7ycAbOn9/D8yvf2U
gPsheBmCJMgqVuUW5CPQJ0yST7iEtQDxe/WtrGTv49eFymAOMWRlILU8yIk42foj
d2i8hd2fBhqB1EwJ9Y8/kP6sW+xYoneOaEmnZIERkJK5+ixqyWmASiLX5bWbpxaV
t0dvty080VmdpkPRA2mTpGuzmfuMJBVFfISfNkqItch6LHf9X9A0lQ7pCQOh0Oco
nl5R3AraNPVt371l0SopUCQnZWyFuDoHxClW9blVhArXlahKOYT2wKvPzpWPKhh2
ofkpzbq6u48+0L+gU84PJNjlWCtNfhKMglBp+I0qPOn6ZVXbh+DIKy4Y/1Rc9IXW
8aVZ1li1vTDioncJ/7wxgHTs1IchyBOhywQj05oPH8z0jIpm9W7km7VKE4279+8+
h9t4l0WzBBVCEpX+CUTlERPOj7vyArgLrSpR8J10XIvAx/LK0Lc=
=zfEe
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
