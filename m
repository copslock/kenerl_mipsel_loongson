Received:  by oss.sgi.com id <S305160AbQDTQka>;
	Thu, 20 Apr 2000 09:40:30 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2605 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305157AbQDTQkK>; Thu, 20 Apr 2000 09:40:10 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA07241; Thu, 20 Apr 2000 09:44:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA33965
	for linux-list;
	Thu, 20 Apr 2000 09:30:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA08181
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 09:30:44 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02630
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 09:30:41 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 94254808; Thu, 20 Apr 2000 18:30:43 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 759EE8FC4; Thu, 20 Apr 2000 18:25:22 +0200 (CEST)
Date:   Thu, 20 Apr 2000 18:25:22 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: bug in get_wchan ... 
Message-ID: <20000420182522.B7304@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i had some loops on the annoying "bug in get_wchan" and after i hopefully
understood whats going on 

arch/mips/kernel/process.c

    196 unsigned long get_wchan(struct task_struct *p)
    197 {
    198         unsigned long schedule_frame;
    199         unsigned long pc;
    200 
    201         if (!p || p == current || p->state == TASK_RUNNING)
    202                 return 0;
    203 
    204         pc = thread_saved_pc(&p->thread);
    205         if (pc == (unsigned long) interruptible_sleep_on
    206             || pc == (unsigned long) sleep_on) {
    207                 schedule_frame = ((unsigned long *)p->thread.reg30)[9];
    208                 return ((unsigned long *)schedule_frame)[15];
    209         }
    210         if (pc == (unsigned long) interruptible_sleep_on_timeout
    211             || pc == (unsigned long) sleep_on_timeout) {
    212                 schedule_frame = ((unsigned long *)p->thread.reg30)[9];
    213                 return ((unsigned long *)schedule_frame)[16];
    214         }
    215         if (pc >= first_sched && pc < last_sched) {
    216                 printk(KERN_DEBUG "Bug in %s\n", __FUNCTION__);
    217         }
    218 
    219         return pc;
    220 }

What does "thread_saved_pc(&p->thread);" return ? Does it really
return the exact address of the schedule functions as assumed in
205-214 ?

Most other architectures search the stack page for the calling function
but it seems their asmlinkage is more strict in the means of 
location of the return address on the stack.

The current implementation is buggy not only in the means of 
the printk but also in the wchan - Most of the output
is "schedule" itself which means none of the statements above
had been true but when extending the printk with the pc
it never exactly matches &schedule so a == schedule wont help.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
