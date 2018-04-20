Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 16:22:03 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990480AbeDTOV5XEGfw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2018 16:21:57 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B342178F;
        Fri, 20 Apr 2018 14:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B342178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 20 Apr 2018 15:21:46 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.17-rc2
Message-ID: <20180420142145.GA1521@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63643
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Please pull the following MIPS fixes.

Thanks
James

The following changes since commit a5075e6226c42a8e64ea1b862eec7747dc46cb32:

  MIPS: BCM47XX: Use standard reset button for Luxul XWR-1750 (2018-04-07 00:10:48 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.17_1

for you to fetch changes up to b3d7e55c3f886493235bfee08e1e5a4a27cbcce8:

  MIPS: uaccess: Add micromips clobbers to bzero invocation (2018-04-18 22:02:29 +0100)

----------------------------------------------------------------
MIPS fixes for 4.17-rc2

Some MIPS fixes for 4.17:

 - io: Add barriers to read*() & write*()

 - dts: Fix boston PCI bus DTC warnings (4.17)

 - memset: Several corner case fixes (one 3.10, others longer)

----------------------------------------------------------------
Matt Redfearn (5):
      MIPS: dts: Boston: Fix PCI bus dtc warnings:
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup
      MIPS: uaccess: Add micromips clobbers to bzero invocation

Sinan Kaya (2):
      MIPS: io: Prevent compiler reordering writeX()
      MIPS: io: Add barrier after register read in readX()

 arch/mips/boot/dts/img/boston.dts |  6 ++++++
 arch/mips/include/asm/io.h        |  4 +++-
 arch/mips/include/asm/uaccess.h   | 11 +++++++++--
 arch/mips/lib/memset.S            | 11 ++++++++---
 4 files changed, 26 insertions(+), 6 deletions(-)

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrZ93kACgkQbAtpk944
dnr1fg//cScKSpDyfrVmdRtj28q63ukxQqmRCPHXyBEeEvRZlkZcqAHyjdPY+z1t
MXsQnftbdgo2beLMR1+M9FtQJKqp3gopex5YIytT0GPpxvAO5yJKHnnCSU184qrR
hrb1yzKJbPIRSxXkXFWVxpdTEItLoS2zsQGGrPpMEBTydRVFv01LclmJC2nWYlkx
KvCMfoKoQw0SeMTxxbEC5mgjrOqq//K0R66aMgAv+7oAHhfR/jkR5YIXsgHig3A+
R8KTP7yrf+X298z4533uZJaJ1ROKuyjmauCffAv3Ey1nIWerfWBz5mBPll6+xefh
l8qAz9XsVvta89DVWORnIVcH0FkfX0w4dKfaCM10xPofwwgjAf4rHMdJOarKq64C
c5ieZE4QKvfriJLrrfPWrrH1idma3dZiCnSLRh4XA8c/czzOzCiGXn38GdIk3k46
c6QUfnpZl1+aITxHarnAPAJVxNBuchRUX+++Uemz6ZZo/gHT0elTjFxqoo1oHrwG
6E2U8hwRCwwsux9RiQNzaGi91ATYIDTOsCqpo7CJG78WRF4XRRWJP7z/S9m55k5v
Ln9agMrF9ohhafn0e9ZP6u+BiykMoUGjZn/RWEO3mU+CdJGgGnCBPZQPhlg6500L
pPPtwcBMq+8Zn9F58ElyqTVch5DMVZzFWh4Fgj5lNtbnmSsDDRk=
=rrQU
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
