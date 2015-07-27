Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 21:58:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47262 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011094AbbG0T6yTjAXX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 21:58:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5F8E7910139F9;
        Mon, 27 Jul 2015 20:58:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 20:58:47 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 20:58:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        Alex Smith <alex@alex-smith.me.uk>,
        Huacai Chen <chenhc@lemote.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH v2 00/16] MSA vector context signal handling & HWCAPs
Date:   Mon, 27 Jul 2015 12:58:11 -0700
Message-ID: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48457
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

This series provides the final bits of support for MSA as far as
userland that isn't a debugger goes. In order to preserve backwards
compatibility it saves the extended vector context after the end of the
sigframe or ucontext, at a fixed offset. A bit set in sigcontext's
sc_used_math field indicates to userland (and to the kernel on
sigreturn) that the extended context is present.

With these final bits in, the presence of MSA support is indicated via a
HWCAP bit that userland may check for.

Paul Burton (16):
  MIPS: remove outdated comments in sigcontext.h
  MIPS: simplify EVA FP context handling code
  MIPS: add offsets to sigcontext FP fields to struct mips_abi
  MIPS: use struct mips_abi offsets to save FP context
  MIPS: move FP usage checks into protected_{save,restore}_fp_context
  MIPS: skip odd double FP registers when copying FP32 sigcontext
  MIPS: use common FP sigcontext code for O32 compat
  MIPS: remove unused {get,put}_sigset functions
  MIPS: indicate FP mode in sigcontext sc_used_math
  MIPS: add definitions for extended context
  MIPS: save MSA extended context around signals
  MIPS: AT_HWCAP aux vector infrastructure
  MIPS: advertise MIPSr6 via HWCAP when appropriate
  MIPS: advertise MSA support via HWCAP when present
  MIPS: require O32 FP64 support for MIPS64 with O32 compat
  MIPS: drop EXPERIMENTAL tag from O32+FP64 & MSA

 arch/mips/Kconfig                       |   5 +-
 arch/mips/include/asm/Kbuild            |   1 -
 arch/mips/include/asm/abi.h             |   4 +
 arch/mips/include/asm/elf.h             |   4 +-
 arch/mips/include/asm/signal.h          |   3 +
 arch/mips/include/uapi/asm/hwcap.h      |   8 +
 arch/mips/include/uapi/asm/sigcontext.h |  19 +-
 arch/mips/include/uapi/asm/ucontext.h   |  65 +++++
 arch/mips/kernel/asm-offsets.c          |  11 -
 arch/mips/kernel/cpu-probe.c            |   7 +
 arch/mips/kernel/r4k_fpu.S              | 372 ++++++++++++++-------------
 arch/mips/kernel/signal-common.h        |   9 +
 arch/mips/kernel/signal.c               | 429 +++++++++++++++++++++++++-------
 arch/mips/kernel/signal32.c             | 207 +--------------
 arch/mips/kernel/signal_n32.c           |   6 +-
 15 files changed, 660 insertions(+), 490 deletions(-)
 create mode 100644 arch/mips/include/uapi/asm/hwcap.h
 create mode 100644 arch/mips/include/uapi/asm/ucontext.h

-- 
2.4.6
