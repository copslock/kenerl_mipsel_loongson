Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25KwVW18442
	for linux-mips-outgoing; Tue, 5 Mar 2002 12:58:31 -0800
Received: from mms2.broadcom.com (mms2.broadcom.com [63.70.210.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25KwP918439
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 12:58:25 -0800
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS-2 SMTP Relay (MMS v4.7)); Tue, 05 Mar 2002 11:57:03 -0800
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA26956 for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 11:58:23
 -0800 (PST)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id LAA29738
 for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 11:58:23 -0800 (PST)
Message-ID: <3C85235F.B59286EA@broadcom.com>
Date: Tue, 05 Mar 2002 11:58:23 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: init_idle reaped before final call
X-WSS-ID: 109BFC851680709-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


[cross-posted to linux-kernel in a separate mail (oops)]

I'm working with a (approximately) 2.4.17 kernel from the mips-linux
tree (oss.sgi.com).

I'd like to propose removing the "__init" designation from init_idle in
kernel/sched.c, since this is called from rest_init via cpu_idle. 
Notice that rest_init isn't in an init section, and explicitly mentions
that it's avoiding a race with free_initmem.  In my kernel (an SMP
kernel running on a system with only 1 available CPU), cpu_idle isn't
getting called until after free_initmem().

My CPU is MIPS, but it looks like x86 could experience the same problem.

Kip

Index: kernel/sched.c
===================================================================
RCS file:
/projects/bbp/cvsroot/systemsw/linux/src/kernel/kernel/sched.c,v
retrieving revision 1.10
diff -u -r1.10 sched.c
--- kernel/sched.c      2002/01/15 04:13:43     1.10
+++ kernel/sched.c      2002/03/05 19:40:14
@@ -1304,7 +1304,7 @@
 
 extern unsigned long wait_init_idle;
 
-void __init init_idle(void)
+void init_idle(void)
 {
        struct schedule_data * sched_data;
        sched_data = &aligned_data[smp_processor_id()].schedule_data;
