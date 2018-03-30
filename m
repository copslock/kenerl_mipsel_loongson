Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 11:17:52 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:46744
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990432AbeC3JRqGG29Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 11:17:46 +0200
Received: by mail-pg0-x242.google.com with SMTP id t12so4777921pgp.13
        for <linux-mips@linux-mips.org>; Fri, 30 Mar 2018 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ddE3H16P+ezOl1IjUpaSjRLaSnFSmkyOgSBKTLKhlCg=;
        b=bjphC+VcJObfs6lj6tGz7y77e78+3eIQ1gwX0/Efu+gDyQOGAB3Yj5pRCCPUq9fij7
         RKMZn0euKS6hiNwUg7MpeYESE69tINzFFwnMjbrWvwIGJAU7pPI7cGXHr09PCPW4RCIv
         iZn/a4ZKGHcXD5wXLbBBJEhTx1abSAxiMfC/noMbKXRoHjub0FNvww+8mCAnFqc5+9Rv
         XsFrCGwLdeq5kOt5I0Sfw00BOrErsraspycJrGRlHH4MR6tz3HNsIRedyK5Y8eIBUASE
         Q7ZzvsuT3KlUd7Nlkb8548UN984MHXr5c8+o3f84RJG8MT9obIDh3dtxx1IzZO6WIScf
         0EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ddE3H16P+ezOl1IjUpaSjRLaSnFSmkyOgSBKTLKhlCg=;
        b=MED7t/l/Rnc2RCL9VwgxDn2IK0p5CrjS6Gh9c65tEw/Hc5iSxzbuKWzUYRO5+ht9Nn
         74DrFO21L0XnxQjSikNghEp/0LhLw4ENJ1ZRlZam1BLGTdqeh1yuJsjwIAoLKXgp+oaD
         Bu+NZFsUGbBVXyr+UBTFajkP/oTejMFmNqk74U5fFPYEsoRimR6CmS+w7TmgSPgaeP8D
         dSvGUneNar+C9nrNODG0x41L+0xYykS2c0dh14uh4U2WGsg6h2pEMGb33GWem49ol+Wr
         4SKe8krjNTjmwqrvjZdFWkI3YwaplEsZ0NJbtfZXrkJA9jAGFZy2hk7DRh4t2ywQBeNk
         7AJg==
X-Gm-Message-State: AElRT7ELpLsuUg+1hALlKcq6U2YBl98tCGZOlSs2xDXdB9uAr23fnNXu
        0juLW/LNlGVPvZU0NbcWi9fDO1Y0Gnw=
X-Google-Smtp-Source: AIpwx489Oi+gy8p7AmBEZlqCkFhFwqyR3spZRE1LwJTD+aj1WbdpXKkWOrUXSGjb+GyE0S7HvkTfDw==
X-Received: by 10.99.180.6 with SMTP id s6mr7789791pgf.81.1522401459548;
        Fri, 30 Mar 2018 02:17:39 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id s89sm18226288pfk.54.2018.03.30.02.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 02:17:38 -0700 (PDT)
From:   r@hev.cc
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Heiher <r@hev.cc>
Subject: [PATCH] MIPS: Avoid to cause watchpoint exception in kernel mode
Date:   Fri, 30 Mar 2018 17:17:21 +0800
Message-Id: <20180330091721.11712-1-r@hev.cc>
X-Mailer: git-send-email 2.16.3
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
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

From: Heiher <r@hev.cc>

The following program cause an endless loop in kernel space:

	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>

	int
	main (int argc, char *argv[])
	{
		char buf[16];

		printf ("%p\n", buf);
		raise (SIGINT);

		write (1, buf, 16);

		return 0;
	}

	# gcc -O0 -o t t.c
	# gdb ./t
	(gdb) r
	(gdb) watch *<printed buf address>
	(gdb) c

Signed-off-by: Heiher <r@hev.cc>
---
 arch/mips/kernel/entry.S | 23 +++++++++++++++++++++++
 arch/mips/kernel/traps.c |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 38a302919e6b..6094844fc63f 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -49,6 +49,13 @@ resume_userspace:
 					# interrupt setting need_resched
 					# between sampling and return
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
 	j	restore_all
@@ -82,7 +89,15 @@ FEXPORT(syscall_exit)
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
 					# sampling and return
+
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	li	t0, _TIF_ALLWORK_MASK
 	and	t0, a2, t0
 	bnez	t0, syscall_exit_work
@@ -143,7 +158,15 @@ work_notifysig:				# deal with pending signals and
 FEXPORT(syscall_exit_partial)
 	local_irq_disable		# make sure need_resched doesn't
 					# change between and return
+
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	li	t0, _TIF_ALLWORK_MASK
 	and	t0, a2
 	beqz	t0, restore_partial
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 967e9e4e795e..22f671263b27 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1525,7 +1525,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	 * their values and send SIGTRAP.  Otherwise another thread
 	 * left the registers set, clear them and continue.
 	 */
-	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
+	if (user_mode(regs) && test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
 		force_sig_info(SIGTRAP, &info, current);
-- 
2.16.3
