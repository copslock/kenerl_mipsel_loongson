Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2RL6tl18013
	for linux-mips-outgoing; Wed, 27 Mar 2002 13:06:55 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2RL6nq18009
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 13:06:49 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 833D01EA91; Wed, 27 Mar 2002 22:09:07 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: sjhill@cotw.com
Cc: binutils@sources.redhat.com, linux-mips@oss.sgi.com, uclibc@uclibc.org
Subject: Re: Linux/MIPS and ELF dynamic linker/loader questions...
References: <3CA233B6.58DB8B08@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: Wed, 27 Mar 2002 22:09:00 +0100
In-Reply-To: <3CA233B6.58DB8B08@cotw.com> ("Steven J. Hill"'s message of
 "Wed, 27 Mar 2002 15:03:50 -0600")
Message-ID: <hopu1pn2fn.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Greetings.
>
> I am working on a MIPS dynamic linker/loader for uClibc and
> would appreciate some clarification on the finer points of
> ELF and the Linux kernel interface. Forgive the cross post.
>
> The first problem I have discovered is that the value of
> argc passed back to the userspace process from the Linux
> kernel is always zero. The argv, environment and auxillary
> vectors come through just fine. I have to loop through the
> stack manually to count the number of argument vectors in
> order to get argc:

In glibc I had no problems finding argc, check
sysdeps/mips/elf/start.S:

/* This is the canonical entry point, usually the first thing in the text
   segment.  The SVR4/Mips ABI (pages 3-31, 3-32) says that when the entry
   point runs, most registers' values are unspecified, except for:

   v0 ($2)	Contains a function pointer to be registered with `atexit'.
		This is how the dynamic linker arranges to have DT_FINI
		functions called for shared libraries that have been loaded
		before this code runs.

   sp ($29)	The stack contains the arguments and environment:
		0(%esp)			argc
		4(%esp)			argv[0]
		...
		(4*argc)(%esp)		NULL
		(4*(argc+1))(%esp)	envp[0]
		...
					NULL
   ra ($31)	The return address register is set to zero so that programs
		that search backword through stack frames recognize the last
		stack frame.
*/


Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
