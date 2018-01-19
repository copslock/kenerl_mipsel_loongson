Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 23:46:32 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992079AbeASWqZ5-PT8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jan 2018 23:46:25 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C9720835;
        Fri, 19 Jan 2018 22:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C9720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 19 Jan 2018 22:46:13 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] Final MIPS fixes for 4.15
Message-ID: <20180119224612.GA23840@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62255
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Ralf has been mostly offline for a few days, so I wanted to send this
pull request just to make sure these fixes got into the 4.15 release.

It is basically Ralf's final fixes branch from last week with the
following additions:
- One allmodconfig fix, which unfortunately missed todays linux-next by
  about half an hour. It is however purely a Kconfig fix and it has been
  build tested so I'm confident its okay.
- A patch to add myself as MIPS co-maintainer. Unfortunately this
  doesn't have Ralf's ack, but it has 5 acks from other leading
  contributors.

Please consider pulling.

Thanks
James

The following changes since commit 44cae9b209e5b8989f02515a343067159aab84e9:

  Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus (2018-01-09 15:43:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.15_2

for you to fetch changes up to 18696edce11e010a1151a779490d6025b497e400:

  MAINTAINERS: Add James as MIPS co-maintainer (2018-01-18 20:44:39 +0000)

----------------------------------------------------------------
Final MIPS fixes for 4.15

Some final MIPS fixes for 4.15, including important build fixes and a
MAINTAINERS update:

- Add myself as MIPS co-maintainer.
- Fix various all*config build failures (particularly as a result of
  switching the default MIPS platform to the "generic" platform).
- Fix GCC7 build failures (duplicate const and questionable calls to
  missing __multi3 intrinsic on mips64r6).
- Fix warnings when CPU Idle is enabled (4.14).
- Fix AR7 serial output (since 3.17).
- Fix ralink platform_get_irq error checking (since 3.12).

----------------------------------------------------------------
Arvind Yadav (1):
      MIPS: ralink: Fix platform_get_irq's error checking

James Hogan (6):
      MIPS: Fix CPS SMP NS16550 UART defaults
      MIPS: CM: Drop WARN_ON(vp != 0)
      MIPS: mm: Fix duplicate "const" on insn_table_MM
      MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
      MIPS: Fix undefined reference to physical_memsize
      MAINTAINERS: Add James as MIPS co-maintainer

Jonas Gorski (1):
      MIPS: AR7: ensure the port type's FCR value is used

Matt Redfearn (4):
      MIPS: ath25: Avoid undefined early_serial_setup() without SERIAL_8250_CONSOLE
      MIPS: RB532: Avoid undefined early_serial_setup() without SERIAL_8250_CONSOLE
      MIPS: RB532: Avoid undefined mac_pton without GENERIC_NET_UTILS
      MIPS: BCM47XX Avoid compile error with MIPS allnoconfig

 MAINTAINERS                   |  1 +
 arch/mips/Kconfig             | 12 +++++++++-
 arch/mips/Kconfig.debug       | 14 +++++++----
 arch/mips/ar7/platform.c      |  2 +-
 arch/mips/ath25/devices.c     |  2 ++
 arch/mips/kernel/mips-cm.c    |  1 -
 arch/mips/lib/Makefile        |  3 ++-
 arch/mips/lib/libgcc.h        | 17 ++++++++++++++
 arch/mips/lib/multi3.c        | 54 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/uasm-micromips.c |  2 +-
 arch/mips/ralink/timer.c      |  4 ++--
 arch/mips/rb532/Makefile      |  4 +++-
 arch/mips/rb532/devices.c     |  4 ++++
 13 files changed, 108 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/lib/multi3.c

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpidSwACgkQbAtpk944
dnrR6w/+P23mQhAQrIWQrhD0LkB3cbMNO66fJxlx4d+VSStCrFW90kR4j7td7vkM
F1Fi7yN2KuR33Z+8PONr8pbl/u5w+Ta9scHkVJRG64kNFuFLZAzj3eLgpEfz7TJO
a29j1I5Xz6fEeCH0M0NU60scC8PvqMo+PiU3xLI7VeV3Y0AJwLpYbG2XO+GQshMp
XxLeHO1ozw5HzxnKMSOlN7v1Louhrjq/icyPieS6fgdmOzdbYHHfFn8mDTyPzeH/
i+737ULAY3ruUE621da+RwLtPRzAW/ZNhVsr7bL7b9dHOYe/Scv1rv3JBQ8AQTQB
wWCVOLUZ8H7TZHlChLIQrwL+1pmnC8SENLrK3CtDGVX1RiNrIu/whpGHsqLy9Rtq
rPqo9t159XrQWJH0JKm5Yd5KzOVjDSB1/0JRgBKmh4bz/pzNE8vIK+p+Z78CUw00
c8gbIeOt+u+XsS0o8c1IBEmItYsN4nPk1OCALejJacCkkooAAfOJsq1IP4nw8nKK
JbpyblNJDJuok12HZF2jPDvT9D/witFlmI4wBc2yzcHLVA3xyok4rky9mI04y0iI
1bGGct5F7YlTaRJfR9aSiYforow0BZ04mrGOaPXQcJ8ktqT/dFVXxreNlAmmbAWg
8w9EVAHZoGfyrgcq1A9b6Ljg3HegPrjmnPW/aih7Y2x41zRKajI=
=Q5Ng
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
