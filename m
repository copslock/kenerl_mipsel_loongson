Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2015 10:13:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6886 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008860AbbGAINo0c0D4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2015 10:13:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BAA50EE502229
        for <linux-mips@linux-mips.org>; Wed,  1 Jul 2015 09:13:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Jul 2015 09:13:38 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 1 Jul 2015 09:13:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/7] Initial SMP/CPS 64-bit support
Date:   Wed, 1 Jul 2015 09:13:27 +0100
Message-ID: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patchset fixes build problems on 64-bit kernels when SMP/CPS is
enabled. This is preparatory work for MIPS R6 SMP/CPS support but it allows the
CPS code to be build tested on 64-bit configurations.

Markos Chandras (7):
  MIPS: kernel: smp-cps: Fix 64-bit compatibility errors due to pointer
    casting
  MIPS: kernel: cps-vec: Replace 'la' macro with PTR_LA
  MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
  MIPS: kernel: cps-vec: Use ta0-ta3 pseudo-registers for 64-bit
  MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
  MIPS: kernel: cps-vec: Use macros for various arithmetics and memory
    operations
  Revert "MIPS: Kconfig: Disable SMP/CPS for 64-bit"

 arch/mips/Kconfig          |  2 +-
 arch/mips/kernel/cps-vec.S | 96 +++++++++++++++++++++++-----------------------
 arch/mips/kernel/smp-cps.c |  6 +--
 3 files changed, 52 insertions(+), 52 deletions(-)

-- 
2.4.5
