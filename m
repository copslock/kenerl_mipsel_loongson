Received:  by oss.sgi.com id <S42406AbQIPADL>;
	Fri, 15 Sep 2000 17:03:11 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:57595 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42366AbQIPAC4>;
	Fri, 15 Sep 2000 17:02:56 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id RAA27427;
	Fri, 15 Sep 2000 17:02:50 -0700
Message-ID: <39C2B8AA.9B873EF7@mvista.com>
Date:   Fri, 15 Sep 2000 17:02:50 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: trap handler for unaligned memory read/write
References: <39C29018.9389FBCE@mvista.com> <20000916012853.A16047@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> > For short-term solutions, we can have trap handler that supports the
> > unaligned read/write.  Does anybody know if there is such a trap handler
> > for MIPS?
> 
> It's right there in your kernel ...
> 

Cool! I found it.

> You _really_ _really_ want to avoid relying on the unaligned trap handler.
> Performancewise that's equivalent to a swapping on a floppy disk on the
> Mars over NFS via avian carriers ...
> 
> However unaligned accesses will result in an address error exception not
> bus error therefore I suspect you've got another problem.
>

I got the error when I use gdb to debug kernel.  I suppose the gdb stub
intercepted the error and report it as BUS error.  We should make
gdb-stub a little smarter  ...

Jun
