Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:08:35 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38378 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbcKNCEklW8jO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:40 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d2-0005fH-ED; Mon, 14 Nov 2016 02:04:12 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d1-0000Oj-MD; Mon, 14 Nov 2016 02:04:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.941175975@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/346] bpf, mips: fix off-by-one in ctx offset
 allocation
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit b4e76f7e6d3200462c6354a6ad4ae167459e61f8 upstream.

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
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: ast@kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13814/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/net/bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1365,7 +1365,7 @@ void bpf_jit_compile(struct sk_filter *f
 
 	memset(&ctx, 0, sizeof(ctx));
 
-	ctx.offsets = kcalloc(fp->len, sizeof(*ctx.offsets), GFP_KERNEL);
+	ctx.offsets = kcalloc(fp->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
 	if (ctx.offsets == NULL)
 		return;
 
