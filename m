Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 17:09:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58382 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992160AbcJMPJhvtPA4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2016 17:09:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u9DF9bha028031;
        Thu, 13 Oct 2016 17:09:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u9DF9a6Z028030;
        Thu, 13 Oct 2016 17:09:36 +0200
Date:   Thu, 13 Oct 2016 17:09:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: MIPS supports HAVE_REGS_AND_STACK_ACCESS_API
Message-ID: <20161013150936.GA27810@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55422
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

This should have been part of 40e084a506eb ('MIPS: Add uprobes support.').

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Fixes: 40e084a506eb ("MIPS: Add uprobes support.")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Jonathan, you can funnel this through the MIPS tree if you're ok with that?
Just lemme know -- Ralf

 Documentation/features/perf/kprobes-event/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 9855ad0..4660bf2 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -22,7 +22,7 @@
     |        m68k: | TODO |
     |       metag: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
     |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
