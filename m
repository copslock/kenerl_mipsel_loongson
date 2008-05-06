Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2008 11:23:40 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:57574 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20024637AbYEFKXh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 May 2008 11:23:37 +0100
Received: from lagash (88-106-226-17.dynamic.dsl.as9105.com [88.106.226.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 902CA48916;
	Tue,  6 May 2008 12:23:34 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JtKKb-0002Wi-QO; Tue, 06 May 2008 11:23:33 +0100
Date:	Tue, 6 May 2008 11:23:33 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Fix build failure in mips oprofile code
Message-ID: <20080506102333.GF22413@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This patch fixes a warning-as-error induced build failure of
64bit mips kernels.


Signed-off-by: Thiemo Seufer <ths@networkno.de>

Index: linux.git/arch/mips/oprofile/op_model_mipsxx.c
===================================================================
--- linux.git.orig/arch/mips/oprofile/op_model_mipsxx.c	2008-05-06 11:06:07.000000000 +0100
+++ linux.git/arch/mips/oprofile/op_model_mipsxx.c	2008-05-06 11:15:32.000000000 +0100
@@ -281,7 +281,7 @@
 
 static void reset_counters(void *arg)
 {
-	int counters = (int)arg;
+	int counters = (int)(long)arg;
 	switch (counters) {
 	case 4:
 		w_c0_perfctrl3(0);
@@ -313,7 +313,7 @@
 	if (!cpu_has_mipsmt_pertccounters)
 		counters = counters_total_to_per_cpu(counters);
 #endif
-	on_each_cpu(reset_counters, (void *)counters, 0, 1);
+	on_each_cpu(reset_counters, (void *)(long)counters, 0, 1);
 
 	op_model_mipsxx_ops.num_counters = counters;
 	switch (current_cpu_type()) {
@@ -382,7 +382,7 @@
 	int counters = op_model_mipsxx_ops.num_counters;
 
 	counters = counters_per_cpu_to_total(counters);
-	on_each_cpu(reset_counters, (void *)counters, 0, 1);
+	on_each_cpu(reset_counters, (void *)(long)counters, 0, 1);
 
 	perf_irq = save_perf_irq;
 }
