Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAJrQD13489
	for linux-mips-outgoing; Mon, 10 Dec 2001 11:53:26 -0800
Received: from habanero.picante.com (picante.ne.mediaone.net [24.91.80.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAJrNo13486
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 11:53:23 -0800
Received: from habanero.picante.com (gtaylor@habanero.picante.com [192.168.0.5])
	by habanero.picante.com (8.12.1/8.12.1/Debian -2) with ESMTP id fBAIrGL4004125
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 13:53:16 -0500
Message-Id: <200112101853.fBAIrGL4004125@habanero.picante.com>
From: Grant Taylor <gtaylor+mips@picante.com>
To: linux-mips@oss.sgi.com
Subject: Static register access from outside scall_o32.S
Date: Mon, 10 Dec 2001 13:53:16 -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi there.  I'm porting vmadump (a process checkpoint module) to
Linux/MIPS.  The thing now works, but to make it go I had to adjust
the entry and exit points in arch/mips/kernel/scall_o32.S such that
they always do SAVE_ALL and RESTORE_ALL_AND_RET.

Normally, it appears that "static" registers and probably a few others
are either left alone by the kernel code or stored on the stack
somewhere by the syscall and/or subsequent jump instructions.

Anywho, the rub is that the vmadump code needs for the passed-in
pt_regs to be complete, and needs for the syscall return path from it
to fully restore from pt_regs if it has been modified.  Obviously I'd
like to do this without making all syscalls store everything.

I see that marking the task for rescheduling will make all the
registers be saved and restored, but that's either *after* I'm
supposed to have copied all the register contents, or *before* I've
written new information to the pt_regs, so that's not it.

Is there any nice way to read and/or modifiy the static and other
"!SOME" register values from within my system call implementation?  I
assume I can find them on the stack somewhere, but that seems awfully
ugly.

-- 
Grant Taylor - gtaylor@picante.com - http://www.picante.com/~gtaylor/
  Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
