Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEZFN13957
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:35:15 -0700
Received: from zok.sgi.com (zok.SGI.COM [204.94.215.101])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEZCV13951;
	Fri, 10 Aug 2001 07:35:12 -0700
Received: from zeus-fddi.americas.sgi.com (zeus-fddi.americas.sgi.com [128.162.8.103])
	by zok.sgi.com (8.11.4/8.11.4/linux-outbound_gateway-1.0) with ESMTP id f7AEejW14760;
	Fri, 10 Aug 2001 07:40:45 -0700
Received: from daisy-e185.americas.sgi.com (daisy.americas.sgi.com [128.162.185.214]) by zeus-fddi.americas.sgi.com (8.9.3/americas-smart-nospam1.1) with ESMTP id JAA2680720; Fri, 10 Aug 2001 09:33:50 -0500 (CDT)
Received: from jen.americas.sgi.com (IDENT:root@jen.americas.sgi.com [128.162.187.49]) by daisy-e185.americas.sgi.com (SGI-8.9.3/SGI-server-1.7) with ESMTP id JAA01468; Fri, 10 Aug 2001 09:33:50 -0500 (CDT)
Received: from jen.americas.sgi.com by jen.americas.sgi.com (8.11.2/SGI-client-1.7) via ESMTP id f7AEX4P07846; Fri, 10 Aug 2001 09:33:04 -0500
Message-Id: <200108101433.f7AEX4P07846@jen.americas.sgi.com>
To: Seth Mos <knuffie@xs4all.nl>
cc: Steve Lord <lord@sgi.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Brandon Barker <bebarker@meginc.com>, linux-mips@oss.sgi.com,
   linux-xfs@oss.sgi.com
Subject: Re: XFS installer 
References: <Message from Ralf Baechle <ralf@oss.sgi.com> <20010810131954.C23866@bacchus.dhis.org> <4.3.2.7.2.20010810161107.032d5ee8@pop.xs4all.nl>
Comments: In-reply-to Seth Mos <knuffie@xs4all.nl>
   message dated "Fri, 10 Aug 2001 16:18:07 +0200."
Date: Fri, 10 Aug 2001 09:33:04 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> At 08:46 10-8-2001 -0500, Steve Lord wrote:
> > > On Fri, Aug 10, 2001 at 07:38:15AM +0200, Seth Mos wrote:
> >V1 directories mostly work in Linux, but there are glibc getdents issues
> >with them. The glibc code which lseeks backwards in a directory is the issue
> ,
> >if you have control over your glibc it can be fixed by using the 64 bit
> >version of lseek in this code. This is all because the directory offset in
> >V1 is a 64 bit hash value, not a 32 bit signed number.
> 
> Would this have adverse effects on existing code if this would be changed? 
> Is it something that can be done without pulling out everything from 
> beneath us? Does userspace need to be recompiled? Would something like this 
> be needed for other architectures as well?

This is only needed if reasonable V1 directory support is required on
Linux, without it you can get files missing in directories etc. In fact
even with it this can still happen. This was the whole reason we made
V2 the default on Linux (we finally won the battle to make it the
default on Irix too).

> 
> If this can become standard in glibc we can tell people that it is 
> supported from glibc 2.2.? systems and higher.

All attempts to get glibc to budge on this have failed.

> 
> Would a workaround in the kernel code even be a possibility.

I am not sure, no time to think about it right now...

Steve

> 
> Cheers
> 
> --
> Seth
> Every program has two purposes one for which
> it was written and another for which it wasn't
> I use the last kind.
