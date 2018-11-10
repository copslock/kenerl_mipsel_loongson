Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 19:58:56 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:37289 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992918AbeKJS6flqulM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:35 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVR4wW8zSP;
        Sat, 10 Nov 2018 19:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876255; bh=PRkyk5xKl4RPlekKn5KiNqkzSob0xFsU6yaGCiOxFq4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HInmTtoYfISs92x+BLLHl7pFOGh9Z2+4Povha2MQ3gQOwndLa2OYBCnFnn9iRXHnV
         bcbtvB/h2VAJC7rOexnEyOxoIK2rq73IgiWnIuHK6RQsjdhvhrVIO+eDFQUn7IwHeD
         tSVpJnMpfOYhjMWo6AbY0QsIKEtL8NqXNkYeSAXK/5LMfFe8bbmIyQ8OlYJYuDhvDv
         /iDKEHoqQ+Yy3C6xjbHoDsOZJ7O0dTTntAWCdssmhVnFK2ALswoVvqrA5qSPstn51/
         ZSsimZeqgyObGKHiqavlk6kWtC6SiTjXrrhLnyPsXNdtHYkvQdEDX4ArG5E4ToUUO/
         miDYgxZV5Sh9A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:35 +0100
Message-Id: <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling from
 VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
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
X-archive-position: 67219
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

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/core/filter.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e521c5ebc7d1..c151b906df53 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -296,22 +296,21 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		break;
 
 	case SKF_AD_VLAN_TAG:
-	case SKF_AD_VLAN_TAG_PRESENT:
 		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
 		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_tci));
-		if (skb_field == SKF_AD_VLAN_TAG) {
-			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
-						~VLAN_TAG_PRESENT);
-		} else {
-			/* dst_reg >>= 12 */
-			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
-			/* dst_reg &= 1 */
+#ifdef VLAN_TAG_PRESENT
+		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
+#endif
+		break;
+	case SKF_AD_VLAN_TAG_PRESENT:
+		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
+		if (PKT_VLAN_PRESENT_BIT)
+			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
+		if (PKT_VLAN_PRESENT_BIT < 7)
 			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
-		}
 		break;
 	}
 
@@ -6140,19 +6139,22 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		break;
 
 	case offsetof(struct __sk_buff, vlan_present):
+		*target_size = 1;
+		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
+				      PKT_VLAN_PRESENT_OFFSET());
+		if (PKT_VLAN_PRESENT_BIT)
+			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, PKT_VLAN_PRESENT_BIT);
+		if (PKT_VLAN_PRESENT_BIT < 7)
+			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
+		break;
+
 	case offsetof(struct __sk_buff, vlan_tci):
-		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
-
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff, vlan_tci, 2,
 						     target_size));
-		if (si->off == offsetof(struct __sk_buff, vlan_tci)) {
-			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg,
-						~VLAN_TAG_PRESENT);
-		} else {
-			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, 12);
-			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
-		}
+#ifdef VLAN_TAG_PRESENT
+		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
+#endif
 		break;
 
 	case offsetof(struct __sk_buff, cb[0]) ...
-- 
2.19.1
