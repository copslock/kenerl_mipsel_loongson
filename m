Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2QIpOZ03550
	for linux-mips-outgoing; Tue, 26 Mar 2002 10:51:24 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2QIpKq03546
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 10:51:20 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16pw4e-0003Bd-00
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 19:53:36 +0100
Date: Tue, 26 Mar 2002 19:53:36 +0100
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@oss.sgi.com
Subject: Re: Mips16 toolchain?
Message-ID: <20020326185336.GA6017@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@oss.sgi.com
References: <20020325135834.GA1736@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020325135834.GA1736@convergence.de>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

First of all, many thanks for your help!

I wrote:
> $ mips-linux-gcc -mips16 -Wall -S t16.c
> t16.c: In function `main':
> t16.c:8: Internal compiler error:

Non-PIC mips16 compilation seems to work with gcc-2.95.4-debian:

  $ mips-linux-gcc -fno-pic -mno-abicalls -mips16 -Wall -c t16.c

yields a t16.o, which looks good when disassembled with
mips-linux-objdump.

Now I need a non-PIC version of libgcc to link against,
since mips-linux-ld cannot link PIC with non-PIC code.
I had built a non-PIC libgcc for earlier dietlibc experiments,
but discarded it in favor of a less experimental development
environment...

I feel I have to learn more about the Linux kernel's role
when executing mips16 code (unaligned.c etc.), and experiment
more with my toolchain, until I know what I'm really doing ;-)
I will post here when I have any meaningful results.


Regards,
Johannes
