Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 20:00:15 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:8783 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992922AbeKJS6gfO-UM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:36 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVS4gNfzXm;
        Sat, 10 Nov 2018 19:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876256; bh=5wUXCdx09t4M/Z8UBOiTUUA9+ZMn9okKBcmksQxEUzM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=p/+IzNWCvcHyOOGUN66nHALdKncHUvN6Eph+pI6wsO2COYeTflKYb0aOLtMJdQrHo
         iSwK31edB7rHzIQkWJXeB1UlWrayYctcvz1ZOSbj1ZEYbX9bDUlC2m0nYJFITmFnQa
         FXHNXknoYPyMjMXEgeVOuX/errMUqvaOa5nEY5SyraHfIlMAlLAdQP9llc7ICa/3bK
         c/30zCQ0GTrrVwbyIXBtUMnzcF8wYp/nQCuYRlQ7HhpZz0UPiF5LWnh6dNDNQETsdg
         ml9RcCskkszpnmdxC3JuI3JJYkIobefU04A1mzS2fMM0M1HGo7wSwhptOEmaSntJMe
         s41EZX315CiKw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:35 +0100
Message-Id: <886ae30bd7616e5ecf8b3176648126b1eb19fe67.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 4/6] net/bpf_jit: PPC: split VLAN_PRESENT bit
 handling from VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67224
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
 arch/powerpc/net/bpf_jit_comp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d5bfe24bb3b5..dc4a2f54e829 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -379,18 +379,20 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 							  hash));
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-			BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			} else {
-				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
-				PPC_SRWI(r_A, r_A, 12);
-			}
+#ifdef VLAN_TAG_PRESENT
+			PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
+			if (PKT_VLAN_PRESENT_BIT)
+				PPC_SRWI(r_A, r_A, PKT_VLAN_PRESENT_BIT);
+			if (PKT_VLAN_PRESENT_BIT < 7)
+				PPC_ANDI(r_A, r_A, 1);
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
2.19.1
