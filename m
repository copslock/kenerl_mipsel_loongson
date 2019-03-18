Return-Path: <SRS0=/aPD=RV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D30C43381
	for <linux-mips@archiver.kernel.org>; Mon, 18 Mar 2019 02:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F22214D8
	for <linux-mips@archiver.kernel.org>; Mon, 18 Mar 2019 02:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfCRCg3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:36:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:39312 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfCRCgH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 17 Mar 2019 22:36:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 19:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,491,1544515200"; 
   d="scan'208";a="155877427"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2019 19:36:05 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [RESEND 6/7] IB/qib: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
Date:   Sun, 17 Mar 2019 11:34:37 -0700
Message-Id: <20190317183438.2057-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317183438.2057-1-ira.weiny@intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Use the new FOLL_LONGTERM to get_user_pages_fast() to protect against
FS DAX pages being mapped.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 31c523b2a9f5..b53cc0240e02 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -673,7 +673,7 @@ static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
 		else
 			j = npages;
 
-		ret = get_user_pages_fast(addr, j, 0, pages);
+		ret = get_user_pages_fast(addr, j, FOLL_LONGTERM, pages);
 		if (ret != j) {
 			i = 0;
 			j = ret;
-- 
2.20.1

