Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AGkUZ30952
	for linux-mips-outgoing; Tue, 10 Jul 2001 09:46:30 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AGkTV30949
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 09:46:29 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B2644125BA; Tue, 10 Jul 2001 09:46:27 -0700 (PDT)
Date: Tue, 10 Jul 2001 09:46:27 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: MIPS Cross Compiler Tools
Message-ID: <20010710094627.D19026@lucon.org>
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25369470B6F0D41194820002B328BDD27D22@ATLOPS>; from marc_karasek@ivivity.com on Tue, Jul 10, 2001 at 12:27:43PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 10, 2001 at 12:27:43PM -0400, Marc Karasek wrote:
> I had a question about the cross compiler tools for MIPS, specifically
> glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> the compiler (C, C++).  
> 
> Are most people building glibc against these or are you building the tools
> completely from scratch?  As glibc is needed to compile anything else other
> than the kernel. 

My RedHat 7.1 release on oss.sgi.com has the complete cross toolchain:



H.J.
-----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
