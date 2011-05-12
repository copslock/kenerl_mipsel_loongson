Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 14:16:07 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:45326 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491164Ab1ELMQB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2011 14:16:01 +0200
Received: by gyh20 with SMTP id 20so569903gyh.36
        for <multiple recipients>; Thu, 12 May 2011 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=txQMqIi9LZn4lEjkTGqv0UFvkSM1vSswuUucy6Gg13E=;
        b=wZ0cfcdqYS2PnPAOe53CcmUMPamg+gjU1wevIOV9gr9jKyak3a66QV8/nsgWCfMhLN
         +UGuBkBYNRh22v6qMYS0VxzoGu3/Pooz0w9COz7mdyoowfPEjdQa/XnfXbP+2xo+4lKW
         iLvk3waepMwth1E0NiJZqYA5i1UBYI3TC263Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UnpCsnhpFpmMhVoAsNI4TJ1BFTEO26hPP852i1SbwUbR2zagzzwfumrZZK7CU2JnE/
         C7o4FWjOvPt8LJGJKwLzy24/6ZL6jd1cxA4qyDAwHC8GgWNEejqh7DPaoOFfL409ObeS
         l0FHqB9Pl2+MSN14OdaNa6QLt36pukfGNPfmo=
Received: by 10.236.185.105 with SMTP id t69mr143272yhm.18.1305202552916;
        Thu, 12 May 2011 05:15:52 -0700 (PDT)
Received: from localhost (69.20.196-77.rev.gaoland.net [77.196.20.69])
        by mx.google.com with ESMTPS id e8sm546316yhm.43.2011.05.12.05.15.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 05:15:51 -0700 (PDT)
Date:   Thu, 12 May 2011 14:15:42 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, jmorris@namei.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        Roland McGrath <roland@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
Message-ID: <20110512121539.GA7410@nowhere>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110512074850.GA9937@elte.hu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> To restrict execution to system calls.
> 
> Two observations:
> 
> 1) We already have a specific ABI for this: you can set filters for events via 
>    an event fd.
> 
>    Why not extend that mechanism instead and improve *both* your sandboxing
>    bits and the events code? This new seccomp code has a lot more
>    to do with trace event filters than the minimal old seccomp code ...
> 
>    kernel/trace/trace_event_filter.c is 2000 lines of tricky code that
>    interprets the ASCII filter expressions. kernel/seccomp.c is 86 lines of
>    mostly trivial code.
> 
> 2) Why should this concept not be made available wider, to allow the 
>    restriction of not just system calls but other security relevant components 
>    of the kernel as well?
> 
>    This too, if you approach the problem via the events code, will be a natural 
>    end result, while if you approach it from the seccomp prctl angle it will be
>    a limited hack only.
> 
> Note, the end result will be the same - just using a different ABI.
> 
> So i really think the ABI itself should be closer related to the event code. 
> What this "seccomp" code does is that it uses specific syscall events to 
> restrict execution of certain event generating codepaths, such as system calls.
> 
> Thanks,
> 
> 	Ingo

What's positive with that approach is that the code is all there already.
Create a perf event for a given trace event, attach a filter to it.

What needs to be added is an override of the effect of the filter. By default
it's dropping the event, but there may be different flavours, including sending
a signal. All in one, extending the current code to allow that looks trivial.

The negative points are that

* trace events are supposed to stay passive and not act on the system, except
doing some endpoint things like writing to a buffer. We can't call do_exit()
from a tracepoint for example, preemption is disabled there.

* Also, is it actually relevant to extend that seccomp filtering to other events
than syscalls? Exposing kernel events to filtering sounds actually to me bringing
a new potential security issue. But with fine restrictions this can probably
be dealt with. Especially if by default only syscalls can be filtered

* I think Peter did not want to give such "active" role to perf in the system.
