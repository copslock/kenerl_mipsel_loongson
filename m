Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g025YY801751
	for linux-mips-outgoing; Tue, 1 Jan 2002 21:34:34 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g025YUg01748
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 21:34:31 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g024YKw09899;
	Wed, 2 Jan 2002 02:34:20 -0200
Date: Wed, 2 Jan 2002 02:34:20 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
Message-ID: <20020102023420.A8786@dea.linux-mips.net>
References: <3C21390A.FA23978D@mvista.com> <3C219A3B.6DA93A75@mips.com> <20011225044125.A16759@dea.linux-mips.net> <3C2AFD8C.6BAA7F1@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2AFD8C.6BAA7F1@mips.com>; from carstenl@mips.com on Thu, Dec 27, 2001 at 11:53:00AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 11:53:00AM +0100, Carsten Langgaard wrote:

> You are welcome to find a better way of handling a non-fpu instruction in the
> delay slot of the fpu-branch instruction.
> But until someone find a better solution (that works, in all situation), I
> think we need this patch.

I could live with your solution if we'd be living in uniprocessor-land
only.  Well, that time is over now ...

  Ralf
