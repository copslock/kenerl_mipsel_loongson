Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IK8oA07183
	for linux-mips-outgoing; Fri, 18 Jan 2002 12:08:50 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IK8lP07174
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 12:08:47 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 19686125C1; Fri, 18 Jan 2002 11:08:44 -0800 (PST)
Date: Fri, 18 Jan 2002 11:08:44 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020118110844.A25165@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org> <m3elkn4ikq.fsf@myware.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3elkn4ikq.fsf@myware.mynet>; from drepper@redhat.com on Fri, Jan 18, 2002 at 10:31:17AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 18, 2002 at 10:31:17AM -0800, Ulrich Drepper wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > I don't see there are any registers we can use without breaking ABI.
> > On the other hand, can we change the mips kernel to save k0 or k1 for
> > user space?
> 
> Are these registers which are readable by normal users but writable
> only in ring 0?  If yes, this is definitely worthwhile (similar to how

I can write to k0/k1. But the value is not perserved by kernel.

> x86 works).  The only problem will be the MIPS variants which don't
> have this register.  I bet there are some.

I don't think so. k0/k1 is reserved for OS. I don't know if OS can
restore it for use space or not.


H.J.
