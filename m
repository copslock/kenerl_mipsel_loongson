Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0J5BjQ20429
	for linux-mips-outgoing; Fri, 18 Jan 2002 21:11:45 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0J5BgP20422
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 21:11:43 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9D373125C1; Fri, 18 Jan 2002 20:11:39 -0800 (PST)
Date: Fri, 18 Jan 2002 20:11:39 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020118201139.A847@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org> <01b801c1a081$3f6518e0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01b801c1a081$3f6518e0$0deca8c0@Ulysses>; from kevink@mips.com on Sat, Jan 19, 2002 at 01:35:38AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jan 19, 2002 at 01:35:38AM +0100, Kevin D. Kissell wrote:
> 
> It would, in principle, be possible to save/restore k0
> or k1 (but not both) if no other clever solution can be found.  
> There are other VM OSes that manage to do so for MIPS, 
> for other outside-the-old-ABI reasons.  It does, of course,
> add some instructions and some memory traffic to the 
> low-level exception handling , and we would have to look 
> at whether we would want to make such a feature standard 
> or specific to a "thread-ready" kernel build.

I like the read-only k0 idea. We just need to make a system call to
tell kernel what value to put in k0 before returning to the user space.
It shouldn't be too hard to implement. I will try it next week.


H.J.
