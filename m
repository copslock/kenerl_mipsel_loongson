Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 14:49:12 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57346 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491174Ab1ELMtG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 14:49:06 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4CCoavX026310;
        Thu, 12 May 2011 13:50:36 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4CCoZNW026307;
        Thu, 12 May 2011 13:50:35 +0100
Date:   Thu, 12 May 2011 13:50:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yury Polyanskiy <ypolyans@princeton.edu>
Cc:     linux-mips@linux-mips.org,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH] Notifier chain called twice
Message-ID: <20110512125035.GC11400@linux-mips.org>
References: <BANLkTikTDQgwHtK1V4AqRAALw_HrSTuvnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikTDQgwHtK1V4AqRAALw_HrSTuvnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 12, 2011 at 02:44:58AM -0400, Yury Polyanskiy wrote:

Shouldn't the conditional call be moved to an earlier location as below
patch does?  Then again once we're in die() this probably doesn't matter
terribly much anymore.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/traps.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 71350f7..e9b3af2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -374,7 +374,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	unsigned long dvpret = dvpe();
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV);
+	if (notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV) == NOTIFY_STOP)
+		sig = 0;
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
@@ -383,9 +384,6 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	mips_mt_regdump(dvpret);
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	if (notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV) == NOTIFY_STOP)
-		sig = 0;
-
 	printk("%s[#%d]:\n", str, ++die_counter);
 	show_registers(regs);
 	add_taint(TAINT_DIE);
