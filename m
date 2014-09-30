Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 18:39:23 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57152 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaI3QjViubap (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 18:39:21 +0200
Received: by mail-pa0-f46.google.com with SMTP id kq14so6913358pab.33
        for <multiple recipients>; Tue, 30 Sep 2014 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bj/SBt72c88Pu26l2q3/pWJ3PoOmGZYJrjQBJm1lxqE=;
        b=GAjLsVivOord0/YUH3h/ZsvCL5Rb1T3XU1ZSWiUIr/PwYv9Ir6PuZwpLat2kt161pV
         NYyvrZ2A/mPiwAB0H6KP6fe68GD09HLRUi6QG8L4od7f6B5/Hc4sPchQlZUAdmSVmQgm
         bME3+/WKFDznqBEbA8P+Hdz+UkUgqwHFpz6ShgHujBC+6ODcxWxqFbU4EljcobmAc1ld
         6G6tu+eBA9LTBFbjoVvP+k/tF+Ejoe1vQtrm5fS8XeEr+IiLCKJ3guJTsDTLpN8jba1T
         QR2/nCvt9P/vPTNxuYPdY5lCr/fwBxcNIqVid0Oj646FAV9knEp44+6jtQ3R+6YaG5zR
         B/lA==
X-Received: by 10.70.96.200 with SMTP id du8mr31830608pdb.117.1412095155014;
        Tue, 30 Sep 2014 09:39:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id yr3sm15739007pac.1.2014.09.30.09.39.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 09:39:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] next: mips: bpf: Fix build failure
Date:   Tue, 30 Sep 2014 09:39:00 -0700
Message-Id: <1412095140-10953-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Fix:

arch/mips/net/bpf_jit.c: In function 'build_body':
arch/mips/net/bpf_jit.c:762:6: error: unused variable 'tmp'
cc1: all warnings being treated as errors
make[2]: *** [arch/mips/net/bpf_jit.o] Error 1

Seen when building mips:allmodconfig in -next since next-20140924.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/net/bpf_jit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 7561833..9b55143 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -759,7 +759,6 @@ static int build_body(struct jit_ctx *ctx)
 	const struct sock_filter *inst;
 	unsigned int i, off, load_order, condt;
 	u32 k, b_off __maybe_unused;
-	int tmp;
 
 	for (i = 0; i < prog->len; i++) {
 		u16 code;
-- 
1.9.1
