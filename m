Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 02:18:41 +0100 (CET)
Received: from rere.qmqm.pl ([84.10.57.10]:53706 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993111AbdADBS2MKexY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 02:18:28 +0100
Received: by rere.qmqm.pl (Postfix, from userid 1000)
        id 2C36B6110; Wed,  4 Jan 2017 02:18:26 +0100 (CET)
Message-Id: <1ff3cba5536ca5a07f6496b9c80c646738956a8f.1483492355.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1483492355.git.mirq-linux@rere.qmqm.pl>
References: <cover.1483492355.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 1/6] net/skbuff: add macros for VLAN_PRESENT bit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Date:   Wed,  4 Jan 2017 02:18:26 +0100 (CET)
Return-Path: <mirq@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirq-linux@rere.qmqm.pl
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

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b53c0cfd417e..168c3e486bd4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -768,6 +768,12 @@ struct sk_buff {
 	__u32			priority;
 	int			skb_iif;
 	__u32			hash;
+#define PKT_VLAN_PRESENT_BIT	4	// CFI (12-th bit) in TCI
+#ifdef __BIG_ENDIAN
+#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, vlan_tci)
+#else
+#define PKT_VLAN_PRESENT_OFFSET()	(offsetof(struct sk_buff, vlan_tci) + 1)
+#endif
 	__be16			vlan_proto;
 	__u16			vlan_tci;
 #if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
-- 
2.11.0
