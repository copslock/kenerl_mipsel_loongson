Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 16:23:05 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35598 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856089AbaGQOXARVsSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 16:23:00 +0200
Received: by mail-lb0-f173.google.com with SMTP id n15so1770636lbi.4
        for <multiple recipients>; Thu, 17 Jul 2014 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Q3IbF7s/Hl6cbSdwsJizwjTNLAdKRYFhn4KjTu7y/o=;
        b=Gs5DCN0XiRJ+s58V5ltda9y9fxlc0qx7myFZLCC5dL73peNyn5FWq6QZfUi7WOCsVz
         h6VdL0Gjo/540M4vZHtXyL9XM2nGGBDxM3Sh/g/8EjApzVUYL1+c3vGqB0CJ6XmZEOzj
         qLQfCI1j/KV90BZpCZsypuxzvqKJzZgYTVp6GbR3tY6B/hEOevSpDt2PmD3ugpZh+nVq
         EXVFJz63++EPeuEgZZp/Z62K1IGhii9fZOQS64JX9qBvlSueSWryozZNI8V6g/WUSGek
         zyoY2TVhQpaI5jmCj5O9yZ1m8whuzftHIyAqZuBH/5RpWYd8hrA7OkGFmyZ0Mx+cowLl
         xQqw==
X-Received: by 10.152.180.36 with SMTP id dl4mr7087643lac.26.1405606973890;
        Thu, 17 Jul 2014 07:22:53 -0700 (PDT)
Received: from localhost.localdomain (alfa-g11.tenet.odessa.ua. [195.138.73.151])
        by mx.google.com with ESMTPSA id c7sm1738101laf.2.2014.07.17.07.22.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 07:22:51 -0700 (PDT)
From:   Andrey Utkin <andrey.krieger.utkin@gmail.com>
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     dborkman@redhat.com, markos.chandras@imgtec.com,
        ralf@linux-mips.org, Andrey Utkin <andrey.krieger.utkin@gmail.com>
Subject: [PATCH] arch/mips/net/bpf_jit.c: fix failure check
Date:   Thu, 17 Jul 2014 17:22:38 +0300
Message-Id: <1405606958-14383-1-git-send-email-andrey.krieger.utkin@gmail.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
References: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
Return-Path: <andrey.krieger.utkin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrey.krieger.utkin@gmail.com
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

static int pkt_type_offset(void) returned -1 in case of failure, and actual
(positive) offset value in case of success. In the only instance of its usage,
the result was saved to local "unsigned int off" variable, which is used in a
lot of places in the same (large) function, so changing its type could cause
many warnings. So new signed int variable was added.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80371
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 arch/mips/net/bpf_jit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index b87390a..918b341 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -793,6 +793,7 @@ static int build_body(struct jit_ctx *ctx)
 	const struct sock_filter *inst;
 	unsigned int i, off, load_order, condt;
 	u32 k, b_off __maybe_unused;
+	int tmp;
 
 	for (i = 0; i < prog->len; i++) {
 		u16 code;
@@ -1332,9 +1333,9 @@ jmp_cmp:
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
 
-			off = pkt_type_offset();
+			tmp = off = pkt_type_offset();
 
-			if (off < 0)
+			if (tmp < 0)
 				return -1;
 			emit_load_byte(r_tmp, r_skb, off, ctx);
 			/* Keep only the last 3 bits */
-- 
1.8.5.5
