Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 12:48:22 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992896AbeBMLsNcCR8I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Feb 2018 12:48:13 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DD221773;
        Tue, 13 Feb 2018 11:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DD221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 13 Feb 2018 11:47:38 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS changes for 4.16-rc2
Message-ID: <20180213114737.GC4290@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62515
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


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Please pull the following change, which allows the new Ranchu platform
to work in SMP configurations.

Thanks
James

The following changes since commit 8f2256d8eaf5acef3b49ea27edf79cc1069c4de9:

  MIPS: Malta: Sanitize mouse and keyboard configuration. (2018-02-06 15:50:15 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git mips_4.16_2

for you to fetch changes up to 791412dafbbfd860e78983d45cf71db603a82f67:

  MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base() (2018-02-08 14:02:01 +0000)

----------------------------------------------------------------
MIPS changes for 4.16-rc2

A single change (and associated DT binding update) to allow the address
of the MIPS Cluster Power Controller (CPC) to be chosen by DT, which
allows SMP to work on generic MIPS kernels where the bootloader hasn't
configured the CPC address (i.e. the new Ranchu platform).

----------------------------------------------------------------
Paul Burton (2):
      dt-bindings: Document mti,mips-cpc binding
      MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

 Documentation/devicetree/bindings/power/mti,mips-cpc.txt |  8 ++++++++
 MAINTAINERS                                              |  1 +
 arch/mips/kernel/mips-cpc.c                              | 13 +++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqC0FkACgkQbAtpk944
dnpphQ//cTY+unE+36XPpsXUEMzTxQJvvmiBckTwV/lvwvTdmOelvkuKCm3xg1oy
kt+mVAgYTu5byiKZzTyKGTBMXuRkBIqVkuuNDJsMbtvRRRMRm4JUYhBpZ3oSp34r
2/CEMuojKWJfMesdF0OKZtMVsGPg5H4ggf+J+BbOJZTaaqFieqly23brFAClgPFF
Je2r9sscJn7lBuiCmxa0fSVKosOX3mDApRbgoxxNrSoO9yhtE5axmAMA7KoWihdO
OAzg7KrYzeTY5yR1+WyIrAVp9llDm+lGgE13WuCYNP5PvBtd48rT59do3Gj7hXU4
p3vovyrUMSW6hdLe6QZ6YDYcNWnN40wnUf4yl5n8tMPORGnjLm7nGrZsoxamuibk
GVqXrDbXorcbARr1QZCzetuPoN3Nb/gZ8E6aNUvq94klnZkLU0GPvE+w+0iIIYI0
ICNsPm1OAaQv1FCgjRMhoKR/byIN6oMBvoShSDmpkX/GCvl5oyg0PB56MTkrjo8V
oJVW29U/AlOAucWRgSJkT2xHcJFcCRLGg4jEaGQeg/6HZjwA/LQ+vrmYwHK2/qRW
v1z06Kn4/0wsz0kVvAlkq0/BWwTwwG7ouGIIDuWV7O2SxV3UYzSA5+/i8pKRZEyN
iwrIZvAnO5xulbZr6K6cKRoVZlV8WnEE7tjr7640UfeBxcaA2kw=
=X9ex
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
