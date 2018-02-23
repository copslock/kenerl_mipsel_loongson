Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2018 11:16:36 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991128AbeBWKQ2iP2Yl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Feb 2018 11:16:28 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890AC217A0;
        Fri, 23 Feb 2018 10:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890AC217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Feb 2018 10:16:17 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.16-rc3
Message-ID: <20180223101616.GM6245@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62706
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


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Please pull this MIPS fix.

Thanks
James

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.16_3

for you to fetch changes up to 6ae1756faddefd7494353380ee546dd38c2f97eb:

  MIPS: Drop spurious __unused in struct compat_flock (2018-02-20 15:46:44 +0000)

----------------------------------------------------------------
MIPS fixes for 4.16-rc3

A single MIPS fix for mismatching struct compat_flock, resulting in bus
errors starting Firefox on Debian 8 since 4.13.

----------------------------------------------------------------
James Hogan (1):
      MIPS: Drop spurious __unused in struct compat_flock

 arch/mips/include/asm/compat.h | 1 -
 1 file changed, 1 deletion(-)

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqP6fAACgkQbAtpk944
dnrzxg/+P8gk5BI6f5cyDCBHGcaRRgxb+2Za4WWUgpT46+K+AM8aRFtX4ipd2j/n
8KoR1cZP39TUZOY+/Gz3g6eC585tE8BGBPzqO8py//cJjOOinlVZ3MDAzq5MUO9f
fQX9xbXALKtAqaMvJAh1i0FsVZO6S74NWxvHnwqmJzSSqX6o2fH+V+zVbfMvMc88
9/A/2LGOG3QNoKyTXbPAMAKloGeBIdgkcq8x8BVtKgbsG/SRbwPYcsJKYp6hEm7m
vW52iUelBuKnKtq+xiFpXZ1PVNAxrXBooAS5sSFoktv5LGNixiKCH+hac6ez9bsK
msiomv3mgR2mTGFRa69csBRsOWAgbWBLwxIhrw0/6NgE2LmiHNV1OPyvVS+mx7id
knoseDximogShHR/Ez6+DyZPwwZIEzxTS3Y63JWCdqJUisT78w93MAIoWLinAu12
DevANkvg6ek9W+5FEnWRYMkxnwN6LD3eZYUKCobr5SOcF6HADUupT4ahHjCET6gg
8MXhSM75qS41nE6U/WZHEDDqrXn5JkfIYGnFX0+50NPlylCExdyoxYj1rNIkFo8L
CfRR0rQPwzkaKi4CNZi2UOoFvpMAxcJPekOSmFmWePJ0C6P3LInCHytqQLFM1cdA
rKvKas7dSCVQPpj1DH7h4/y8ELvmongCNmBLIr3T4fC8/1oG6kc=
=E48s
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--
