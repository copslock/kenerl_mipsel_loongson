Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OL9St04209
	for linux-mips-outgoing; Tue, 24 Apr 2001 14:09:28 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OL9RM04206
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 14:09:28 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14sA3n-0006rO-00; Tue, 24 Apr 2001 23:09:23 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14sA3n-0001XX-00; Tue, 24 Apr 2001 23:09:23 +0200
Date: Tue, 24 Apr 2001 23:09:23 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Andrew Linfoot <alinfoot@escafeldcomputing.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Passing kernel args
Message-ID: <20010424230923.A5906@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Andrew Linfoot <alinfoot@escafeldcomputing.co.uk>,
	linux-mips@oss.sgi.com
References: <20010422001440.A1191@bilbo.physik.uni-konstanz.de> <000701c0ccf2$1029ca20$0101a8c0@derfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c0ccf2$1029ca20$0101a8c0@derfel>; from alinfoot@escafeldcomputing.co.uk on Tue, Apr 24, 2001 at 08:09:13PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 24, 2001 at 08:09:13PM +0100, Andrew Linfoot wrote:
> Just thought i would let you know of my experience with autobooting.
> 
> I'm having the same problems as Dave in that i must specify a space in
> the OSLoadOptions " root=/dev/sda1 ro". However every time i shutdown or
> reboot it is truncated to OSLoadOptions= root=/dev/s meaning i have to reset
> it after every reboot.
Could you please send me the kernel command line with and without using
the space (e.g.  dmesg | grep "command line") - i still don't see what
this should be good for.  BTW no need to give root= in OSLoadOptions,
you can use OSLoadPartition instead.
> 
> any ideas as to what may be causing this?
> I am runnning on an Indy R5K
It seems the space in the PROM for OSLoadOptions is quiet limited. The
space available seems to differ between different PROM versions
though(see the HOWTO, it's in there).
> 
> Also i am using an ELF kernel and not ECOFF as specified in Guido's howto.
Doesn't make a difference. ECOFF is just a save bet.
 -- Guido
