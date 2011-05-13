Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:12:44 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:31828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491839Ab1EMPMj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:12:39 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4DFAtrG006359
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 13 May 2011 11:10:55 -0400
Received: from [10.11.10.76] (vpn-10-76.rdu.redhat.com [10.11.10.76])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p4DFAn8K002266;
        Fri, 13 May 2011 11:10:49 -0400
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
From:   Eric Paris <eparis@redhat.com>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     James Morris <jmorris@namei.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kees.cook@canonical.com, agl@chromium.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
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
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 May 2011 11:10:49 -0400
In-Reply-To: <20110513121034.GG21022@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
         <1305169376-2363-1-git-send-email-wad@chromium.org>
         <20110512074850.GA9937@elte.hu>
         <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1305299455.2076.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
Precedence: bulk
X-list: linux-mips

[dropping microblaze and roland]

lOn Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
> * James Morris <jmorris@namei.org> wrote:

> It is a simple and sensible security feature, agreed? It allows most code to 
> run well and link to countless libraries - but no access to other files is 
> allowed.

It's simple enough and sounds reasonable, but you can read all the
discussion about AppArmour why many people don't really think it's the
best.  Still, I'll agree it's a lot better than nothing.

> But if i had a VFS event at the fs/namei.c::getname() level, i would have 
> access to a central point where the VFS string becomes stable to the kernel and 
> can be checked (and denied if necessary).
> 
> A sidenote, and not surprisingly, the audit subsystem already has an event 
> callback there:
> 
>         audit_getname(result);
> 
> Unfortunately this audit callback cannot be used for my purposes, because the 
> event is single-purpose for auditd and because it allows no feedback (no 
> deny/accept discretion for the security policy).
> 
> But if had this simple event there:
> 
> 	err = event_vfs_getname(result);

Wow it sounds so easy.  Now lets keep extending your train of thought
until we can actually provide the security provided by SELinux.  What do
we end up with?  We end up with an event hook right next to every LSM
hook.  You know, the LSM hooks were placed where they are for a reason.
Because those were the locations inside the kernel where you actually
have information about the task doing an operation and the objects
(files, sockets, directories, other tasks, etc) they are doing an
operation on.

Honestly all you are talking about it remaking the LSM with 2 sets of
hooks instead if 1.  Why?  It seems much easier that if you want the
language of the filter engine you would just make a new LSM that uses
the filter engine for it's policy language rather than the language
created by SELinux or SMACK or name your LSM implementation.

>  - unprivileged:  application-definable, allowing the embedding of security 
>                   policy in *apps* as well, not just the system
> 
>  - flexible:      can be added/removed runtime unprivileged, and cheaply so
> 
>  - transparent:   does not impact executing code that meets the policy
> 
>  - nestable:      it is inherited by child tasks and is fundamentally stackable,
>                   multiple policies will have the combined effect and they
>                   are transparent to each other. So if a child task within a
>                   sandbox adds *more* checks then those add to the already
>                   existing set of checks. We only narrow permissions, never
>                   extend them.
> 
>  - generic:       allowing observation and (safe) control of security relevant
>                   parameters not just at the system call boundary but at other
>                   relevant places of kernel execution as well: which 
>                   points/callbacks could also be used for other types of event 
>                   extraction such as perf. It could even be shared with audit ...

I'm not arguing that any of these things are bad things.  What you
describe is a new LSM that uses a discretionary access control model but
with the granularity and flexibility that has traditionally only existed
in the mandatory access control security modules previously implemented
in the kernel.

I won't argue that's a bad idea, there's no reason in my mind that a
process shouldn't be allowed to control it's own access decisions in a
more flexible way than rwx bits.  Then again, I certainly don't see a
reason that this syscall hardening patch should be held up while a whole
new concept in computer security is contemplated...

-Eric
