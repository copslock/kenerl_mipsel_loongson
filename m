Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CEJMRw025767
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 07:19:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CEJLL2025766
	for linux-mips-outgoing; Fri, 12 Jul 2002 07:19:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f41.dialo.tiscali.de [62.246.16.41])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CEJCRw025757
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 07:19:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6CENMK18810;
	Fri, 12 Jul 2002 16:23:22 +0200
Date: Fri, 12 Jul 2002 16:23:22 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Sigcontext->sc_pc Passed to User
Message-ID: <20020712162322.A18691@dea.linux-mips.net>
References: <20020712120024.A20727@dea.linux-mips.net> <E17T03Y-0002tg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17T03Y-0002tg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 12, 2002 at 02:01:56PM +0100
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 12, 2002 at 02:01:56PM +0100, Alan Cox wrote:

> > Non-overcommit means large amounts of memory are required when forking
> > of a new process.  The standard example is a fat bloated Mozilla forking
> > for printing.  Non-overcommit means you need those 50 or 100 megs of
> > Mozilla process size once more and if not as physical memory then at
> > least as swap space.  Deciede yourself if you're paranoid and want that
> > operation to only succeed if that much memory is actually available or
> > if you take the risk of the fork & exec operation failing the other way.
> 
> Your numbers are ridiculously off.
>
> A mozilla instance on x86 commits 17Mb of potentially swap backed memory
> when viewing the mozilla 1.0 start page. (Its actually a bit less but there
> is delay in the garbage collector)

These were typical numbers of the last Mozilla I hacked myself on MIPS.
It can grow larger without doing alot.  Aside of that this isn't Mozilla
specific; any arbitrary program that does some fork & exec thing and
it's memory size could be choosen.

> 2.4.18/19-ac support non overcommit, and its rather useful

No doubt about that.  I just say non overcommit has been subject to long
discussions and as usually in such religious discussions both sides had
valid arguments.  I leave it to everybody to choose his / her own poison.

  Ralf
