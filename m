Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 14:38:18 +0100 (CET)
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:12533 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeAWNiLGnNbj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2018 14:38:11 +0100
X-IronPort-AV: E=Sophos;i="5.46,401,1511827200"; 
   d="scan'208";a="328726135"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Jan 2018 13:38:08 +0000
Received: from uecb1d7364e75593fe229.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w0NDc6f3075705
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 23 Jan 2018 13:38:07 GMT
Received: from uecb1d7364e75593fe229.ant.amazon.com (localhost [127.0.0.1])
        by uecb1d7364e75593fe229.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w0NDc5Ho026856;
        Tue, 23 Jan 2018 13:38:05 GMT
Received: (from luisbg@localhost)
        by uecb1d7364e75593fe229.ant.amazon.com (8.15.2/8.15.2/Submit) id w0NDc5t4026853;
        Tue, 23 Jan 2018 13:38:05 GMT
From:   Luis de Bethencourt <luisbg@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mips@linux-mips.org,
        Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] MIPS: Fix trailing semicolon
Date:   Tue, 23 Jan 2018 13:38:03 +0000
Message-Id: <20180123133803.26789-1-luisbg@kernel.org>
X-Mailer: git-send-email 2.15.1
Return-Path: <prvs=5540a0381=luisbg@amazon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luisbg@kernel.org
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

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 arch/mips/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 77cad232a1c6..e8161e4dfde7 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -110,7 +110,7 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst,
  */
 static inline __sum16 csum_fold(__wsum csum)
 {
-	u32 sum = (__force u32)csum;;
+	u32 sum = (__force u32)csum;
 
 	sum += (sum << 16);
 	csum = (sum < csum);
-- 
2.15.1
