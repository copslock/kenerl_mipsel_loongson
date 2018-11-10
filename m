Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 19:58:42 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:16550 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992925AbeKJS6hCCM-M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:37 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVT0X23zf5;
        Sat, 10 Nov 2018 19:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876257; bh=mVtkuJmMB9DTnY2jQezAsUappvlEflWkjDeKGbqdMS0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=kJQ9CTvNJ+dWaoNyqPYIRl/tEoXSLQBozhsnBsbvPPeflS3kdu9uqWCeugMd7RJDT
         OL/a/vuEn72Rnzc8Houzf0DoEF7W2L6h+x7b78vgbw/YZwmHzgIEjNStJ+KM8xCf3T
         cSupWem/M9pjEfKPVhTTjro1bVHpBBfG8UkG68Ugt/GwJGpPDsQ8lC2fshwPNvLQLr
         14czQLFyCMZMDL5pR0MRHrncso1hnvM2EMKPtg8BZJI0woDy/0MzLQqVysI72ZKWCH
         m+CU0j0zPeuSORlarUFWfK1ti4RAHGNgcvayDhivl0Lk+U+Jz8kUZLCWxshgpHvKGx
         6DvX34EkKsTTg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:36 +0100
Message-Id: <4508dbca71009d191036155ec1a187455605577e.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 5/6] net/bpf_jit: SPARC: split VLAN_PRESENT bit
 handling from VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67218
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
 arch/sparc/net/bpf_jit_comp_32.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a5ff88643d5c..48f3c04dd179 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -552,15 +552,18 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_skb_load32(hash, r_A);
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
-			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				emit_skb_load16(vlan_tci, r_A);
-				if (code != (BPF_ANC | SKF_AD_VLAN_TAG)) {
-					emit_alu_K(SRL, 12);
+#ifdef VLAN_TAG_PRESENT
+				emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
+				emit_and(r_A, r_TMP, r_A);
+#endif
+				break;
+			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
+				if (PKT_VLAN_PRESENT_BIT)
+					emit_alu_K(SRL, PKT_VLAN_PRESENT_BIT);
+				if (PKT_VLAN_PRESENT_BIT < 7)
 					emit_andi(r_A, 1, r_A);
-				} else {
-					emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-					emit_and(r_A, r_TMP, r_A);
-				}
 				break;
 			case BPF_LD | BPF_W | BPF_LEN:
 				emit_skb_load32(len, r_A);
-- 
2.19.1
