Received:  by oss.sgi.com id <S42413AbQI2WDy>;
	Fri, 29 Sep 2000 15:03:54 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.19.53]:54022
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42239AbQI2WDk>; Fri, 29 Sep 2000 15:03:40 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869802AbQI2Q0l>;
        Fri, 29 Sep 2000 18:26:41 +0200
Date:   Fri, 29 Sep 2000 18:26:40 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Greg Lonnon <glonnon@ridgerun.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: problems execve("/sbin/init",...)
Message-ID: <20000929182640.F16050@bacchus.dhis.org>
References: <39D3FFE4.35E83599@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39D3FFE4.35E83599@ridgerun.com>; from glonnon@ridgerun.com on Thu, Sep 28, 2000 at 08:35:16PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Sep 28, 2000 at 08:35:16PM -0600, Greg Lonnon wrote:

> Some printk debug from binfmt_elf.c:
> (start_brk) 10004e04
> (end_code) 4782a0
> (start_code) 400000
> (end_data) 10003dbc
> (start_stack) 7fffff90
> (brk) 10004e04
> start theard pc 400140 sp 7fffff90

Looks sane.

> 3) Have been trying to get printk support into system calls by rewriting
> read_write.c::sys_write (and friends) to do a printk() at the start of
> the call.  I have written a statically linked program that calls
> write(0,"here",4).  This didn't result in printk output.  I would
> suspect that the program is not being correctly execve.

I suggest you check that your program actually gets paged into memory by
enabling the debug printf near the start of do_page_fault() in
arch/mips/mm/fault.c.

One thing which may happend and will freeze the process in question is
if you take recursive page faults, that is the page fault handler will
re-enter itself and down() in do_page_fault() will be called a second
time for the same process before a match up() call for the previous
invocation.  

> So, my questions are:
> 1) Does anyone have a good way to debug in this small window going
> between kernel mode and user mode for the first time?
> 2) Is there anything else I could try to prove out that the kernel is
> going into user mode?
> 3) Has anyone else had these issues?

I don't have any reports like this.

Many of the obscure bug reports like this are caused by the usage of
inapropriate tools to build the kernel.  The recommended versions are
egcs 1.0.3a and binutils 2.8.1 with the latest patches from oss.sgi.com
applied. To make live easier for you there are also source and binary
rpms available there somewhere under /pub/linux/mips.

> My command_line is: 
> console=ttyS0,115200 root=/dev/nfs
> nfsroot=192.168.1.12:/projects/mips/fs ip=192.168.1.211:192.168.1.1:::::
> 
> Also, My /dev/console is pointing to /dev/ttyS0 and it seems to be dead,
> I can't printf() to stdout.

/dev/console should a character device with major 5 and minor 1.  Everything
else is either outdated, hackish or even broken.

  Ralf
