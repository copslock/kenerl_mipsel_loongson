Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 13:10:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64847 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842383AbaGXLKPK8q8N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 13:10:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 59A0FAE900E49
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2014 12:10:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:07 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.158) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:06 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/2] MIPS64/O32 seccomp fixes
Date:   Thu, 24 Jul 2014 12:10:00 +0100
Message-ID: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41561
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

A few seccomp fixes related to O32 processes on MIPS64 cores.

It's based on v3.16-rc6

Markos Chandras (2):
  MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
  MIPS: scall64-o32: Fix indirect syscall detection

 arch/mips/include/asm/syscall.h |  8 +++++---
 arch/mips/kernel/scall64-o32.S  | 12 ++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.0.2
