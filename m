Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OE3ke18532
	for linux-mips-outgoing; Tue, 24 Apr 2001 07:03:46 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OE3kM18529
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 07:03:46 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id KAA29228;
	Tue, 24 Apr 2001 10:12:02 -0400
Message-ID: <3AE588AA.5874E870@lineo.com>
Date: Tue, 24 Apr 2001 15:07:38 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fabrice Bellard <bellard@email.enst.fr>
CC: linux-mips@oss.sgi.com, rivers@lexmark.com
Subject: Re: gdb single step ?
References: <Pine.GSO.4.02.10104241544480.9515-100000@donjuan.enst.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Fabrice Bellard wrote:
> 
> Hi!
> 
> I was speaking about gdb support in user mode, not the gdb stub in the
> kernel. Does someone use gdb to debug user space programs on linux-mips ?
> Maybe someone added the PTRACE_SINGLESTEP command of the ptrace syscall in
> recent mips kernel, but I do not have it in my kernel (linux-2.4.0 on sgi
> site).
> 
> I patched gdb 5.0 so that single step on mips is correctly supported in
> user mode. I also modified gdbserver so that it works when you debug mips
> code in user mode.
> 

<snip>

Hi Fabrice,

I know you meant user mode... it's just that I had some success adapting
the kernel stub code for use in Martin's gdbserver for debugging user
mode code. I guess now we have 2 gdbservers :-)

Best regards,
Ian
