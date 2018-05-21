Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2018 14:48:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994695AbeEUMsXqSuom (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 May 2018 14:48:23 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A7C2084A;
        Mon, 21 May 2018 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526906897;
        bh=QkSPA4cfycEgOssd8julPo5jVjTo7i84Uj75TJEWS2M=;
        h=Date:From:To:Cc:Subject:From;
        b=Jk3nCHUaM3HRyxvLf/QG05SDkNcp0O2Cme3bmVupOzUewsd1XCayxZ9WgQBTQum0O
         WQ7NxmpQVYdMEAM5ERZ5blrYWp7yPU8pzL5nt85/DF5lZze7o53H+Hic8Jdvsxatz9
         7D6mw1ynQuCb715iP/9LOLMsc1nsJ/KFOo66NOwo=
Date:   Mon, 21 May 2018 13:48:13 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.17-rc7
Message-ID: <20180521124812.GA9194@jamesdev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63992
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


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are some final MIPS fixes for 4.17. Please pull.

Thanks
James

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.17_2

for you to fetch changes up to 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996:

  MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs (2018-05-14 23:54:25 +0100)

----------------------------------------------------------------
MIPS fixes for 4.17-rc7

Some MIPS fixes for 4.17:

 - Fix build with DEBUG_ZBOOT and MACH_JZ4770 (4.16)

 - Include xilfpga FDT in fitImage and stop generating dtb.o (4.15)

 - Fix software IO coherence on CM SMP systems (4.8)

 - ptrace: Fix PEEKUSR/POKEUSR to o32 FGRs (3.14)

 - ptrace: Expose FIR register through FP regset (3.13)

 - Fix typo in KVM debugfs file name (3.10)

----------------------------------------------------------------
Alexandre Belloni (2):
      MIPS: xilfpga: Stop generating useless dtb.o
      MIPS: xilfpga: Actually include FDT in fitImage

Colin Ian King (1):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Maciej W. Rozycki (2):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs

NeilBrown (1):
      MIPS: c-r4k: Fix data corruption related to cache coherence

Paul Cercueil (1):
      MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770

 arch/mips/boot/compressed/uart-16550.c |  6 +++---
 arch/mips/boot/dts/xilfpga/Makefile    |  2 --
 arch/mips/generic/Platform             |  1 +
 arch/mips/kernel/ptrace.c              | 22 ++++++++++++++++++----
 arch/mips/kernel/ptrace32.c            |  4 ++--
 arch/mips/kvm/mips.c                   |  2 +-
 arch/mips/mm/c-r4k.c                   |  9 ++++++---
 7 files changed, 31 insertions(+), 15 deletions(-)

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwLACwAKCRA1zuSGKxAj
8i1xAP4sOTwHc69CIjdNJrHOQAEVYNehYf9QkkaD0anQKomJiwEAwZBvNiSH5AOc
c85fntGfIXoDEQCP6Di3clYNWRWRhAE=
=dR0u
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
