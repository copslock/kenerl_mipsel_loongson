Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2KKC7o01771
	for linux-mips-outgoing; Tue, 20 Mar 2001 12:12:07 -0800
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2KKC6M01768
	for <linux-mips@oss.sgi.com>; Tue, 20 Mar 2001 12:12:06 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1FMPIY3EA000MBZ@research.kpn.com> for
 linux-mips@oss.sgi.com; Tue, 20 Mar 2001 21:12:04 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id VAA07412; Tue, 20 Mar 2001 21:12:03 +0100 (MET)
X-URL: http://www-lsdm.research.kpn.com/~karel
Date: Tue, 20 Mar 2001 21:12:02 +0100 (MET)
From: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Recommended toolchain
In-reply-to: <3AB6C948.7F8EE4B7@oz.agile.tv>
To: simong@oz.agile.tv (Simon Gee)
Cc: linux-mips@oss.sgi.com
Message-id: <200103202012.VAA07412@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Simon,

You wrote:
> Recently I've been working with various version mixes of the gnu tool
> chain for a mipsel-linux target and settled on a patchy binutils
> 2.8.1/egcs 1.1.2/glibc 2.0.6 setup. However this lacks the functionality
> that I would get from a newer toolchain for use with the linux 2.4
> kernel. As a result, I was wondering if someone could recommend the
> latest "stable"/recommended toolchain for a mipsel-linux target.

Well, I'm currently using:
binutils 2.10.1
gcc 2.95.3 (with Maciej's patches)
glibc 2.2.2 (compiled with above toolchain).

This toolchain works for native compiles on my mipsel box.
One drawback: I can't compile any kernels with this setup,
For kernel compiles I use 2.8.1/egcs-2.90.27/glibc-2.0.6.

-- 
Karel van Houten
----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
