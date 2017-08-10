Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 20:29:46 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:36128
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993901AbdHJS1z3vRRN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 20:27:55 +0200
Received: by mail-oi0-x241.google.com with SMTP id b130so1365103oii.3;
        Thu, 10 Aug 2017 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/2/KpGL+rw33Djh5nGOuZD0fXi2i/PObc+Um7hTSUY=;
        b=boJbEJPMqPm/ARWZQPI9IEKcVqv2tbKfuaRQ3Px5QhPrkBqJ29WghuoHzbgnRtfojt
         MsMejWG5baShaNB2TdjYRyEEP+7IWu5gQanqZiec9Xa9gJ9hXcFVKDNlPptqcEyrpIaE
         mxrDpRFlAmnPou7NjsXDBtxoMp8ApfABMngfy3M8YhwnCsqx8XK84B4OtT9q9t0u4A5X
         XsLoLFqOruSnsQhhAH7eOUZghZuTOD3rjd5YAmMsAje5lRlZ2qPW0T38cHoQjc5JECLu
         FiDlAQa3pDFSfmQW2+2P18+fX0k6XbjSloTjLFuhdp7VVv7pMTKIFT1f4CJTlh1xJpqy
         Kbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=F/2/KpGL+rw33Djh5nGOuZD0fXi2i/PObc+Um7hTSUY=;
        b=hTOk+b4EJnGJ7WLw76CY3PCieJiGhsuCyfxx3MBZVwBQHXJs/L/hWcCJxA7hIWoEUh
         S3+zVhsg5AKRkWOnyy2DntX/4iJ5kaRQKzwYqbjhMWvRu3f3XZHPz4U2PAdC85Mbc7XE
         vu3g/hp76GV3qjys2vdD5tRe5rJgtMRRF9hXAyi23fZF6JC8eMYfg112dDEMTu8/00y+
         JXvCMpOgNLiMxBCyLaXiB4XD8a12WCzQryuJRm8HGmjmpUoQHg0Czhzuy2CB6ydFWxBk
         RUI9YF7XD8jZekfMF+3epDxMi+8QICZZWO5jeuGYy8xGxNUPPbWhbkKfQ3wGN015l24f
         PX/Q==
X-Gm-Message-State: AHYfb5hr2paQupNLqFAd731lY84wLKE9shbvPceTdP6q2IpiFIiToe77
        0V3Df5cfcDcG6bXYgESNww==
X-Received: by 10.202.175.74 with SMTP id y71mr16122124oie.132.1502389669359;
        Thu, 10 Aug 2017 11:27:49 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id k128sm8199990oih.50.2017.08.10.11.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:27:47 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 9BC66900;
        Thu, 10 Aug 2017 13:27:43 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 2A073300DFD; Thu, 10 Aug 2017 13:27:41 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 1/4] mips: Fix issues in backtraces
Date:   Thu, 10 Aug 2017 13:27:37 -0500
Message-Id: <1502389660-8969-2-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502389660-8969-1-git-send-email-minyard@acm.org>
References: <1502389660-8969-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

I saw two problems when doing backtraces:

The compiler was putting a "fast return" at the top of some
functions, before it set up the frame.  The backtrace code
would stop when it saw a jump instruction, so it would never
get to the stack frame setup and would thus misinterpret it.
To fix this, don't look for jump instructions until the
frame setup has been seen.

The assembly code here is:

ffffffff80b885a0 <serial8250_handle_irq>:
ffffffff80b885a0:       c8a00003        bbit0   a1,0x0,ffffffff80b885b0 <serial8250_handle_irq+0x10>
ffffffff80b885a4:       0000102d        move    v0,zero
ffffffff80b885a8:       03e00008        jr      ra
ffffffff80b885ac:       00000000        nop
ffffffff80b885b0:       67bdffd0        daddiu  sp,sp,-48
ffffffff80b885b4:       ffb00008        sd      s0,8(sp)

The second problem was the compiler was putting the last
instruction of the frame save in the delay slot of the
jump instruction.  If it saved the RA in there, the
backtrace could would miss it and misinterpret the frame.
To fix this, make sure to process the instruction after
the first jump seen.

The assembly code for this is:

ffffffff80806fd0 <plat_irq_dispatch>:
ffffffff80806fd0:       67bdffd0        daddiu  sp,sp,-48
ffffffff80806fd4:       ffb30020        sd      s3,32(sp)
ffffffff80806fd8:       24130018        li      s3,24
ffffffff80806fdc:       ffb20018        sd      s2,24(sp)
ffffffff80806fe0:       3c12811c        lui     s2,0x811c
ffffffff80806fe4:       ffb10010        sd      s1,16(sp)
ffffffff80806fe8:       3c11811c        lui     s1,0x811c
ffffffff80806fec:       ffb00008        sd      s0,8(sp)
ffffffff80806ff0:       3c10811c        lui     s0,0x811c
ffffffff80806ff4:       08201c03        j       ffffffff8080700c <plat_irq_dispa
tch+0x3c>
ffffffff80806ff8:       ffbf0028        sd      ra,40(sp)

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/kernel/process.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5351e1f..a1d930a 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -349,6 +349,7 @@ static int get_frame_info(struct mips_frame_info *info)
 	union mips_instruction insn, *ip, *ip_end;
 	const unsigned int max_insns = 128;
 	unsigned int i;
+	bool saw_jump = false;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
@@ -370,9 +371,6 @@ static int get_frame_info(struct mips_frame_info *info)
 			insn.word = ip->word;
 		}
 
-		if (is_jump_ins(&insn))
-			break;
-
 		if (!info->frame_size) {
 			if (is_sp_move_ins(&insn))
 			{
@@ -396,10 +394,28 @@ static int get_frame_info(struct mips_frame_info *info)
 				info->frame_size = - ip->i_format.simmediate;
 			}
 			continue;
+		} else if (!saw_jump && is_jump_ins(ip)) {
+			/*
+			 * If we see a jump instruction, we are finished
+			 * with the frame save.
+			 *
+			 * Some functions can have a shortcut return at
+			 * the beginning of the function, so don't start
+			 * looking for jump instruction until we see the
+			 * frame setup.
+			 *
+			 * The RA save instruction can get put into the
+			 * delay slot of the jump instruction, so look
+			 * at the next instruction, too.
+			 */
+			saw_jump = true;
+			continue;
 		}
 		if (info->pc_offset == -1 &&
 		    is_ra_save_ins(&insn, &info->pc_offset))
 			break;
+		if (saw_jump)
+			break;
 	}
 	if (info->frame_size && info->pc_offset >= 0) /* nested */
 		return 0;
-- 
2.7.4
