Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:45:23 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47102 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491923Ab1F0PpT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:45:19 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc4PY019415;
        Mon, 27 Jun 2011 16:38:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc4ke019414;
        Mon, 27 Jun 2011 16:38:04 +0100
Message-Id: <2ecba7369d1ac0d7b1ab08ccce65f240719f99c8.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Brent Casavant <bcasavan@sgi.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Mon, 27 Jun 2011 14:35:01 +0100
Subject: [PATCH 11/12] MISC: IOC4: Fix section mismatch / race condition.
X-archive-position: 30531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21988

WARNING: drivers/misc/ioc4.o(.data+0x144): Section mismatch in reference from the variable ioc4_load_modules_work to the function .devinit.text:ioc4_load_modules()
The variable ioc4_load_modules_work references
the function __devinit ioc4_load_modules()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

This one is potencially fatal; by the time ioc4_load_modules is invoked
it may already have been freed.  For that reason ioc4_load_modules_work
can't be turned to __devinitdata but also because it's referenced in
ioc4_exit.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/misc/ioc4.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/ioc4.c b/drivers/misc/ioc4.c
index 668d41e..df03dd3 100644
--- a/drivers/misc/ioc4.c
+++ b/drivers/misc/ioc4.c
@@ -270,7 +270,7 @@ ioc4_variant(struct ioc4_driver_data *idd)
 	return IOC4_VARIANT_PCI_RT;
 }
 
-static void __devinit
+static void
 ioc4_load_modules(struct work_struct *work)
 {
 	request_module("sgiioc4");
-- 
1.7.4.4
