Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VN3ARw015017
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 16:03:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VN38EU015016
	for linux-mips-outgoing; Wed, 31 Jul 2002 16:03:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hermod.qsicorp.com (mail.qsicorp.com [216.190.147.34])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VN2NRw015001;
	Wed, 31 Jul 2002 16:02:57 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.qsicorp.com (Postfix) with ESMTP
	id E7EA61708A; Wed, 31 Jul 2002 17:03:11 -0600 (MDT)
Received: from hermod.qsicorp.com ([127.0.0.1]) by localhost (hermod.qsicorp.com [127.0.0.1]) (amavisd-new) with ESMTP id 23040-10; Wed, 31 Jul 2002 17:03:10 -0000 (MDT)
Received: from qsicorp.com (computer195.qsicorp.com [216.190.147.195])
	by hermod.qsicorp.com (Postfix) with ESMTP
	id 3230417088; Wed, 31 Jul 2002 17:03:10 -0600 (MDT)
Message-ID: <3D487B16.C164C22E@qsicorp.com>
Date: Wed, 31 Jul 2002 17:04:38 -0700
From: Ryan Martindale <ryan@qsicorp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problem with gp
References: <3D482FF3.11F8CA0B@qsicorp.com> <20020731210423.E4892@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new amavisd-new-20020630
X-Razor-id: a70184ae6705604b82a3afccfd148b1922753f75
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Jul 31, 2002 at 11:44:03AM -0700, Ryan Martindale wrote:
> 
> > I seem to be having troubles getting the CVS snapshot up and running.
> > I've debugged it, and it seems that the problem stems from the fact that
> > $28 (gp) is modified in the SAVE_SOME macro to point to somewhere on the
> > stack (not sure why this occurs). Anyways, when I get my first system
> > timetick interrupt, the update_process_times function fails to get the a
> > valid task structure pointer and wipes out. Why are we adjusting gp
> > here, since it is explicitly expected to hold only current_thread_info?
> 
> Are you using 2.5 by chance?  2.5.x is currently pretty unstable as I'm
> porting all the major changes in the upstream sources to MIPS.  I recommend
> to stick with 2.4 for now.
> 
>   Ralf

Check this patch for the current CVS, please. It seems to solve some of
my problems. The related problem mentionned above was because I adjusted
the KERNEL_STACK_SIZE temporarily to twice its given size. Maybe a
comment that you shouldn't adjust that size in stackframe.h is
appropriate?

Yes, I am using the latest from the CVS tree (2.5).  Is everybody
developing with 2.4. Also how quickly are the 2.5 changes going to be
merged into the tree (I understand it is progressing already)?

Index: arch/mips/kernel/process.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.41
diff -r1.41 process.c
78c78
< 	childksp = (unsigned long)p + KERNEL_STACK_SIZE - 32;
---
> 	childksp = (unsigned long)ti + KERNEL_STACK_SIZE - 32;
100c100
< 		childregs->regs[28] = (unsigned long) p;
---
> 		childregs->regs[28] = (unsigned long) ti;


Ryan
