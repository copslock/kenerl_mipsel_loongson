Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14HVQ222103
	for linux-mips-outgoing; Mon, 4 Feb 2002 09:31:26 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14HVJA21979
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 09:31:19 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2B8CE125C8; Mon,  4 Feb 2002 08:31:15 -0800 (PST)
Date: Mon, 4 Feb 2002 08:31:15 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: cgd@broadcom.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020204083115.C13384@lucon.org>
References: <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org> <20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15454.22661.855423.532827@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Mon, Feb 04, 2002 at 09:46:45AM +0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 09:46:45AM +0000, Dominic Sweetman wrote:
> 
> cgd@broadcom.com (cgd@broadcom.com) writes:
> 
> > Branch-likely instructions probably _do_ buy you something (at
> > least, slightly less code size) on some CPUs, probably even some
> > CPUs which are still being produced.
> 
> Here's how branch likely is used to improve performance in a simple
> MIPS CPU, and why it has no effect on code size.
> 
> You start off with this:
> 
>   loopstart: insn 1
>              insn 2
>              ....
> 	     insn last
> 	     branch to loopstart
>              nop
> 
> In small loops, the last instruction in the loop might well calculate
> the branch condition, so it can't be moved into the delay slot of the
> loop-closing branch.  That puts a no-op into every loop iteration.
> With branch-likely, you can transform the loop to 
>             
>   loopstart: insn 1
>   loop2:     insn 2
>              ....
> 	     insn last
> 	     branch-likely loop2
> 	     insn 1 (copy)
> 
> The nop is replaced by a duplicate instruction from the top
> of the loop.  Good for performance, no effect on code size.
> 
> Builders of clever modern CPUs full of branch prediction hardware,
> multiple instruction issue and instruction re-ordering find the
> coupling of the branch-likely to the following instruction makes their
> CPUs more complicated.  That's why MIPS have warned that the
> instructions will be removed from some future version of the MIPS
> instruction set.

I can change glibc not to use branch-likely without using nop. But it
may require one or two instructions outside of the loop. Should I do
it given what we know now?


H.J.
