Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 00:04:04 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:49321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993913AbdHVWD4A9QR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 00:03:56 +0200
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1dkHH4-0000dU-0W; Tue, 22 Aug 2017 22:03:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-mips@linux-mips.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] MIPS,bpf: fix missing break in switch statement
Date:   Tue, 22 Aug 2017 23:03:49 +0100
Message-Id: <20170822220349.5648-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-Path: <colin.king@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin.king@canonical.com
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

From: Colin Ian King <colin.king@canonical.com>

There is a missing break causing a fall-through and setting
ctx.use_bbit_insns to the wrong value. Fix this by adding the
missing break.

Detected with cppcheck:
"Variable 'ctx.use_bbit_insns' is reassigned a value before the old
one has been used. 'break;' missing?"

Fixes: 8d8d18c3283f ("MIPS,bpf: Fix using smp_processor_id() in preemptible splat.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/mips/net/ebpf_jit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 44ddc12cbb0e..7646891c4e9b 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1892,6 +1892,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	case CPU_CAVIUM_OCTEON2:
 	case CPU_CAVIUM_OCTEON3:
 		ctx.use_bbit_insns = 1;
+		break;
 	default:
 		ctx.use_bbit_insns = 0;
 	}
-- 
2.14.1
