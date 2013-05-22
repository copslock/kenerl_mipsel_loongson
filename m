Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 11:37:13 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:60548 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817408Ab3EVJhIPQ9xZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 11:37:08 +0200
Received: from mlsv3.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id A07E937AC2;
        Wed, 22 May 2013 18:37:03 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv3.hitachi.co.jp (8.13.1/8.13.1) id r4M9b3In013046; Wed, 22 May 2013 18:37:03 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id r4M9b2fr003161;
        Wed, 22 May 2013 18:37:03 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 26954490055;
        Wed, 22 May 2013 18:37:02 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id r4M9b203001477; Wed, 22 May 2013 18:37:02 +0900
X-AuditID: 85900ec0-d4ccab900000151e-db-519c91bdf9e5
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.sdl.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id AA018236561;
        Wed, 22 May 2013 18:37:01 +0900 (JST)
Received: from [127.0.1.1] (unknown [10.232.29.58])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id E398D53C15F;
        Wed, 22 May 2013 18:38:01 +0900 (JST)
Subject: [PATCH 2/2] [BUGFIX] kprobes/mips: Fix to check double free of insn
 slot
To:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
From:   Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc:     linux-mips@linux-mips.org, Victor Kamensky <kamensky@cisco.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maneesh Soni <manesoni@cisco.com>,
        yrl.pp-manager.tt@hitachi.com, systemtap@sourceware.org
Date:   Wed, 22 May 2013 18:34:13 +0900
Message-ID: <20130522093413.9084.33395.stgit@mhiramat-M0-7522>
In-Reply-To: <20130522093409.9084.63554.stgit@mhiramat-M0-7522>
References: <20130522093409.9084.63554.stgit@mhiramat-M0-7522>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <masami.hiramatsu.pt@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: masami.hiramatsu.pt@hitachi.com
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

Fix to check double free of insn_slot at arch_remove_kprobe
as other arches do.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: Maneesh Soni <manesoni@cisco.com>
Cc: Victor Kamensky <kamensky@cisco.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/kprobes.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 12bc4eb..1f8187a 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -207,7 +207,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	free_insn_slot(p->ainsn.insn, 0);
+	if (p->ainsn.insn) {
+		free_insn_slot(p->ainsn.insn, 0);
+		p->ainsn.insn = NULL;
+	}
 }
 
 static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
