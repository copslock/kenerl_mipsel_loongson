Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:44:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9777 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860019AbaFWJjmejEp5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2E80A215DDD73;
        Mon, 23 Jun 2014 10:39:39 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 23 Jun
 2014 10:39:40 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:40 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:40 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 15/17] MIPS: bpf: Fix PKT_TYPE case for big-endian cores
Date:   Mon, 23 Jun 2014 10:38:58 +0100
Message-ID: <1403516340-22997-16-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40669
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

The skb->pkt_type field is defined as follows:

u8 pkt_type:3,
   fclone:2,
   ipvs_property:1,
   peeked:1,
   nf_trace:1

resulting to the following layout in big-endian systems

[pkt_type][fclone][ipvs_propery][peeked][nf_trace]
^                                                ^
|                                                |
LSB                                             MSB

As a result, the existing code did not work because it was trying to
match pkt_type == 7 whereas in reality it is 7<<5 on big-endian
systems.

This has been fixed in the interpreter in
0dcceabb0c1bf2d4c12a748df9933fad303072a7
"net: filter: fix SKF_AD_PKTTYPE extension on big-endian"

The fix is to look for 7<<5 on big-endian systems for the pkt_type
field, and shift by 5 so the packet type will be at the lower 3 bits
of the A register.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 09ebc886c7aa..4920e0fd05ee 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -745,13 +745,17 @@ static u64 jit_get_skb_w(struct sk_buff *skb, unsigned offset)
 	return (u64)err << 32 | ntohl(ret);
 }
 
-#define PKT_TYPE_MAX 7
+#ifdef __BIG_ENDIAN_BITFIELD
+#define PKT_TYPE_MAX	(7 << 5)
+#else
+#define PKT_TYPE_MAX	7
+#endif
 static int pkt_type_offset(void)
 {
 	struct sk_buff skb_probe = {
 		.pkt_type = ~0,
 	};
-	char *ct = (char *)&skb_probe;
+	u8 *ct = (u8 *)&skb_probe;
 	unsigned int off;
 
 	for (off = 0; off < sizeof(struct sk_buff); off++) {
@@ -1314,6 +1318,10 @@ jmp_cmp:
 			emit_load_byte(r_tmp, r_skb, off, ctx);
 			/* Keep only the last 3 bits */
 			emit_andi(r_A, r_tmp, PKT_TYPE_MAX, ctx);
+#ifdef __BIG_ENDIAN_BITFIELD
+			/* Get the actual packet type to the lower 3 bits */
+			emit_srl(r_A, r_A, 5, ctx);
+#endif
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-- 
2.0.0
