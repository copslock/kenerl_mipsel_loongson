Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 14:45:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48874 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030589AbYAEOpk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jan 2008 14:45:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m05Ejamk013054;
	Sat, 5 Jan 2008 15:45:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m05EjZI4013053;
	Sat, 5 Jan 2008 15:45:35 +0100
Date:	Sat, 5 Jan 2008 15:45:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080105144535.GA12824@linux-mips.org>
References: <477E6296.7090605@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477E6296.7090605@raritan.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 04, 2008 at 11:45:10AM -0500, Gregor Waltz wrote:

> We want to update to a 2.6 kernel, recent build tools, and saner system 
> libraries. Although, it seems that the JMR 3927 is still technically 
> supported, I have not found any info on whether anybody is still running 
> Linux on it and what combination of software they are using. Any idea?
> Is there a combination of software versions that are known to work on this 
> hardware?

It's years since I last had a report of the JMR3927.  Since that time
the code is maintained without the possibility of testing.

> I have used crosstool 0.43 to build:
> binutils 2.15
> gcc 3.4.5
> glibc 2.3.6
>
> I cannot get these kernels to build:
> linux-2.6.13
> linux-2.6.15
> linux-2.6.16.57
> linux-2.6.17.14
> linux-2.6.9

These themselves are rather old.

> My colleague and I have built these:
> linux-2.6.21.7
> linux-2.6.23.9
> linux-2.6.23.12

The build since we tried to fix the JMR3927 as good as possible without
having access to hardware.  Which of course means almost certainly the
one or other buglet is left in the code ...

> However, they all yield a TLBL exception similar to the following:
>
> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc
>
> Each build has different exception values. The values are the same each 
> attempt with the same build.

... quod erat demonstrandum.

> Is this a problem in the kernel code or the build tools?

Well possible a bit of both ...

> Any ideas on how to make it run?

You may want to switch to a recent binutils like 2.18 and gcc 4.2.2.

There was a change related to linker scripts and I think that change
requires a recent binutils version.

> Using the recently built tools, I am currently trying to build the 2.4.12 
> kernel that is known to work, which is proving difficult. If I can get it 
> to build, I am hoping to see whether the tools are able to build a 
> functioning kernel.

2.4.12 had various alergies against modern toolchains.  So you may want
to retain a copy of your old toolchain for use with 2.4.12.  later 2.4
versions have been fixed to build with recent toolchains.

  Ralf
