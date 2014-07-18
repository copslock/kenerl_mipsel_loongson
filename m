Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 11:51:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16320 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861344AbaGRJvpt-Wmr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 11:51:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7D31C9C2AC2CA
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 10:51:36 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 10:51:38 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:38 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.100) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/4] Add pgprot_writecombine function for MIPS
Date:   Fri, 18 Jul 2014 10:51:29 +0100
Message-ID: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.100]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41306
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

This patchset implements the pgprot_writecombine function for MIPS

Markos Chandras (4):
  MIPS: pgtable-bits: Move the CCA bits out of the core's ifdef blocks
  MIPS: pgtable-bits: Define the CCA bit for WC writes on Ingenic cores
  MIPS: cpu-probe: Set the write-combine CCA value on per core basis
  MIPS: pgtable.h: Implement the pgprot_writecombine function for MIPS

 arch/mips/include/asm/cpu-info.h     |  5 ++++
 arch/mips/include/asm/pgtable-bits.h | 44 ++++++++++++++++++++++++------------
 arch/mips/include/asm/pgtable.h      | 10 ++++++++
 arch/mips/kernel/cpu-probe.c         | 21 +++++++++++++++++
 4 files changed, 65 insertions(+), 15 deletions(-)

-- 
2.0.0
