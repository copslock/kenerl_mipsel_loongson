Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 13:21:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:10240 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6822090AbaEGLVUDD1rH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 13:21:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E87E8B1241509
        for <linux-mips@linux-mips.org>; Wed,  7 May 2014 12:21:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 12:21:13 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 7 May 2014 12:21:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/5] MIPS Malta halt & power off
Date:   Wed, 7 May 2014 12:20:55 +0100
Message-ID: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40039
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

This series improves the behaviour of the MIPS Malta board in response
to a halt or power off command. The previous behaviour was that both of
these would trigger a reset of the board. The new behaviour with this
series applied is that halt will execute an infinite loop and power off
will power off the board via the PIIX4.

Paul Burton (5):
  MIPS: define some more PIIX4 registers & values
  MIPS: Malta: add suspend state entry code
  MIPS: Malta: let PIIX4 respond to PCI special cycles
  MIPS: Malta: hang on halt
  MIPS: Malta: support powering down

 arch/mips/Kconfig                           |  6 ++
 arch/mips/include/asm/mach-malta/malta-pm.h | 37 +++++++++++
 arch/mips/include/asm/mips-boards/piix4.h   | 12 ++++
 arch/mips/mti-malta/Makefile                |  2 +
 arch/mips/mti-malta/malta-pm.c              | 96 +++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-reset.c           | 15 +++--
 arch/mips/pci/fixup-malta.c                 |  6 ++
 7 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-malta/malta-pm.h
 create mode 100644 arch/mips/mti-malta/malta-pm.c

-- 
1.8.5.3
