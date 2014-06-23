Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:41:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23915 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860006AbaFWJjfZ9lXO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E71904A5490C7;
        Mon, 23 Jun 2014 10:39:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:28 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/17] MIPS: bpf: Use 'andi' instead of 'and' for the VLAN cases
Date:   Mon, 23 Jun 2014 10:38:49 +0100
Message-ID: <1403516340-22997-7-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 40661
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

The VLAN_VID_MASK and VLAN_TAG_PRESENT are immediates, so using
'and' which expects 3 registers will produce wrong results. Fix
this by using the 'andi' instruction.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 95728ea6cb74..fe5041bdc6fb 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1317,9 +1317,9 @@ jmp_cmp:
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load(r_s0, r_skb, off, ctx);
 			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
-				emit_and(r_A, r_s0, VLAN_VID_MASK, ctx);
+				emit_andi(r_A, r_s0, VLAN_VID_MASK, ctx);
 			else
-				emit_and(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
+				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			off = pkt_type_offset();
-- 
2.0.0
