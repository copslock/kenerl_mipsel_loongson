Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 23:32:14 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:42100 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab0JVVcF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 23:32:05 +0200
X-Authority-Analysis: v=1.1 cv=kXGwZUU/u1JTMRv8Axk4W0omja+vfTT+sGlOkodD8F8= c=1 sm=0 a=MfC5tujjfSwA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=pGLkceISAAAA:8 a=IVzdOBE9tn9M3EjshVoA:9 a=ewpPQ_wnaTnd5ToMzs-HRrfTPTwA:4 a=PUjeQqilurYA:10 a=MSl-tDqOz04A:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:46103] helo=[192.168.23.10])
        by hrndva-oedge02.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 35/10-14897-DC202CC4; Fri, 22 Oct 2010 21:31:58 +0000
Subject: Re: [RFC 2/2] MIPS: tracing/ftrace: Fixes mcount_regex for modules
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
In-Reply-To: <4CC1FDB1.8050404@caviumnetworks.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
         <485f5af61fae72dc9c1f0e31b1b5f1f57a5e7ed8.1287779153.git.wuzhangjin@gmail.com>
         <4CC1FDB1.8050404@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 22 Oct 2010 17:31:56 -0400
Message-ID: <1287783116.16971.642.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Fri, 2010-10-22 at 14:10 -0700, David Daney wrote:
> On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >
> > In some situations(with related kernel config and gcc options), the
> > modules may have the same address space as the core kernel space, so
> > mcount_regex for modules should also match R_MIPS_26.
> >
> 
> I think Steve is rewriting this bit to be a pure C program.  Is this 
> file even used anymore?  If so for how long?

It's already in mainline, but is only supported for x86 for now. Until
we verify that it works for other archs (which is up to you guys to
verify) the script will still be used.

Also, I did not write it, John Reiser did. I just cleaned it up a bit
and got it working with the build system.

-- Steve
