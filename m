Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g118HKZ25951
	for linux-mips-outgoing; Fri, 1 Feb 2002 00:17:20 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g118HGd25948
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 00:17:16 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 92E2D125C3; Thu, 31 Jan 2002 23:17:14 -0800 (PST)
Date: Thu, 31 Jan 2002 23:17:14 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: macro@ds2.pg.gda.pl, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
Message-ID: <20020131231714.E32690@lucon.org>
References: <20020131123547.A22759@lucon.org> <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl> <20020131144100.A24634@lucon.org> <20020201.123523.50041631.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201.123523.50041631.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Fri, Feb 01, 2002 at 12:35:23PM +0900
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 12:35:23PM +0900, Hiroyuki Machida wrote:
> > _test_and_set (int *p, int v) __THROW 
> > {
> >   int r, t;
> > 
> >   __asm__ __volatile__
> >     (".set      push\n\t"
> >      ".set      noreorder\n"
> >      "1:\n\t"
> >      "ll        %0,%3\n\t"
> >      "beq       %0,%4,2f\n\t"
> >      "move      %1,%4\n\t"
> >      "sc        %1,%2\n\t"
> >      "beqz      %1,1b\n\t"
> >      "nop\n" 
> >      "2:\n\t"
> >      ".set      pop"    
> >      : "=&r" (r), "=&r" (t), "=m" (*p)
> >      : "m" (*p), "r" (v) 
> >      : "memory");
> > 
> >   return r;
> > }
> 
> Gas will fill delay slots. Same object codes will be produced, so I
> think you don't have to do that by hand. 

It will make the code more readable. We don't have to guess what
the assembler will do. 


H.J.
