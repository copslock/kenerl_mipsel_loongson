Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:25:53 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:61699 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491973Ab0ELNY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:26 +0200
Received: by pxi1 with SMTP id 1so2779409pxi.36
        for <multiple recipients>; Wed, 12 May 2010 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=slwv/bbbjYCgVQoh39DAkg7F3zvkX2DSoVwGj1DVlS8=;
        b=BUekalYqk2U9HuKY39LlqA41HZhfGpp72/6CWE3ZPEoAoL7o84nNZRwMGN1rmfoM7z
         f1oRTw73tdfMYTnaBTPrEDJCYnx+J0Hi5TOflcNNiNDisM/K64Rd2S78UauDk+VOf9w3
         ABDpezFcGHLXt48eAq4H3L5FX2H5mC+arlQw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yv3xs3VXn9HWqrBZV8yZv4EPFhjc1Q555CNgP+CM+PtxC0J6ap8x8rFZv6YPxOy6zJ
         Cu2IckXknBoe/87/wSG5nnA/SIv1Gh7QkPPvltA92CCCKtJkBE9zfq5G7TSkNzV6xN2s
         mBUfE61s6MRqXEmWFT3iXEJwzPzSgxeuuRI/Q=
Received: by 10.115.81.33 with SMTP id i33mr5861827wal.46.1273670659229;
        Wed, 12 May 2010 06:24:19 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:18 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 5/9] tracing: MIPS: Fixup of the 32bit support with -mmcount-ra-address
Date:   Wed, 12 May 2010 21:23:13 +0800
Message-Id: <466344de77ee0aebc8832717391b02398ac6bd96.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

For 32bit kernel, the -mmcount-ra-address option of gcc 4.5 has
introduced one more instruction before calling to _mcount, so we need to
use a different "b 1f" for it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index e9e64e0..37aa767 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -62,14 +62,26 @@ int ftrace_make_nop(struct module *mod,
 				return -EFAULT;
 		}
 
+#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
+		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
+		 * addiu v1, v1, low_16bit_of_mcount
+		 * move at, ra
+		 * move $12, ra_address
+		 * jalr v1
+		 *  sub sp, sp, 8
+		 *                                  1: offset = 5 instructions
+		 */
+		new = 0x10000005;
+#else
 		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
 		 * addiu v1, v1, low_16bit_of_mcount
 		 * move at, ra
 		 * jalr v1
-		 * nop
-		 * 				     1f: (ip + 12)
+		 *  nop | move $12, ra_address | sub sp, sp, 8
+		 *                                  1: offset = 4 instructions
 		 */
 		new = 0x10000004;
+#endif
 	} else {
 		/* record/calculate it for ftrace_make_call */
 		if (jal_mcount == 0) {
-- 
1.7.0.4
