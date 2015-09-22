Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:12:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10036 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008780AbbIVSMnY2a5U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:12:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DEE2DAC2739B0;
        Tue, 22 Sep 2015 19:12:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:12:37 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:12:35 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 00/10] CPS SMP fixes & debug improvements
Date:   Tue, 22 Sep 2015 11:12:08 -0700
Message-ID: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series implements some fixes for the CPS SMP implementation on some
systems, and improves debug by allowing exceptions to be handled &
dumped to an ns16550-compatible UART.

Paul Burton (10):
  MIPS: CPS: set Status.BEV bit during early boot
  MIPS: CPS: set Status.KX on entry for MIPS64 kernels
  MIPS: CPS: early debug using an ns16550-compatible UART
  MIPS: CPS: read CM GCR base from cop0
  MIPS: CPS: skip Config1 presence check
  MIPS: CPS: warn if a core doesn't start
  MIPS: CM: fix GCR_Cx_CONFIG PVPE mask
  MIPS: CM: introduce core-other locking functions
  MIPS: CM: make use of mips_cm_{lock,unlock}_other
  MIPS: CM,CPC: ensure core-other GCRs reflect the correct core

 arch/mips/Kconfig.debug            |  26 +++++
 arch/mips/include/asm/mips-cm.h    |  34 ++++++-
 arch/mips/include/asm/mips-cpc.h   |   3 +-
 arch/mips/include/asm/mipsregs.h   |   3 +
 arch/mips/kernel/Makefile          |   1 +
 arch/mips/kernel/cps-vec-ns16550.S | 202 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/cps-vec.S         |  44 ++++++--
 arch/mips/kernel/mips-cm.c         |  45 +++++++++
 arch/mips/kernel/mips-cpc.c        |   6 ++
 arch/mips/kernel/smp-cps.c         |  35 ++++++-
 arch/mips/kernel/smp-gic.c         |   2 +
 11 files changed, 386 insertions(+), 15 deletions(-)
 create mode 100644 arch/mips/kernel/cps-vec-ns16550.S

-- 
2.5.3
