Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M2dIA21583
	for linux-mips-outgoing; Mon, 21 Jan 2002 18:39:18 -0800
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M2dGP21580
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 18:39:16 -0800
Received: (from rth@localhost)
	by are.twiddle.net (8.11.6/8.11.6) id g0M1dBG14522;
	Mon, 21 Jan 2002 17:39:11 -0800
Date: Mon, 21 Jan 2002 17:39:11 -0800
From: Richard Henderson <rth@twiddle.net>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121173911.A14483@are.twiddle.net>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	Ulrich Drepper <drepper@redhat.com>,
	GNU libc hacker <libc-hacker@sources.redhat.com>,
	linux-mips@oss.sgi.com
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020118101908.C23887@lucon.org>; from hjl@lucon.org on Fri, Jan 18, 2002 at 10:19:08AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 18, 2002 at 10:19:08AM -0800, H . J . Lu wrote:
> On the other hand, can we change the mips kernel to save k0 or k1 for
> user space?

I doubt it.  Traditionally these are clobbered by the TLB fill trap.


r~
