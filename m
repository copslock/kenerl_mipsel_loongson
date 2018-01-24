Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:48:05 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:33440
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeAXBrjgDcaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:47:39 +0100
Received: by mail-qt0-x244.google.com with SMTP id d8so6635498qtm.0;
        Tue, 23 Jan 2018 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nl+r3aOeGyXHjcvrSQiXmf1qST7t5wpPxkcfO6uuG4s=;
        b=kNC2QMteSlb2rKcozQN3Fsj9cBn7Jlz7xn/MezhoTEJNSVPqxQc2ZVxysN6MPDHxxj
         S2DF1dxSxEsQ5NldNxxMbY2HGqHEitpQqyG7aiLE87zV3EbpPUH+82ras1M1ZSqwawe4
         GaBUIy0Y/hvC41BtbrlTxbq+tipOzJYSevgJZBXjxyTOHLnMKb3TJP5lStVCfef0+htb
         GgEu/NFp+gdnkWIZKQ/oYBbVNOAyH59QpaPsCn9DjldCzrbjF5BF8SlxnB4wH80AmV88
         qrCKMT+kRPeFzAB/4EctzD0rW6JU59Tt2gFLQqNj4KLJVCRqYvVYdu4e4cLhxPv0RALP
         6cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nl+r3aOeGyXHjcvrSQiXmf1qST7t5wpPxkcfO6uuG4s=;
        b=SZAHkC3xKqSaHmBZ+06kN057VglVxuVnBiieuQnmeQex4HsrTR2/MjJcGTVHGgUAdH
         IuI5MrpFIMuCjPdo8KV181OhS9++nCv7g3K+rKXf0njFbRI35K1ALHc48jfdghmXL1WN
         qNU3zu+oQqa9/ggIp+ABS2Um/fVvl3aPj+viYgtI4Nwe3JHbWncVtj6tYwRJ5TO6Vbq4
         LnqdGhFAsjvBG+pyTvze0M3EjflXHpajAEhMSB5m3VFQ5IxnFQBWU/c+YaiibC1u42/k
         /5T0Ea6ueQEwNuHCuA73zHdmrPWwE+acx9R322H7mbEt1nJ//+zGV19kLkri5hS/u8Hx
         R0ow==
X-Gm-Message-State: AKwxyte6tEXB4O13shhr4wUEKUzPg+XQETsaibFLCUS/h7o94kM361rV
        AN9wg8NHggsKigOvLEeJM9+ow1an
X-Google-Smtp-Source: AH8x224Re+RiQWzV8bd9AWIowYNAEKhk+o/Lo81IvWRVQwdVprye7v5w7QIPCMFK9VJl3X9pvkfFqA==
X-Received: by 10.200.18.136 with SMTP id y8mr6751359qti.175.1516758452069;
        Tue, 23 Jan 2018 17:47:32 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x7sm1465605qtx.51.2018.01.23.17.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:47:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 1/6] MIPS: Allow board to override TLB initialization
Date:   Tue, 23 Jan 2018 17:47:01 -0800
Message-Id: <1516758426-8127-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

Some boards may have to override how the TLB initialization is done,
e.g: to support eXtended Kseg0/1 features on Broadcom BMIPS boards.
Allow this to happen by providing a board_tlb_init() hook.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/traps.h | 1 +
 arch/mips/kernel/traps.c      | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index f41cf3ee82a7..66c9c855be6e 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -26,6 +26,7 @@ extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
 extern void (*board_ebase_setup)(void);
 extern void (*board_cache_error_setup)(void);
+extern void (*board_tlb_init)(void);
 
 extern int register_nmi_notifier(struct notifier_block *nb);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5d19ed07e99d..b03864eb8213 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -106,6 +106,7 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 void (*board_ebase_setup)(void);
 void(*board_cache_error_setup)(void);
+void (*board_tlb_init)(void);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
@@ -2230,7 +2231,10 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	/* Boot CPU's cache setup in setup_arch(). */
 	if (!is_boot_cpu)
 		cpu_cache_init();
-	tlb_init();
+	if (board_tlb_init)
+		board_tlb_init();
+	else
+		tlb_init();
 	TLBMISS_HANDLER_SETUP();
 }
 
-- 
2.7.4
