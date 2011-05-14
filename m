Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 22:58:39 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:59215 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1ENU6I convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 May 2011 22:58:08 +0200
Received: by fxm14 with SMTP id 14so3198887fxm.36
        for <multiple recipients>; Sat, 14 May 2011 13:58:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.134.75 with SMTP id i11mr1640157fat.39.1305406681117; Sat,
 14 May 2011 13:58:01 -0700 (PDT)
Received: by 10.223.101.204 with HTTP; Sat, 14 May 2011 13:58:00 -0700 (PDT)
In-Reply-To: <201105132135.34741.arnd@arndb.de>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
        <1305169376-2363-1-git-send-email-wad@chromium.org>
        <201105132135.34741.arnd@arndb.de>
Date:   Sat, 14 May 2011 15:58:00 -0500
Message-ID: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
From:   Will Drewry <wad@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
        jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@elte.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        microblaze-uclinux@itee.uq.edu.au,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
        Roland McGrath <roland@redhat.com>,
        Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
        linuxppc-dev@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        agl@chromium.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wad@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 2:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 May 2011, Will Drewry wrote:
>> This change adds a new seccomp mode based on the work by
>> agl@chromium.org in [1]. This new mode, "filter mode", provides a hash
>> table of seccomp_filter objects.  When in the new mode (2), all system
>> calls are checked against the filters - first by system call number,
>> then by a filter string.  If an entry exists for a given system call and
>> all filter predicates evaluate to true, then the task may proceed.
>> Otherwise, the task is killed (as per seccomp_mode == 1).
>
> I've got a question about this: Do you expect the typical usage to disallow
> ioctl()? Given that ioctl alone is responsible for a huge number of exploits
> in various drivers, while certain ioctls are immensely useful (FIONREAD,
> FIOASYNC, ...), do you expect to extend the mechanism to filter specific
> ioctl commands in the future?

In many cases, I do expect ioctl's to be dropped, but it's totally up
to whoever is setting the filters.

As is, it can already help out: [even though an LSM, if available,
would be appropriate to define a fine-grained policy]

ioctl() is hooked by the ftrace syscalls infrastructure (via SYSCALL_DEFINE3):

  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned
long, arg)

This means you can do:
  sprintf(filter, "cmd == %u || cmd == %u", FIOASYNC, FIONREAD);
  prctl(PR_SET_SECCOMP_FILTER, __NR_ioctl, filter);
  ...
  prctl(PR_SET_SECCOMP, 2, 0);
and then you'll be able to call ioctl on any fd with any argument but
limited to only the FIOASYNC and FIONREAD commands.

Depending on integration, it could even be limited to ioctl commands
that are appropriate to a known fd if the fd is opened prior to
entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
with a filter of "1" then narrowed through a later addition of
something like "(fd == %u && (cmd == %u || cmd == %u))" or something
along those lines.

Does that make sense?

In general, this interface won't need specific extensions for most
system call oriented filtering events.  ftrace events may be expanded
(to include more system calls), but that's behind the scenes.  Only
arguments subject to time-of-check-time-of-use attacks (data living in
userspace passed in by pointer) are not safe to use via this
interface.  In theory, that limitation could also be lifted in the
implementation without changing the ABI.

Thanks!
will
