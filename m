Received:  by oss.sgi.com id <S553867AbQJ3PYe>;
	Mon, 30 Oct 2000 07:24:34 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:10770 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553862AbQJ3PYN>;
	Mon, 30 Oct 2000 07:24:13 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id HAA06953;
	Mon, 30 Oct 2000 07:23:20 -0800
Date:   Mon, 30 Oct 2000 07:23:20 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Still cannot compile the KERNEL!!!
Message-ID: <20001030072320.B6450@chem.unr.edu>
References: <39FDAE22.7626E6E@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39FDAE22.7626E6E@isratech.ro>; from octavp@isratech.ro on Mon, Oct 30, 2000 at 12:21:38PM -0500
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 12:21:38PM -0500, Nicu Popovici wrote:

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

Please tell us the exact versions of the toolchain and libc you are
using. gcc -v, ld --version, and the exact libc version and any
patches you applied and where you got them. In all likelihood one or
more of these things is either a known broken version or a mismatch.
Make sure too that, regardless of what versions you have, you copy all
the libraries from the same versions onto the mips machine.

In addition, I'd recommend using current 2.2 CVS kernels unless for
some reason you know you can't. The tag is linux_2_2. Please note that
you don't need libc at all to cross-build a kernel.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
