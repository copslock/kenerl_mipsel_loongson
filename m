Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 20:00:11 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:19514 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992893AbeKJS6fSez8M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:35 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVR1X62zSL;
        Sat, 10 Nov 2018 19:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876255; bh=a7hGtjXQI2BeU96szcY0Yxo9hPYWXaglX0Z6ymJXaAA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=XnSi/LsaE1fKRmpN20Pv1LALKWzhDfcMfaMUr2DCDHw081zTzTQNA3i13plPzWyE0
         9btx5l8HhmzwfFW0RaxkhkG8nUYErorPomvITuNby3WthC5mdOyRlXPJHawwIR4C1H
         r1vmLmm63kwqHJMH+POdhFuMBdbJTjby8ROzMAZjniB0ONgL4M0Y0Ygqab0Q6hI9o+
         JRbTBlRLkaE36v3jm69QIxXMLTYxaFFFs18tJnGGwcDmNHw8ikSa7fwPf+H4VeZM4P
         o07IBDZik5Jt3bGL02Uoyg0yGd0fPKklbCmYROhKB0gankMJNokmwS8Wg5/oCBvEVE
         ncEiI99cInpDA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:34 +0100
Message-Id: <0f16fe1faf8961523d0e94e2c1c87d427c4fcad0.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 1/6] net/skbuff: add macros for VLAN_PRESENT bit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67223
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

Wrap VLAN_PRESENT bit using macro like PKT_TYPE_* and CLONED_*,
as used by BPF code.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7dcfb5591dc3..99f38779332c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -816,6 +816,12 @@ struct sk_buff {
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
2.19.1
