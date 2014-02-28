Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2014 21:01:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:33322 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6829833AbaB1UAtwU0qE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Feb 2014 21:00:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A667AFAC760EE;
        Fri, 28 Feb 2014 18:23:25 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 28 Feb
 2014 18:23:28 +0000
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 28 Feb 2014 18:23:27 +0000
Received: from fun-lab.mips.com (192.168.136.61) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 28 Feb
 2014 10:23:25 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <john@phrozen.org>, <ralf@linux-mips.org>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 0/3] MIPS: APRP: Fix issues from the last patch set reformation
Date:   Fri, 28 Feb 2014 10:23:00 -0800
Message-ID: <1393611783-7037-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

Three issues were introduced since the last patch set reformation.
1) The rtlx interrupt hook gets linked incorrectly;
2) The rtlx interrupt hook is not unregistered at module exit;
3) The vpe loader gets linked incorrectly.

Sorry for having not tested the functionality since the big reformation.
With these 3 patches, now I have confirmed that both MT and CMP flavors
are working correctly.

Deng-Cheng Zhu (3):
  MIPS: APRP: Fix the linking of rtlx interrupt hook
  MIPS: APRP: Unregister rtlx interrupt hook at module exit
  MIPS: APRP: Choose the correct VPE loader by fixing the linking

 arch/mips/kernel/rtlx-cmp.c      | 3 +++
 arch/mips/kernel/rtlx-mt.c       | 3 +++
 arch/mips/mti-malta/malta-amon.c | 2 +-
 arch/mips/mti-malta/malta-int.c  | 4 ++--
 4 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.8.5.3
