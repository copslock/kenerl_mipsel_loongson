Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 19:23:19 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65491 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835040Ab3EXRXN6ez-y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 19:23:13 +0200
Received: by mail-pa0-f44.google.com with SMTP id wp1so1939440pac.31
        for <multiple recipients>; Fri, 24 May 2013 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=q3h5nHlqTAX00HOCJFEcieRkR9wOmnorBbI6/7NHXe0=;
        b=qvbc4qLok+Y2Ke9xg/DqqqJ+b9PxNGrXf+ia4ooZi21bh6NbdICi7sG4k99SUdOLXD
         xsqD4AyZez+A50ArR3pd8s8yJuxCLOaPuK+iPUjQLvlAnfnAFnxdNM21AOH4zlYAozu4
         Y1GZuBGvDxtiUiwqxC5G9Ek0LwVPlyahB0hoJKUOl603AQB3xde7CQHWgadDAaY0+QuS
         Qwd5yu0q1pikPBPcDHgOtu9u+8FwGv+W830kSTF65EPDDFGEGz/RV31SxBiwlef9D6mk
         lx0WisdW0svKb35ra1CH/iZCYeH5fUCXtjiJ8A30YH4Oqc6R45xyaqq6X2cn5B8EW409
         RC/g==
X-Received: by 10.68.180.4 with SMTP id dk4mr18727408pbc.104.1369416187381;
        Fri, 24 May 2013 10:23:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w8sm16951531pbo.9.2013.05.24.10.23.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 10:23:06 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4OHN4HB007379;
        Fri, 24 May 2013 10:23:04 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4OHN3p5007378;
        Fri, 24 May 2013 10:23:03 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Maxim Uvarov <muvarov@gmail.com>,
        Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: [PATCH] MIPS: OCTEON: Improve _machine_halt implementation.
Date:   Fri, 24 May 2013 10:23:02 -0700
Message-Id: <1369416182-7345-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

As noted by Wladislav Wiebe:
   $ halt
   ..
   Sent SIGKILL to all processes
   Requesting system halt
   [66.729373] System halted.
   [66.733244]
   [66.734761] =====================================
   [66.739473] [ BUG: lock held at task exit time! ]
   [66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G           O
   [66.750202] -------------------------------------
   [66.754913] init/21479 is exiting with locks still held!
   [66.760234] 1 lock held by init/21479:
   [66.763990]  #0:  (reboot_mutex){+.+...}, at: [<ffffffff801776c8>] SyS_reboot+0xe0/0x218
   [66.772165]
   [66.772165] stack backtrace:
   [66.776532] Call Trace:
   [66.778992] [<ffffffff805780a8>] dump_stack+0x8/0x34
   [66.783972] [<ffffffff801618b0>] do_exit+0x610/0xa70
   [66.788948] [<ffffffff801777a8>] SyS_reboot+0x1c0/0x218
   [66.794186] [<ffffffff8013d6a4>] handle_sys64+0x44/0x64

This is an alternative fix to the one sent by Wladislav.  We kill the
watchdog for each CPU and then spin in WAIT with interrupts disabled.
This is the lowest power mode for the OCTEON.  If we were to spin with
interrupts enabled, we would get a continual stream of warning messages
and backtraces from the lockup detector, so I chose to disable
interrupts.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
Cc: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 arch/mips/cavium-octeon/setup.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0baa29..01b1b3f 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -428,13 +428,16 @@ static void octeon_restart(char *command)
  */
 static void octeon_kill_core(void *arg)
 {
-	mb();
-	if (octeon_is_simulation()) {
-		/* The simulator needs the watchdog to stop for dead cores */
-		cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+	if (octeon_is_simulation())
 		/* A break instruction causes the simulator stop a core */
-		asm volatile ("sync\nbreak");
-	}
+		asm volatile ("break" ::: "memory");
+
+	local_irq_disable();
+	/* Disable watchdog on this core. */
+	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+	/* Spin in a low power mode. */
+	while (true)
+		asm volatile ("wait" ::: "memory");
 }
 
 
-- 
1.7.11.7
