Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEIw313488
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:18:58 -0700
Received: from smtp3.xs4all.nl (smtp3.xs4all.nl [194.109.127.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEIqV13467;
	Fri, 10 Aug 2001 07:18:52 -0700
Received: from auto-nb1.xs4all.nl (coltex.xs4all.nl [213.84.127.168])
	by smtp3.xs4all.nl (8.9.3/8.9.3) with ESMTP id QAA19646;
	Fri, 10 Aug 2001 16:18:34 +0200 (CEST)
Message-Id: <4.3.2.7.2.20010810161107.032d5ee8@pop.xs4all.nl>
X-Sender: knuffie@pop.xs4all.nl
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 10 Aug 2001 16:18:07 +0200
To: Steve Lord <lord@sgi.com>, Ralf Baechle <ralf@oss.sgi.com>
From: Seth Mos <knuffie@xs4all.nl>
Subject: Re: XFS installer 
Cc: Brandon Barker <bebarker@meginc.com>, linux-mips@oss.sgi.com,
   linux-xfs@oss.sgi.com
In-Reply-To: <200108101346.f7ADkQ307720@jen.americas.sgi.com>
References: <Message from Ralf Baechle <ralf@oss.sgi.com>
 <20010810131954.C23866@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 08:46 10-8-2001 -0500, Steve Lord wrote:
> > On Fri, Aug 10, 2001 at 07:38:15AM +0200, Seth Mos wrote:
>V1 directories mostly work in Linux, but there are glibc getdents issues
>with them. The glibc code which lseeks backwards in a directory is the issue,
>if you have control over your glibc it can be fixed by using the 64 bit
>version of lseek in this code. This is all because the directory offset in
>V1 is a 64 bit hash value, not a 32 bit signed number.

Would this have adverse effects on existing code if this would be changed? 
Is it something that can be done without pulling out everything from 
beneath us? Does userspace need to be recompiled? Would something like this 
be needed for other architectures as well?

If this can become standard in glibc we can tell people that it is 
supported from glibc 2.2.? systems and higher.

Would a workaround in the kernel code even be a possibility.

Cheers

--
Seth
Every program has two purposes one for which
it was written and another for which it wasn't
I use the last kind.
