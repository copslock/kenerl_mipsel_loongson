Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 20:50:26 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34356 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007640AbbJSSuYi-Ezu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 20:50:24 +0200
Received: by padhk11 with SMTP id hk11so37254200pad.1
        for <linux-mips@linux-mips.org>; Mon, 19 Oct 2015 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=d2FBZ/que4Jhkl2yKwVtTaEzeDi3aB3OzxvCmtSvGf0=;
        b=QG9jq/ccMBw5XMdG8QgPRuSkCWTzaxwnfOldw6tldEMleVn4duYxnNhMqiiPvD5YTa
         z1eN1vb2Ma2kBJoD6kXiJVyF8TxQyMw+x2bGPfRzlK51UpKuOwRpohuywNbPpb1gk0UK
         hIlrjYw+Dd8W9IYeeTwVfomm5+NcZAel/crwTLdZdLnkKAlcFjiYwb/3Pyh1OiT1Qg51
         wojaguc245KVcn3/Yw2A8xzXUHl1v4/SA5/3BNvFkDUYLwh9DtNI+BWdzjTJIXEXb1Mw
         RVkVTIlDuRRhXRC2hSOdKrldDcwrS5hY7erLNoC3pAEMRgR2fBSHKrMLeRupRRtU7jAn
         4t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d2FBZ/que4Jhkl2yKwVtTaEzeDi3aB3OzxvCmtSvGf0=;
        b=QM3a1rzETApkSUwfZm4t+69MScEo/rIR4rDgst7R+o9XcMMGh8pjk2drmnFo9IMfmv
         81OejVSWLZ7pDSbBeYzt1lSp/uzAGhovvwa8LKZarW0d4sW+mnx0dCbuyk6cSBkiQtN4
         PWsEgEdIqHIaSeFJYv+ATli6svbCTyAtjJwZjX1H5TZC1UudrthLs61VU2i0ariGHmul
         t0WMsGAA+PIHm5zBHp3EVCdub5sa6QoeBsTanC2ZXKLJ5+cXYCYTRZP8u7WeiBtX4gVx
         fvkYkG9B4/Efz+JPYk0/0Rm/+JxioRi3UNtGeYt+44zl5MaoFKRUMQ7BZApSfX90/QsM
         gj2A==
X-Gm-Message-State: ALoCoQlUVKaJ1tqShC7iDSBAeFJwcG9tfkaRjf7Ee8+Dsz5x+FAOsqQdWrhla6Brocj0IXpV9b6G
X-Received: by 10.66.251.136 with SMTP id zk8mr36816449pac.143.1445280618890;
        Mon, 19 Oct 2015 11:50:18 -0700 (PDT)
Received: from slapshot.mtv.corp.google.com ([172.27.88.51])
        by smtp.gmail.com with ESMTPSA id yz3sm37603470pbb.37.2015.10.19.11.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 11:50:18 -0700 (PDT)
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Petri Gynther <pgynther@google.com>
Subject: [PATCH] MIPS: add nmi_enter() + nmi_exit() to nmi_exception_handler()
Date:   Mon, 19 Oct 2015 11:49:52 -0700
Message-Id: <1445280592-43038-1-git-send-email-pgynther@google.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

We need to enter NMI context when NMI interrupt fires.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 arch/mips/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fdb392b..efcedd4 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1856,12 +1856,14 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
 {
 	char str[100];
 
+	nmi_enter();
 	raw_notifier_call_chain(&nmi_chain, 0, regs);
 	bust_spinlocks(1);
 	snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
 		 smp_processor_id(), regs->cp0_epc);
 	regs->cp0_epc = read_c0_errorepc();
 	die(str, regs);
+	nmi_exit();
 }
 
 #define VECTORSPACING 0x100	/* for EI/VI mode */
-- 
2.6.0.rc2.230.g3dd15c0
