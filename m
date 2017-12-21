Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 16:21:31 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:56692 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990486AbdLUPU6cBxtN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Dec 2017 16:20:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E45C81A540B;
        Thu, 21 Dec 2017 16:20:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (unknown [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C56231A5408;
        Thu, 21 Dec 2017 16:20:50 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 0/2] MIPS: Augment CPC support
Date:   Thu, 21 Dec 2017 16:20:22 +0100
Message-Id: <1513869627-15391-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61538
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v1->v2:

    - corrected wording in commit messages and documentation text
    - expanded cover letter to better explain the context of proposed
        changes
    - rebased to the latest code

This series is based on two patches from the larger series submitted
some time ago (30 Aug 2016):

https://www.linux-mips.org/archives/linux-mips/2016-08/msg00456.html

Both patches deal with MIPS Cluster Power Controller (CPC) support.
More specifically, they add device tree related functionalities to
that support.

This functionality is needed for further development of kernel support
for generic-based MIPS platforms that must be DT-based and will at the
same time make more extensive use of CPC.

Paul Burton (2):
  dt-bindings: Document mti,mips-cpc binding
  MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt |  8 ++++++++
 arch/mips/kernel/mips-cpc.c                             | 13 +++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt

-- 
2.7.4
