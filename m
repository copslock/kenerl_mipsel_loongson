Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:23:36 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37300 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097172Ab0FILXD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:23:03 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 80ECF5F274;
        Wed,  9 Jun 2010 13:23:02 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:23:02 +0200
Date:   Wed, 9 Jun 2010 13:23:02 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David VomLehn <dvomlehn@cisco.com>,
        Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 8/9] Removing dead CONFIG_DIAGNOSTICS
Message-ID: <9193680d40b6545b05e09d4906980397cb29a2fe.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6346

CONFIG_DIAGNOSTICS doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/powertv/powertv_setup.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index af2cae0..3933c37 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -199,14 +199,8 @@ static int panic_handler(struct notifier_block *notifier_block,
 		my_regs.cp0_status = read_c0_status();
 	}
 
-#ifdef CONFIG_DIAGNOSTICS
-	failure_report((char *) cause_string,
-		have_die_regs ? &die_regs : &my_regs);
-	have_die_regs = false;
-#else
 	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
 		"zzzz... \n");
-#endif
 
 	return NOTIFY_DONE;
 }
-- 
1.6.3.3
