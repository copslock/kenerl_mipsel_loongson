Received:  by oss.sgi.com id <S553705AbQJZVQw>;
	Thu, 26 Oct 2000 14:16:52 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:50172 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553652AbQJZVQl>;
	Thu, 26 Oct 2000 14:16:41 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9QLEr308975;
	Thu, 26 Oct 2000 14:14:53 -0700
Message-ID: <39F89F81.1A34F7C@mvista.com>
Date:   Thu, 26 Oct 2000 14:17:53 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Mark Lehrer <mark@knm.org>
CC:     linux-mips@oss.sgi.com
Subject: Re: Threads on mips
References: <200010261455.IAA05015@home.knm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mark Lehrer wrote:
> 
> Hello!  I am just getting started with one of the MIPS embedded
> platforms, the NEC VR4122.  I downloaded the kernel & ramdisk from the
> linux-vr web pages.
> 
> Some of the apps I'm trying to port over use pthreads; however, the
> pthread library that is included doesn't appear to work - the process
> that tries to create a thread just waits forever until I hit ctrl-c.
>

I have worked with linux-vr before and tried to get pthread working. 
The glibc v2.0.7 had several problems in terms of getting pthread
working.

> Is anyone using threads with the mips embedded platforms?  If so, what
> kernel, libc, and pthreads library are you using?
>

I just found a bug in kernel yesterday.  After the temporary fix, my
pthread test program seems to work.  I am using glibc 2.0.6.  Kernel is
v2.4 from cvs tree.
 
> If not, has anyone thought about what it might take to get threads to
> work?
>

I am thinking about that a lot. :-)  I like to get ViewML, a web
broswer, working.  It requires pthreads.

Jun
