Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 13:45:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63718 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006632AbbHTLpdTrc7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 13:45:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A9E969CC643C
        for <linux-mips@linux-mips.org>; Thu, 20 Aug 2015 12:45:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 20 Aug 2015 12:45:27 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 20 Aug 2015 12:45:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] Minor signal clean up
Date:   Thu, 20 Aug 2015 12:45:20 +0100
Message-ID: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48964
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

The following two patches contain a minor clean up in the signal setup code.
The first one makes o32 behave the same on 64-bit kernels as with the 32-bit
ones. The second one drops the extra arguments from traditional signal
handlers.

Markos Chandras (2):
  MIPS: asm: signal.h: Fix traditional signal handling for o32 on 64-bit
    kernels
  MIPS: kernel: signal: Drop unused arguments for traditional signal
    handlers

 arch/mips/include/asm/signal.h | 8 +++-----
 arch/mips/kernel/signal.c      | 8 ++------
 arch/mips/kernel/signal32.c    | 6 +-----
 arch/mips/kernel/signal_n32.c  | 2 +-
 4 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.5.0
