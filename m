Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KItnl02844
	for linux-mips-outgoing; Fri, 20 Apr 2001 11:55:49 -0700
Received: from ayr-74.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KItmM02841
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 11:55:48 -0700
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by ayr-74.ayrnetworks.com (8.11.0/8.11.0) with ESMTP id f3KIti201509;
	Fri, 20 Apr 2001 11:55:44 -0700
Message-ID: <3AE08630.FF25517A@ayrnetworks.com>
Date: Fri, 20 Apr 2001 11:55:44 -0700
From: Bryan Chua <chua@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "George Gensure,,," <werkt@csh.rit.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: glibc build
References: <3ADFC5C9.6060906@csh.rit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I ran into this at some point and tracked it down to adding -D__PIC__ to
CFLAGS.  I don't think it is necessary on newer (unreleased) compilers.

-- bryan

"George Gensure,,," wrote:

> I get the following error while trying to cross-build glibc for mips on
> an i686.  Can anyone give any insight?
>
> ../sysdeps/mips/setjmp.S: Assembler messages:
> ../sysdeps/mips/setjmp.S:43: Error: Can not represent
> BFD_RELOC_16_PCREL_S2 relocation in this object file format
> make[2]: *** [/usr/local/crossbuild/glibc-build/setjmp/setjmp.o] Error 1
> make[2]: Leaving directory `/usr/local/crossbuild/glibc-2.2/setjmp'
> make[1]: *** [setjmp/subdir_lib] Error 2
> make[1]: Leaving directory `/usr/local/crossbuild/glibc-2.2'
> make: *** [install] Error 2
>
> George
> werkt@csh.rit.edu
