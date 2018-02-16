Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2018 13:29:38 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990425AbeBPM3cPI8Wi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Feb 2018 13:29:32 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819FD21777;
        Fri, 16 Feb 2018 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819FD21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 16 Feb 2018 12:29:19 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.16-rc2
Message-ID: <20180216122918.GB16654@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62571
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


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are a few outstanding MIPS fixes for 4.16-rc2. Please pull.

Thanks
James

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.16_2

for you to fetch changes up to 5efad9eee33ee5fc4bf3059f74f3932a638534d1:

  sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC} (2018-02-15 21:45:16 +0000)

----------------------------------------------------------------
MIPS fixes for 4.16-rc2

A few fixes for outstanding MIPS issues:
 - An __init section mismatch warning when brcmstb_pm is enabled.
 - A regression handling multiple mem=X@Y arguments (4.11).
 - A USB Kconfig select warning, and related sparc cleanup (4.16).

----------------------------------------------------------------
Jaedon Shin (1):
      MIPS: BMIPS: Fix section mismatch warning

James Hogan (2):
      usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
      sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}

Marcin Nowakowski (1):
      MIPS: Fix incorrect mem=X@Y handling

 arch/mips/kernel/setup.c     | 16 ++++++++++++----
 arch/mips/kernel/smp-bmips.c |  2 +-
 arch/sparc/Kconfig           |  2 ++
 drivers/usb/Kconfig          |  6 ++++++
 drivers/usb/host/Kconfig     |  8 --------
 5 files changed, 21 insertions(+), 13 deletions(-)

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqGzp4ACgkQbAtpk944
dnrw2w//cQDZLSfqFH94obyI/ENwQb/ZDHDAEl64eIPwy1hoeE4OqDF6eT0uftLo
5VZusGkUQBPWnBvJEg7y9yFsw2GJk1+5dr20UCOHNMNRwi/5hyEp29u8GcHCPpkO
oQ70gYa+R0VFIPdeXlk8hhwKFM+yNEgefrpzwmtde41dLWABZEpRCCnx8ozCwfXG
t1hJi/Db0E/4qaT9Xeb0UrIuXTMzFtrzN5fPydhPTO95PeVGQrGdzQmK6QvMiklt
aHDyPhWDQbK6Xh1XmEf56J+Ql6eJSgsQcdxeGhaek3VMzJx4nmmaR3tCcZuazpwb
NKltZEy8FR/U9zp1NMGJdkqvUeqrkyc+CxiisF2EFUIqDYoZZMDBIu5WHLOFZ3qf
6MduL0nkBBS4OovAkWbRoFlSbIyNwQ3xcbmlUbCkMMD/EobubsnhlnbqJ0Yzzd/u
UqaRFrzXncrFJ9CFrtuiJQeBw4/1eaGogLAJddpt/aXZ8+o5joPQ98eB9UfJfghv
cTH0pn6ot6dM090HDcJTsb+3LPffzSApvZCVlGDZr3IgWXvK9neZbldwqFuSd7cl
wuf8t6TgH48csAgBB26hijAH0/XlBCjcJfifHV5+e2Mn52Uqi6FeKwTXnbkcyGDE
OJaYtTCXyL+kmR7QE8IGWr3JmwewLaOlaV4+MNB/4UMFEsG4j8k=
=jErB
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
