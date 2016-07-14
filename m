Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 13:58:20 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:35961 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995267AbcGNL6OKyVXm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 13:58:14 +0200
Received: from [85.1.99.166] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1bNfHL-0000NU-HQ; Thu, 14 Jul 2016 13:58:07 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ralf@linux-mips.org
Cc:     dan.carpenter@oracle.com, markos.chandras@imgtec.com,
        ast@kernel.org, daniel@iogearbox.net, linux-mips@linux-mips.org
Subject: [PATCH] bpf, mips: fix off-by-one in ctx offset allocation
Date:   Thu, 14 Jul 2016 13:57:55 +0200
Message-Id: <4ea94c98412d93aaea7f2a28832b41c26dc17ba7.1468497047.git.daniel@iogearbox.net>
X-Mailer: git-send-email 1.9.3
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/21901/Thu Jul 14 12:45:53 2016)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@iogearbox.net
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

Dan Carpenter reported [1] a static checker warning that ctx->offsets[]
may be accessed off by one from build_body(), since it's allocated with
fp->len * sizeof(*ctx.offsets) as length. The cBPF arm and ppc code
doesn't have this issue as claimed, so only mips seems to be affected and
should like most other JITs allocate with fp->len + 1. A few number of
JITs (x86, sparc, arm64) handle this differently, where they only require
fp->len array elements.

  [1] http://www.spinics.net/lists/mips/msg64193.html

Fixes: c6610de353da ("MIPS: net: Add BPF JIT")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/net/bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 1a8c960..a04c393 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1199,7 +1199,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 
 	memset(&ctx, 0, sizeof(ctx));
 
-	ctx.offsets = kcalloc(fp->len, sizeof(*ctx.offsets), GFP_KERNEL);
+	ctx.offsets = kcalloc(fp->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
 	if (ctx.offsets == NULL)
 		return;
 
-- 
1.9.3
