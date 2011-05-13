Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 18:29:19 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33933 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMQ3O convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 18:29:14 +0200
Received: by fxm14 with SMTP id 14so2500324fxm.36
        for <multiple recipients>; Fri, 13 May 2011 09:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.134.75 with SMTP id i11mr139359fat.39.1305304146946; Fri,
 13 May 2011 09:29:06 -0700 (PDT)
Received: by 10.223.101.204 with HTTP; Fri, 13 May 2011 09:29:06 -0700 (PDT)
In-Reply-To: <1305302141.2076.56.camel@localhost.localdomain>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
        <1305169376-2363-1-git-send-email-wad@chromium.org>
        <20110512074850.GA9937@elte.hu>
        <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
        <20110512130104.GA2912@elte.hu>
        <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
        <20110513121034.GG21022@elte.hu>
        <1305299455.2076.26.camel@localhost.localdomain>
        <1305300181.2466.72.camel@twins>
        <1305302141.2076.56.camel@localhost.localdomain>
Date:   Fri, 13 May 2011 11:29:06 -0500
Message-ID: <BANLkTinDO0OSav7NgjuE4E5E-Yu2==EQwg@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
From:   Will Drewry <wad@chromium.org>
To:     Eric Paris <eparis@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kees.cook@canonical.com, agl@chromium.org,
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
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wad@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 10:55 AM, Eric Paris <eparis@redhat.com> wrote:
> On Fri, 2011-05-13 at 17:23 +0200, Peter Zijlstra wrote:
>> On Fri, 2011-05-13 at 11:10 -0400, Eric Paris wrote:
>> > Then again, I certainly don't see a
>> > reason that this syscall hardening patch should be held up while a whole
>> > new concept in computer security is contemplated...
>>
>> Which makes me wonder why this syscall hardening stuff is done outside
>> of LSM? Why isn't is part of the LSM so that say SELinux can have a
>> syscall bitmask per security context?
>
> I could do that, but I like Will's approach better.  From the PoV of
> meeting security goals of information flow, data confidentiality,
> integrity, least priv, etc limiting on the syscall boundary doesn't make
> a lot of sense.  You just don't know enough there to enforce these
> things.  These are the types of goals that SELinux and other LSMs have
> previously tried to enforce.  From the PoV of making the kernel more
> resistant to attacks and making a process more resistant to misbehavior
> I think that the syscall boundary is appropriate.  Although I could do
> it in SELinux it don't really want to do it there.

There's also the problem that there are no hooks per-system call for
LSMs, only logical hooks that sometimes mirror system call names and
are called after user data has been parsed.  If system call enter
hooks, like seccomp's, were added for LSMs, it would allow the lsm
bitmask approach, but it still wouldn't satisfy the issues you raise
below (and I wholeheartedly agree with).

> In case people are interested or confused let me give my definition of
> two words I've used a bit in these conversations: discretionary and
> mandatory.  Any time I talk about a 'discretionary' security decision it
> is a security decisions that a process imposed upon itself.  Aka the
> choice to use seccomp is discretionary.  The choice to mark our own file
> u-wx is discretionary.  This isn't the best definition but it's one that
> works well in this discussion.  Mandatory security is one enforce by a
> global policy.  It's what selinux is all about.  SELinux doesn't give
> hoot what a process wants to do, it enforces a global policy from the
> top down.  You take over a process, well, too bad, you still have no
> choice but to follow the mandatory policy.
>
> The LSM does NOT enforce a mandatory access control model, it's just how
> it's been used in the past.  Ingo appears to me (please correct me if
> I'm wrong) to really be a fan of exposing the flexibility of the LSM to
> a discretionary access control model.  That doesn't seem like a bad
> idea.  And maybe using the filter engine to define the language to do
> this isn't a bad idea either.  But I think that's a 'down the road'
> project, not something to hold up a better seccomp.
>
>> Making it part of the LSM also avoids having to add this prctl().
>
> Well, it would mean exposing some new language construct to every LSM
> (instead of a single prctl construct) and it would mean anyone wanting
> to use the interface would have to rely on the LSM implementing those
> hooks the way they need it.  Honestly chrome can already get all of the
> benefits of this patch (given a perfectly coded kernel) and a whole lot
> more using SELinux, but (surprise surprise) not everyone uses SELinux.
> I think it's a good idea to expose a simple interface which will be
> widely enough adopted that many userspace applications can rely on it
> for hardening.
>
> The existence of the LSM and the fact that there exists multiple
> security modules that may or may not be enabled really leads application
> developers to be unable to rely on LSM for security.  If linux had a
> single security model which everyone could rely on we wouldn't really
> have as big of an issue but that's not possible.  So I'm advocating for
> this series which will provide a single useful change which applications
> can rely upon across distros and platforms to enhance the properties and
> abilities of the linux kernel.
>
> -Eric
>
>
