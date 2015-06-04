Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 12:58:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006903AbbFDK5Bu3xQN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 12:57:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0989446B8256C;
        Thu,  4 Jun 2015 11:56:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Jun 2015 11:56:56 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 4 Jun 2015 11:56:55 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] MIPS: net: BPF: Use BPF register names to describe the ABI
Date:   Thu, 4 Jun 2015 11:56:15 +0100
Message-ID: <1433415376-20952-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47854
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

Use the BPF register names instead of the arch register names to
document how the ABI is structured.

Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 954df295f945..f0db4f8310b2 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -30,10 +30,10 @@
 
 /* ABI
  *
- * s3	BPF register A
- * s4	BPF register X
- * s5	*skb
- * s6	*scratch memory
+ * r_A		BPF register A
+ * r_X		BPF register X
+ * r_skb	*skb
+ * r_M		*scratch memory
  *
  * On entry (*bpf_func)(*skb, *filter)
  * a0 = MIPS_R_A0 = skb;
-- 
2.4.2
