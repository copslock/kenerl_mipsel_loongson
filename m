Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 19:59:00 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:54064 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992919AbeKJS6gIlkiM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:36 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVS17PPzVB;
        Sat, 10 Nov 2018 19:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876256; bh=vXmwrout5fwoWBE/cN9rloBCcPajBCOfuE9bA47AY/g=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=MeacdbLMQRzwULt6zRdXfvoSHzsIZ3KqGHHF1NWJTV7eb+yz1IrwnA03b8zNFBIPd
         PPzKGsxxsAgAIIa7C9Dbq+BnzV1UCvLlXMZNygLv3ojeVqNdMCDqLL71/f8Js9iPTF
         GUOX6LKbVGiT63FqLBrVvw2zukJbpxcQvExYU0MytKUQqKj6svkCSamGpW/kUxTTbu
         lVm1Apxf11Jtl1zfc+GnGBHv7AkKx1RBGo5BMsGBimE6ZTHZU1BUNkzvwhLxzEmbiG
         sRZU67XgWwyCsB49tsZUy23nZwDyH3f8PNPX7tt3zQxzTEwB7742tR8wFlt+l7NgaJ
         tMsYVdHtuJWBg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:35 +0100
Message-Id: <cbaaeac4a963f55f86f09eb26be502584c877527.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 3/6] net/bpf_jit: MIPS: split VLAN_PRESENT bit
 handling from VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67220
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
 arch/mips/net/bpf_jit.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 4d8cb9bb8365..de4c6372ad9a 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1159,19 +1159,22 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
-			emit_half_load_unsigned(r_s0, r_skb, off, ctx);
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
-			} else {
-				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
-				/* return 1 if present */
-				emit_sltu(r_A, r_zero, r_A, ctx);
-			}
+			emit_half_load_unsigned(r_A, r_skb, off, ctx);
+#ifdef VLAN_TAG_PRESENT
+			emit_andi(r_A, r_A, (u16)~VLAN_TAG_PRESENT, ctx);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			if (PKT_VLAN_PRESENT_BIT < 7)
+				emit_andi(r_A, r_A, 1, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
-- 
2.19.1
