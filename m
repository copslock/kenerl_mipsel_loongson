Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2017 21:53:11 +0100 (CET)
Received: from rere.qmqm.pl ([84.10.57.10]:50290 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbdACUwmhrmQq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jan 2017 21:52:42 +0100
Received: by rere.qmqm.pl (Postfix, from userid 1000)
        id ECA8E6121; Tue,  3 Jan 2017 21:52:38 +0100 (CET)
Message-Id: <949c15c172da3d2f40c42e8eae4d30aacaf09bf9.1483475202.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
References: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next v2 20/27] net/bpf_jit: MIPS: split VLAN_PRESENT bit handling
 from VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Tue,  3 Jan 2017 21:52:38 +0100 (CET)
Return-Path: <mirq@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56149
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

Acked-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/mips/net/bpf_jit.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e2226fee..4b12b5df47e8 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1138,19 +1138,23 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load(r_s0, r_skb, off, ctx);
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
-			} else {
-				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
-				/* return 1 if present */
-				emit_sltu(r_A, r_zero, r_A, ctx);
-			}
+#ifdef VLAN_TAG_PRESENT
+			emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			emit_andi(r_A, r_s0, 1, ctx);
+			/* return 1 if present */
+			emit_sltu(r_A, r_zero, r_A, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
-- 
2.11.0
