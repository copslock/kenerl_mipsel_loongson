Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JFsTRw002003
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 08:54:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JFsTwk002002
	for linux-mips-outgoing; Fri, 19 Jul 2002 08:54:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JFsORw001989
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 08:54:25 -0700
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id IAA01973;
	Fri, 19 Jul 2002 08:54:46 -0700 (PDT)
	(envelope-from rh@matriplex.com)
Date: Fri, 19 Jul 2002 08:54:46 -0700 (PDT)
From: Richard Hodges <rh@matriplex.com>
To: Johannes Stezenbach <js@convergence.de>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
In-Reply-To: <20020719123828.GA5521@convergence.de>
Message-ID: <Pine.BSF.4.10.10207190846180.1937-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 19 Jul 2002, Johannes Stezenbach wrote:

> I'm working on a platform without LL/SC, an embedded system/SOC
> with a NEC VR4120A CPU core. To find out the effect of sysmips
> vs. emulated LL/SC vs. the branch-likely trick posted by
> Kevin D. Kissell <kevink@mips.com> on Tue, 22 Jan 2002 18:16:25 +0100
> I created an experimental patch for glibc-2.2.5 which allows
> run-time switching of the _test_and_set() and __compare_and_swap()
> implementation based on the presence of two "switch files" in /etc/.

...

> I think the beql-hack needs a kernel patch to guarantee k1 !=
> MAGIC_COOKIE after each eret, but for a those few tests I was just
> taking my chance.

Maybe something like this in front of every "eret" instruction?

#ifdef CONFIG_CPU_VR41XX
	move	$27,$0
#endif

I am also working with an NEC core, and would much prefer to perform
atomic operations in user space.  (I understand that this trick is
probably not SMP safe - I don't really care.)

-Richard
