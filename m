Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 01:01:34 +0000 (GMT)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:32775 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225211AbTCGBBe>; Fri, 7 Mar 2003 01:01:34 +0000
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Thu, 06 Mar 2003 16:58:30 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id RAA19846 for <linux-mips@linux-mips.org>; Thu, 6 Mar 2003 17:01:13
 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h2711OER027596 for <linux-mips@linux-mips.org>; Thu, 6 Mar 2003 17:01:
 24 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id RAA15332 for
 <linux-mips@linux-mips.org>; Thu, 6 Mar 2003 17:01:24 -0800
Message-ID: <3E67EF64.152CFC6C@broadcom.com>
Date: Thu, 06 Mar 2003 17:01:24 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [pathch] kernel/sched.c bogon?
X-WSS-ID: 1279313C2779821-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


The comparisons of oldest_idle below trigger compiler warnings and
should probably be safely type-cast:

Kip

Index: kernel/sched.c
===================================================================
RCS file: /home/cvs/linux/kernel/sched.c,v
retrieving revision 1.64.2.6
diff -u -r1.64.2.6 sched.c
--- kernel/sched.c      25 Feb 2003 22:03:13 -0000      1.64.2.6
+++ kernel/sched.c      7 Mar 2003 00:57:35 -0000
@@ -282,7 +282,7 @@
                                target_tsk = tsk;
                        }
                } else {
-                       if (oldest_idle == -1ULL) {
+                       if (oldest_idle == (cycles_t) -1) {
                                int prio = preemption_goodness(tsk, p,
cpu);
 
                                if (prio > max_prio) {
@@ -294,7 +294,7 @@
        }
        tsk = target_tsk;
        if (tsk) {
-               if (oldest_idle != -1ULL) {
+               if (oldest_idle != (cycles_t) -1) {
                        best_cpu = tsk->processor;
                        goto send_now_idle;
                }
