Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2014 15:49:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49837 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010478AbaJBNtMYBQ2I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2014 15:49:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 67070F7670456;
        Thu,  2 Oct 2014 14:49:02 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 2 Oct
 2014 14:49:05 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 2 Oct 2014 14:49:04 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 2 Oct 2014 14:49:04 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jayachandran C <jchandra@broadcom.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH] staging: xlr_net: Replace obsolete nlm_cop2_{enable,restore} macros
Date:   Thu, 2 Oct 2014 14:48:49 +0100
Message-ID: <1412257729-12351-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42930
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

Commit 64f6ebe63914 ("MIPS: Netlogic: rename nlm_cop2_save/restore")
replaced nlm_cop2_enable with nlm_cop2_enable_irqsave and
nlm_cop2_restore with nlm_cop2_disable_irqrestore but it did not
update the xlr_net driver to use the new macros resulting into build
problems like this:

drivers/staging/netlogic/xlr_net.c: In function 'send_to_rfr_fifo':
drivers/staging/netlogic/xlr_net.c:128:3: error: implicit declaration of
function 'nlm_cop2_enable' [-Werror=implicit-function-declaration]
mflags = nlm_cop2_enable();
^
drivers/staging/netlogic/xlr_net.c:130:3: error: implicit declaration of
function 'nlm_cop2_restore' [-Werror=implicit-function-declaration]
nlm_cop2_restore(mflags);

Therefore rename these cases as well

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/staging/netlogic/xlr_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 9bf407d6241a..469f75f0f818 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -125,9 +125,9 @@ static int send_to_rfr_fifo(struct xlr_net_priv *priv, void *addr)
 	msg.msg3 = 0;
 	stnid = priv->nd->rfr_station;
 	do {
-		mflags = nlm_cop2_enable();
+		mflags = nlm_cop2_enable_irqsave();
 		ret = nlm_fmn_send(1, 0, stnid, &msg);
-		nlm_cop2_restore(mflags);
+		nlm_cop2_disable_irqrestore(mflags);
 		if (ret == 0)
 			return 0;
 	} while (++num_try < 10000);
@@ -298,9 +298,9 @@ static netdev_tx_t xlr_net_start_xmit(struct sk_buff *skb,
 	u32 flags;
 
 	xlr_make_tx_desc(&msg, virt_to_phys(skb->data), skb);
-	flags = nlm_cop2_enable();
+	flags = nlm_cop2_enable_irqsave();
 	ret = nlm_fmn_send(2, 0, priv->nd->tx_stnid, &msg);
-	nlm_cop2_restore(flags);
+	nlm_cop2_disable_irqrestore(flags);
 	if (ret)
 		dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
-- 
2.1.1
