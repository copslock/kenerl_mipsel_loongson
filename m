Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:48:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30999 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859944AbaGILsilnxZh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 13:48:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 46F54B3D72789
        for <linux-mips@linux-mips.org>; Wed,  9 Jul 2014 12:48:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 12:48:31 +0100
Received: from pburton-laptop.home (192.168.79.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/5] {pm,smp}-cps fixes
Date:   Wed, 9 Jul 2014 12:48:17 +0100
Message-ID: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.89]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41091
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

This series fixes a few minor build issues with the pm-cps & smp-cps
code, and one caching issue which could lead to boot failures.

Paul Burton (5):
  MIPS: pm-cps: prevent use of mips_cps_* without CPS SMP
  MIPS: pm-cps: select CONFIG_MIPS_CPC
  MIPS: fix potential build failures using cpu_vpe_id on non-MT
  MIPS: {pm,smp}-cps: use cpu_vpe_id macro
  MIPS: smp-cps: fix entry code cache flush for systems with coherent
    I/O

 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/cpu-info.h |  2 +-
 arch/mips/include/asm/smp-cps.h  | 12 ++++++++++--
 arch/mips/kernel/pm-cps.c        | 10 +++++++++-
 arch/mips/kernel/smp-cps.c       | 12 ++++++++----
 5 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.0.1
