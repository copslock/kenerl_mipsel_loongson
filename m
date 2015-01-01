Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 20:13:39 +0100 (CET)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39718 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009693AbbAATNieBEEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 20:13:38 +0100
Received: by mail-wg0-f44.google.com with SMTP id b13so23342406wgh.3
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 11:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=puEtE4KqJzRiX9VH+rOz1M1iFr4xLiaipNcOY4bWCvg=;
        b=E98LtxmoMN2vspaqKdYxC+JfGTkn63agQ/iEXtYBCInrkKSGYz78LCF9U5jdQGY6po
         8MZweD/uxuXexI356jhOicu7FQOVjapDlLRD9Y589aFWMBUCfSRbQqfj092HBQf1i69n
         N6jcxyhWN2nbCofjvAsYKXkbNvSbXXxgFTU95bGBs1RFgMwszXwf/o5zzzmVXrZsv7JR
         2kR3JO6V+WIGpyZ5JCgrbhcKKychI2w1hkhRU6tQqdC885ZRXQqbE7vk4tkLnYLTPXas
         kBgvDP2wQ7P0zAJY1hPwEsXqyAaQsh7qwFpUYUwRLwA3+y6fuB8lAbXh8f4k3qEwGOZY
         9oFA==
X-Gm-Message-State: ALoCoQmJTvla4rUxOEYlZgY5YlLdSYE61TpGjzis4VQ0FCXGNSMWvRUXJgCoanUt4t8c1qXUHxjY
X-Received: by 10.180.12.75 with SMTP id w11mr128770680wib.9.1420139613291;
        Thu, 01 Jan 2015 11:13:33 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id gf6sm62111111wjc.11.2015.01.01.11.13.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 11:13:32 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: net: bpf_jit:  Remove unused function
Date:   Thu,  1 Jan 2015 20:16:34 +0100
Message-Id: <1420139794-3417-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Remove the function emit_daddiu() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/net/bpf_jit.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 9b55143..5b942f8 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -231,16 +231,6 @@ static inline void emit_ori(unsigned int dst, unsigned src, u32 imm,
 	}
 }
 
-static inline void emit_daddiu(unsigned int dst, unsigned int src,
-			       int imm, struct jit_ctx *ctx)
-{
-	/*
-	 * Only used for stack, so the imm is relatively small
-	 * and it fits in 15-bits
-	 */
-	emit_instr(ctx, daddiu, dst, src, imm);
-}
-
 static inline void emit_addiu(unsigned int dst, unsigned int src,
 			      u32 imm, struct jit_ctx *ctx)
 {
-- 
1.7.10.4
