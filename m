Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LNL6E17719
	for linux-mips-outgoing; Mon, 21 Jan 2002 15:21:06 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0LNL3P17700
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 15:21:03 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0K0E5r15490;
	Sat, 19 Jan 2002 16:14:05 -0800
Date: Sat, 19 Jan 2002 16:14:05 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020119161405.A31028@dea.linux-mips.net>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org> <m3elkn4ikq.fsf@myware.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3elkn4ikq.fsf@myware.mynet>; from drepper@redhat.com on Fri, Jan 18, 2002 at 10:31:17AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 18, 2002 at 10:31:17AM -0800, Ulrich Drepper wrote:

> > I don't see there are any registers we can use without breaking ABI.
> > On the other hand, can we change the mips kernel to save k0 or k1 for
> > user space?

These are reserved for kernel use.  Saving them is not a good idea as it
would impact performance of TLB exception handlers which are extremly
performance sensitive.

> Are these registers which are readable by normal users but writable
> only in ring 0?  If yes, this is definitely worthwhile (similar to how
> x86 works).  The only problem will be the MIPS variants which don't
> have this register.  I bet there are some.

No.

  Ralf
