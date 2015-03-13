Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:35:45 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:46516 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008710AbbCMRfnq9E0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:35:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A2FF0460AF0
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 17:35:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ijbgVR6XyibX; Fri, 13 Mar 2015 17:35:36 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 14A8E46062E;
        Fri, 13 Mar 2015 17:35:36 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YWTUl-0000QZ-RN; Fri, 13 Mar 2015 17:35:35 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
Date:   Fri, 13 Mar 2015 17:34:52 +0000
Message-Id: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Octeon II CPUs can switch from Big Endian to Little Endian freely
even in kernel/supervisor mode.

These patches allow an EdgeRouterPro to boot in LE mode with no
hardware modifications.  They have not been subjected to extensive
testing yet and should be considered experimental.  (I have seen some
strange memory corruption in libstdc++ which I haven't yet been able
to trace.)

Parts of this patchset are based on the "GPL" sources released by
Ubiquiti.


Paul Martin (6):
  MIPS: OCTEON: Tell the kernel build system we can do Little Endian
  MIPS: OCTEON: Ensure CPUs come up little endian
  MIPS: OCTEON: Turn hardware bitfields and structures inside out
  MIPS: OCTEON: Set appropriate endianness in L2C registers
  MIPS: OCTEON: Reverse the order of register accesses to the FAU
  MIPS: OCTEON: Set up ethernet hardware for little endian

 arch/mips/Kconfig                                  |   1 +
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  45 ++++
 arch/mips/cavium-octeon/octeon-platform.c          |  12 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 137 +++++++++++-
 arch/mips/include/asm/octeon/cvmx-address.h        |  67 ++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  55 +++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  14 ++
 arch/mips/include/asm/octeon/cvmx-fau.h            |  22 ++
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   7 +
 arch/mips/include/asm/octeon/cvmx-l2c.h            |   9 +
 arch/mips/include/asm/octeon/cvmx-packet.h         |   8 +
 arch/mips/include/asm/octeon/cvmx-pko.h            |  31 +++
 arch/mips/include/asm/octeon/cvmx-pow.h            | 247 +++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-wqe.h            |  71 ++++++
 drivers/staging/octeon/ethernet-tx.c               |   3 +
 drivers/staging/octeon/ethernet.c                  |  10 +
 16 files changed, 738 insertions(+), 1 deletion(-)

-- 
2.1.4
