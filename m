Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:54:36 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58850 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993868AbdFSPuJEUjQH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id A914B1A4719;
        Mon, 19 Jun 2017 17:50:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 858691A4670;
        Mon, 19 Jun 2017 17:50:03 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 0/4] MIPS: Fix several VDSO-related issues
Date:   Mon, 19 Jun 2017 17:49:54 +0200
Message-Id: <1497887398-13772-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

The patches in this series all deal with VDSO, and all originate from
the develpoment of Android emulator for Mips..

The first patch is a fix for incorrect time values returned under
certain conditions.

The second and third patches provide fallback mechanism for
clock_gettime() and gettimeofday() system calls within kernel VDSO
code. This actually brings Mips code to be in sync with other major
platforms (intel, arm, and others) (with respect to the division of
responsibility between glibc and kernel regarding VDSO functions
fallbacks). It seems to us that proposed organization is simpler
and easier for maintenance in the long run. However, since it affects
interaction between glibc and kernel, it needs to be communicated to
and reviewed by Mips glibc developers.

The fourth patch is just a correction of a comment.

Checkpatch script reports a false positive related to commit message
for the first patch. It is going to be reported to the checkpatch
maintainer.

Aleksandar Markovic (1):
  MIPS: VDSO: Fix a mismatch between comment and preprocessor constant

Goran Ferenc (3):
  MIPS: VDSO: Fix conversions in do_monotonic()/do_monotonic_coarse()
  MIPS: VDSO: Add implementation of clock_gettime() fallback
  MIPS: VDSO: Add implementation of gettimeofday() fallback

 arch/mips/include/asm/vdso.h  |  4 +--
 arch/mips/vdso/gettimeofday.c | 59 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.7.4
