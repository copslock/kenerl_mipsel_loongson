Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LNL5a17707
	for linux-mips-outgoing; Mon, 21 Jan 2002 15:21:05 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0LNL2P17683
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 15:21:02 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0K0OF317384;
	Sat, 19 Jan 2002 16:24:15 -0800
Date: Sat, 19 Jan 2002 16:24:15 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "H . J . Lu" <hjl@lucon.org>, Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020119162415.B31028@dea.linux-mips.net>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org> <01b801c1a081$3f6518e0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01b801c1a081$3f6518e0$0deca8c0@Ulysses>; from kevink@mips.com on Sat, Jan 19, 2002 at 01:35:38AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jan 19, 2002 at 01:35:38AM +0100, Kevin D. Kissell wrote:

> Thank you for posting this to linux-mips, since I'm not sure 
> that anyone at MIPS is on the GNU_libc_hacker list.
> 
> It would, in principle, be possible to save/restore k0
> or k1 (but not both) if no other clever solution can be found.  
> There are other VM OSes that manage to do so for MIPS, 
> for other outside-the-old-ABI reasons.  It does, of course,
> add some instructions and some memory traffic to the 
> low-level exception handling , and we would have to look 
> at whether we would want to make such a feature standard 
> or specific to a "thread-ready" kernel build.

Changing the kernel for the small number of threaded applications that
exists and taking a performance impact for the kernel itself and anything
that's using threads is an exquisite example for a bad tradeoff.

  Ralf
