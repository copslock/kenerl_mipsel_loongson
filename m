Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0H9R29672
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:17:09 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAE0H5029664;
	Tue, 13 Nov 2001 16:17:05 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0GwjR028875;
	Tue, 13 Nov 2001 16:16:58 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0Gv3K028871;
	Tue, 13 Nov 2001 16:16:57 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 13 Nov 2001 16:16:57 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Krishna Kondaka <krishna@sanera.net>, linux-mips@oss.sgi.com
Subject: Re: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
In-Reply-To: <20011114104753.A10410@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111131615340.28670-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > {
> > #ifdef CONFIG_SMP
> >         kfree((void *)mm->context);
> > #else
> >         /* Nothing to do.  */
> > #endif
> > }
> > 
> > And when I tested this I do not see the memory leak any more.
> 
> Almost correct, as James already explained you have to check for a
> non-null pointer first.  

Hm. It was pointed out that kfree actually does the checking for us. 
Do we really need the check? 

> We got a more elegant implementation of
> context switching which I'll add to CVS asap; it gets away without
> any memory allocation.

:-)
