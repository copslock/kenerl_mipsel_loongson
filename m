Received:  by oss.sgi.com id <S42205AbQHGRqA>;
	Mon, 7 Aug 2000 10:46:00 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:46859 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42190AbQHGRpk>;
	Mon, 7 Aug 2000 10:45:40 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA05058;
	Mon, 7 Aug 2000 10:44:56 -0700
Date:   Mon, 7 Aug 2000 10:44:55 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     linuxce-devel@linuxce.org, linux-mips@oss.sgi.com
Subject: Starting point for a wchan patch
Message-ID: <20000807104455.B3164@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

This patch is a first attempt at a fix for the wchan BUG. It uses the
stack unwinder from the oops tracer. Unfortunately the results it
returns are often incorrect and even insane. I'm just hoping maybe it
will trigger someone's thinking in the right direction; it's obviously
nowhere near usable-quality.

Index: arch/mips/kernel/process.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.20
diff -u -r1.20 process.c
--- arch/mips/kernel/process.c	2000/07/11 02:32:10	1.20
+++ arch/mips/kernel/process.c	2000/08/04 23:36:32
@@ -197,6 +197,9 @@
 {
 	unsigned long schedule_frame;
 	unsigned long pc;
+	unsigned int *sp;
+	extern char _stext, _etext;
+	unsigned long kstart, kend;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
@@ -212,9 +215,21 @@
 		schedule_frame = ((unsigned long *)p->thread.reg30)[9];
 		return ((unsigned long *)schedule_frame)[16];
 	}
-	if (pc >= first_sched && pc < last_sched) {
-		printk(KERN_DEBUG "Bug in %s\n", __FUNCTION__);
+	sp = (unsigned int *)p->thread.reg29;
+	kstart = (unsigned long) &_stext;
+	kend = (unsigned long) &_etext;
+	if (pc < first_sched || pc >= last_sched)
+		goto out;
+        while ((unsigned long) sp & (PAGE_SIZE -1)) {
+                unsigned long addr;
+		if (!__get_user (addr, sp++))
+			if (addr > kstart && addr < kend) {
+				/* Could be a valid caller */
+				pc = addr;
+				if (pc < first_sched || pc >= last_sched)
+					goto out;
+			}
 	}
-
+out:
 	return pc;
 }


How's that for a crock, huh? :)

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
