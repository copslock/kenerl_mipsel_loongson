Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H7FXT10986
	for linux-mips-outgoing; Tue, 17 Jul 2001 00:15:33 -0700
Received: from laxmls04.socal.rr.com (laxmls04.socal.rr.com [24.30.163.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H7FTV10983
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 00:15:29 -0700
Received: from compiler (sc-66-74-235-241.socal.rr.com [66.74.235.241])
	by laxmls04.socal.rr.com (8.11.2/8.11.1) with SMTP id f6H7F7g20833;
	Tue, 17 Jul 2001 00:15:08 -0700 (PDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shane Nay <shane@minirl.com>
To: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [Linux-mips-kernel] Re: [ANNOUNCE] Secondary mips tree.
Date: Tue, 17 Jul 2001 00:16:15 -0700
X-Mailer: KMail [version 1.2]
Cc: Pavel Machek <pavel@suse.cz>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
References: <Pine.LNX.4.10.10107161226220.19188-100000@transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10107161226220.19188-100000@transvirtual.com>
MIME-Version: 1.0
Message-Id: <0107170016150H.02677@compiler>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> That would be good. I look forward to the patches.

Most my MIPs time is in fixing small problems at the moment, but initiating a 
forward port to an active repository is a Good Idea.  Most of my time is 
being funneled into ARM bootloader work here lately though :(.

> > linux-vr has been
> > really really stale since we froze at our present version for toolchain
> > reasons.  Those toolchain problems were fixed ages ago, but Mike & Brad
> > who had been responsible for forward porting the kernel stopped doing
> > that work for the most part.
>
> So we have noticed. Things are starting to get updated now.
>
> P.S
>   We have been having problems with toolchains as well. We plan to have a
> new toolchain ready by Wednesday.

Yes, there have been a lot of toolchain issues with MIPs.  The last time I 
went on a toolchain testing binge for MIPs was with GCC CVS in about April.  
I had really good results with that toolchain with both the kernel and 
userland.  I did some micro tests with 3.0 and they appeared solid, but I had 
updated to the latest non-CVS version of bintools and it was chocking out 
lots of assembler warnings when rebuilding glibc.  There are source and 
binary snaps of that toolchain on the agenda FTP site under snow.

Thanks,
Shane Nay.
