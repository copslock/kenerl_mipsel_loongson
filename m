Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KJx6d06191
	for linux-mips-outgoing; Fri, 20 Apr 2001 12:59:06 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KJx3M06184;
	Fri, 20 Apr 2001 12:59:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9C9C77F7; Fri, 20 Apr 2001 21:59:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 11F27F38F; Fri, 20 Apr 2001 21:58:41 +0200 (CEST)
Date: Fri, 20 Apr 2001 21:58:41 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010420215841.D15990@paradigm.rfc822.org>
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org> <20010312144131.C7715@paradigm.rfc822.org> <3AE0885F.D1A3D26@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AE0885F.D1A3D26@mvista.com>; from ppopov@mvista.com on Fri, Apr 20, 2001 at 12:05:03PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 20, 2001 at 12:05:03PM -0700, Pete Popov wrote:
> 
> I'm bringing this up again because none of the related patches on this
> topic have been applied to the latest cvs kernel.  The patch Florian
> refers to above oopses for me as well.  This patch below, from Florian,
> but updated against the latest cvs kernel, works (at least the few
> simple tests I've run do work now).  
> 

The patch is definitly only a workaround and not a fix - The problem
is that the sysmips saves registers on the stack in the function
prolog. When taking the shortcut exit which is needed to not garble
the return code which can be "unsigned int" and not interpret it
as an -ESOMETHING. When doing this you need to skip a couple of instructions in
scall_o32.S which makes the shortcut necessary. On the shortcut
the compiler does not generate a correct epilgue (How should it know)
so the registers get garbled in the syscall which lets your programs
die.

The asm variant tries to only touch registers already saved in
scall_o32.S (and also restored on exit) which are not anymore
used or register we are allowed to change anyway (caller saved).

A different solution would be to take the usual exit in sysmips via
the return at the end (for which the compiler generated a correct
epilogue) and modify the return address - This is an very ugly hack
and you cant tell where the compiler stores the ra on the stack.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
