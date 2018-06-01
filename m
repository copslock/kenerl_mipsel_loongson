Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2018 00:25:44 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992521AbeFAWZeppKJE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Jun 2018 00:25:34 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8302087C;
        Fri,  1 Jun 2018 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527891928;
        bh=0gOAkW57BGv2ZQfdn11PTMQdJel/4N2eLzlndkJfAnU=;
        h=Date:From:To:Cc:Subject:From;
        b=fLaRdDQjGj71yGTxmygScQ8aw/Tm0QgtTvnxWp25cRUOpvUgSLgRhYrxScuTRXdUY
         PHTIbQBIasGj1fblOjnQ4DcTzPHNdxRxE94c8sl3XakwxqMY6jCTIkfeDUOnP848ei
         Eyu4kFhkuj1UCfEeZenVZ8V4DBgVDsLUOAMWSwCc=
Date:   Fri, 1 Jun 2018 23:25:24 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] Final MIPS fixes for 4.17
Message-ID: <20180601222523.GA11827@jamesdev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64146
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are a final few MIPS fixes I have queued for 4.17. Please pull.

Thanks
James

The following changes since commit 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996:

  MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs (2018-05-14 23:54:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.17_3

for you to fetch changes up to c7e814628df65f424fe197dde73bfc67e4a244d7:

  MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs (2018-05-24 14:03:14 +0100)

----------------------------------------------------------------
Final MIPS fixes for 4.17

A final few MIPS fixes for 4.17:

 - Drop Lantiq gphy reboot/remove reset (4.14)

 - prctl(PR_SET_FP_MODE): Disallow PRE without FR (4.0)

 - ptrace(PTRACE_PEEKUSR): Fix 64-bit FGRs (3.15)

----------------------------------------------------------------
Maciej W. Rozycki (2):
      MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Mathias Kresin (1):
      MIPS: lantiq: gphy: Drop reboot/remove reset asserts

 arch/mips/kernel/process.c  |  4 ++++
 arch/mips/kernel/ptrace.c   |  2 +-
 arch/mips/kernel/ptrace32.c |  2 +-
 drivers/soc/lantiq/gphy.c   | 36 ------------------------------------
 4 files changed, 6 insertions(+), 38 deletions(-)

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxHH0gAKCRA1zuSGKxAj
8or0AP9i/l1DDmxiLIk1FfTN+bLLsIjAuAFr07T2oiGifCy5agD+LFzglaE9D2CW
1BcD4F6miB4KZost7h4GczEmaJwSKA0=
=sYbH
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
