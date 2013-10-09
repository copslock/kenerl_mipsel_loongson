Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 14:08:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43643 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6839455Ab3JIMIN72Zo4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 14:08:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r99C8CuG019982;
        Wed, 9 Oct 2013 14:08:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r99C89IV019981;
        Wed, 9 Oct 2013 14:08:09 +0200
Date:   Wed, 9 Oct 2013 14:08:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Anton Arapov <anton@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] UPROBES: Remove useless __weak attribute
Message-ID: <20131009120809.GN1615@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

<linux/uprobes.h> declares arch_uprobe_skip_sstep() as a weak function.
But as there is no definition of generic version so when trying to build
uprobes for an architecture that doesn't yet have a arch_uprobe_skip_sstep()
implementation, the vmlinux will try to call arch_uprobe_skip_sstep()
somehwere in Stupidhistan leading to a system crash.  We rather want a
proper link error so remove arch_uprobe_skip_sstep().

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/linux/uprobes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2a9d75d..cec7397 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -124,7 +124,7 @@ extern int uprobe_post_sstep_notifier(struct pt_regs *regs);
 extern int uprobe_pre_sstep_notifier(struct pt_regs *regs);
 extern void uprobe_notify_resume(struct pt_regs *regs);
 extern bool uprobe_deny_signal(void);
-extern bool __weak arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);
+extern bool arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void uprobe_clear_state(struct mm_struct *mm);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
