Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 04:15:46 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:42687 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006152AbbLIDPot9Y-u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 04:15:44 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id tB93FU1n026898
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 8 Dec 2015 19:15:30 -0800 (PST)
Received: from pek-lpgbuild1.wrs.com (128.224.153.21) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Tue, 8 Dec 2015 19:15:30 -0800
From:   <yanjiang.jin@windriver.com>
To:     <rric@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <oprofile-list@lists.sf.net>,
        <yanjiang.jin@windriver.com>, <linux-kernel@vger.kernel.org>,
        <jinyanjiang@gmail.com>
Subject: [PATCH] MIPS: oprofile: Fix a preemption issue
Date:   Wed, 9 Dec 2015 11:15:26 +0800
Message-ID: <1449630927-14355-1-git-send-email-yanjiang.jin@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Yanjiang.Jin@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanjiang.jin@windriver.com
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

From: Yanjiang Jin <yanjiang.jin@windriver.com>

Reproduction steps:
1. Build a MIPS BSP with CONFIG_OPROFILE=m, I am using Cavium's CN78XX board to test;
2. Boot the board;
3. modprobe oprofile in shell.


Yanjiang Jin (1):
  MIPS: oprofile: Fix a preemption issue

 arch/mips/oprofile/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1
