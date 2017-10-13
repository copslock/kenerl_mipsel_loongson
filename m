Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2017 11:22:37 +0200 (CEST)
Received: from szxga04-in.huawei.com ([45.249.212.190]:2482 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990480AbdJMJWaPueyW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Oct 2017 11:22:30 +0200
Received: from 172.30.72.58 (EHLO DGGEMS401-HUB.china.huawei.com) ([172.30.72.58])
        by dggrg04-dlp.huawei.com (MOS 4.4.6-GA FastPath queued)
        with ESMTP id DIZ27241;
        Fri, 13 Oct 2017 17:22:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.301.0; Fri, 13 Oct 2017 17:20:47 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] MIPS: bpf: Fix a typo in build_one_insn()
Date:   Fri, 13 Oct 2017 09:25:17 +0000
Message-ID: <1507886717-150040-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020205.59E085C9.00FC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2014-11-16 11:51:01,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 90ae59a7b18dfa8d3f97be803312217f
Return-Path: <weiyongjun1@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyongjun1@huawei.com
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

Fix a typo in build_one_insn().

Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/mips/net/ebpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 01b7a87..962b025 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1513,7 +1513,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		}
 		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
 		if (src < 0)
-			return dst;
+			return src;
 		if (BPF_MODE(insn->code) == BPF_XADD) {
 			switch (BPF_SIZE(insn->code)) {
 			case BPF_W:
