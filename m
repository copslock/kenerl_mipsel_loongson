Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 15:55:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18836 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861526AbaGUNgLMOn0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 15:36:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3BBB7883035D4
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 14:36:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:03 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.145) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:02 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] EVA/CPS fixes
Date:   Mon, 21 Jul 2014 14:35:53 +0100
Message-ID: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.145]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41357
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

This patchset contains a few small fixes required for MT cores to
boot with CPS and EVA.

It's based on v3.16-rc6

Markos Chandras (3):
  MIPS: EVA: Add new EVA header
  MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
  MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores

 arch/mips/include/asm/eva.h                        | 43 ++++++++++++++++++++++
 .../include/asm/mach-malta/kernel-entry-init.h     | 22 ++++++++---
 arch/mips/kernel/cps-vec.S                         |  4 ++
 3 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/include/asm/eva.h

-- 
2.0.0
