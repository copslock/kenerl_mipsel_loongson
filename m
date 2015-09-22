Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:27:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62806 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVR1JBYMaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:27:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D55A92F1350E9;
        Tue, 22 Sep 2015 18:26:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:27:03 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:27:02 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/5] CM error report fixes
Date:   Tue, 22 Sep 2015 10:26:36 -0700
Message-ID: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49284
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

This series fixes a few problems with support for the CM, in particular
relating to CM3 which has a 64 bit interface to the core. These issues
prevented reporting of CM errors (useful debug output when tracking the
source of a bus error) in some situations, and could cause further
exceptions.

Paul Burton (5):
  MIPS: clarify mips_cm_is64 documentation
  MIPS: don't read GCRs when a CM is not present
  MIPS: avoid buffer overrun in mips_cm_error_report
  MIPS: allow read64 GCR accessors to work on MIPS32 kernels
  MIPS: always read full 64 bit CM error GCRs for CM3

 arch/mips/include/asm/mips-cm.h | 27 ++++++++++++----
 arch/mips/kernel/mips-cm.c      | 71 ++++++++++++++++++++++-------------------
 2 files changed, 59 insertions(+), 39 deletions(-)

-- 
2.5.3
