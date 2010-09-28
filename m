Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 12:41:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56746 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491197Ab0JNKln (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Oct 2010 12:41:43 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9EAfgs0029675
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 11:41:42 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9EAfgL5029673
        for linux-mips@linux-mips.org; Thu, 14 Oct 2010 11:41:42 +0100
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 14 Oct 2010 11:41:42 +0100
Resent-Message-ID: <20101014104142.GA28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from zeniv.linux.org.uk ([195.92.253.2]:43794 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491139Ab0I1RuT (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 28 Sep 2010 19:50:19 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
        id 1P0eJl-0006im-4g; Tue, 28 Sep 2010 17:50:17 +0000
Date:   Tue, 28 Sep 2010 18:50:17 +0100
To:     ralf@linux-mips.org
Subject: [PATCH 1/5] mips: don't block signals if we'd failed setting
 sigframe up
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1P0eJl-0006im-4g@ZenIV.linux.org.uk>
From:   Al Viro <viro@ftp.linux.org.uk>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 2099d5a..b3273ae 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -575,6 +575,9 @@ static int handle_signal(unsigned long sig, siginfo_t *info,
 		ret = abi->setup_frame(vdso + abi->signal_return_offset,
 				       ka, regs, sig, oldset);
 
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NODEFER))
-- 
1.5.6.5
