Received:  by oss.sgi.com id <S553859AbQJ3OWx>;
	Mon, 30 Oct 2000 06:22:53 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:50445 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553795AbQJ3OWl>;
	Mon, 30 Oct 2000 06:22:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 03F4FA21; Mon, 30 Oct 2000 15:22:39 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A6BD9900C; Mon, 30 Oct 2000 15:21:29 +0100 (CET)
Date:   Mon, 30 Oct 2000 15:21:29 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Still cannot compile the KERNEL!!!
Message-ID: <20001030152129.D2687@paradigm.rfc822.org>
References: <39FDAE22.7626E6E@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <39FDAE22.7626E6E@isratech.ro>; from octavp@isratech.ro on Mon, Oct 30, 2000 at 12:21:38PM -0500
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 12:21:38PM -0500, Nicu Popovici wrote:
> Hello you all,
> 
> I have a problem. I've built a crosscompiler for MIPS on my intel
> machine but until now I could not compile any mips kernel. I tried with
> version from CVS site  and now I an trying with
> linux-2.2.12.mips-src.01.04.tar.gz and I an running into errors from the
> beggining.( are in the attached file )
> 
> I still succeded to compile a test.c file on my intel machine with my
> crosscompiler and then to run the resulted file on the mips machine and
> it worked.
> When I tried with the g++ and with the test.cpp ( a simple class ) the
> crosscompiler made a file but when I executed on the mips machine it
> says
> a.out error in loading shared libraries
> undefined simbol : _deregister_frame_info

I guess you have a broken 2.07 glibc for mips lying around - Try to eliminate
that and use the 2.06 made by ralf or start with glibc 2.2
(For experienced users)

BTW: For compiling a kernel you dont need and glibc on the cross devel machine
at all.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
