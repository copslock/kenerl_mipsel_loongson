Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2016 00:53:51 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:59857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993064AbcLVXxnQ2Rkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2016 00:53:43 +0100
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1cKDB8-0007mC-Mu; Thu, 22 Dec 2016 23:53:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: fix incorrect assignment on ralink_soc
Date:   Thu, 22 Dec 2016 23:52:58 +0000
Message-Id: <20161222235258.5525-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-Path: <colin.king@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin.king@canonical.com
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

From: Colin Ian King <colin.king@canonical.com>

ralink_soc sould be assigned to RT3883_SOC, replace incorrect
comparision with assignment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/mips/ralink/rt3883.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 141c597..f869052 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -157,5 +157,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	rt2880_pinmux_data = rt3883_pinmux_data;
 
-	ralink_soc == RT3883_SOC;
+	ralink_soc = RT3883_SOC;
 }
-- 
2.10.2
