Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 06:12:16 +0100 (CET)
Received: from mail-yk0-f181.google.com ([209.85.160.181]:59446 "EHLO
        mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbAMFMOfChEu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 06:12:14 +0100
Received: by mail-yk0-f181.google.com with SMTP id 142so467685ykq.12
        for <linux-mips@linux-mips.org>; Mon, 12 Jan 2015 21:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=ab8oeJfRQ7+X10b8jkHGM1YoLrKwi4q7pJl+ij5h1jQ=;
        b=VO+4dbOJE1izEaTXejOHvkqiFqhC+isiZ+96/BlJSekU6lrax/oAqlBH8CqtxZk+de
         VNqAJJ5yQus6Lq6II8pHVVtJzbZKZo+aTxG4SJh1rZPGzEMTdB7qqYYdVo3Oqy/1EIpK
         G2Je7ZOm96nSoZ+pI5kkZSbXGcj2cbCyNp0tW6B40+KrmieJgZyt+Ghql3+s6rJIoaO+
         2C+N5/1tN8gKvxpbIzkZpnwIe2cHaVocUSFSBtE/yzzYI6f/A8o8ONwFqtZOA0uKg1cR
         aPb6Cse21V/Phgqw1fpiNxNX1FnnDXmyR8IxOU4DZG9kR5HJtvVdY5C9/MDmYAqoB2z3
         efvA==
X-Gm-Message-State: ALoCoQlSdFl/MpIZz8enRpXs8+kgipZs9xmv9l3vj0wZJTME8FLPyQOK45XtG0BFH7zpUbM/wTqI
X-Received: by 10.170.128.73 with SMTP id u70mr29340076ykb.19.1421125928960;
 Mon, 12 Jan 2015 21:12:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.170.42.11 with HTTP; Mon, 12 Jan 2015 21:11:28 -0800 (PST)
In-Reply-To: <CAO_EM_mMj1bs4jy3H3bftT94LxcDTue25Hfc_iWO3h-CFJj39w@mail.gmail.com>
References: <CAO_EM_mMj1bs4jy3H3bftT94LxcDTue25Hfc_iWO3h-CFJj39w@mail.gmail.com>
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Mon, 12 Jan 2015 21:11:28 -0800
Message-ID: <CAO_EM_nzg2=MJee3TVPw-m4wUBJF=YK3=zXkO3CLwuTBeQ-xKg@mail.gmail.com>
Subject: Re: Indirect syscall restarted incorrectly after signal
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

With the help of this very informative Syscall wiki page
(http://www.linux-mips.org/wiki/Syscall) I figured out how syscalls
are supposed to work, and what's missing in the indirect syscall
restart case.

I modified the indirect syscall code to store the number before
shifting the arguments, so the syscall gets invoked directly when
restarted. Now the indirect clone() call works correctly:

2507  syscall(0x1018, 0x12, 0, 0, 0, 0, 0 <unfinished ...>
2177  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=2718,
si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
2177  rt_sigreturn( <unfinished ...>
2177  <... rt_sigreturn resumed> )      = 0
2507  <... syscall resumed> )           = ? ERESTARTNOINTR (To be restarted)
2507  clone( <unfinished ...>
2507  <... clone resumed> child_stack=0, flags=SIGCHLD) = 2721

As a bonus, the strace revealed other indirect syscalls that were
previously getting mangled during restart and are now working
correctly. Fortunately libgo was already prepared to deal with futex()
returning prematurely with a bogus errno
(https://github.com/gcc-mirror/gcc/blob/master/libgo/runtime/thread-linux.c#L47).

--Ed


On Mon, Jan 12, 2015 at 4:31 PM, Ed Swierk <eswierk@skyportsystems.com> wrote:
> I'm trying to track down a strange problem affecting an O32 userspace
> program on an N64 MIPS kernel. I'm using a 64-bit kernel from Cavium
> that's nominally 3.10.20 but has an assortment of patches, including
> rt and grsec and various Cavium stuff. My glibc is stock 2.19-13 from
> Debian.
>
> The program is written in Go and compiled with gccgo from gcc 4.9.2.
> It is using the exec.Command API which is a Go wrapper for fork(),
> exec(), wait() and friends. The runtime library (libgo) was changed
> sometime before 4.9.2 to call clone() rather than fork() (see
> http://patchwork.ozlabs.org/patch/386411/). Presumably for expediency,
> the library invokes clone() indirectly via syscall(). Complicating
> matters, the clone() calls are invoked from different threads, so the
> program also has to deal with handling SIGCHLD whenever one of its
> child processes exits.
>
> Most of the time, the indirect clone() call works just fine.
> Occasionally, however, the clone() gets interrupted by a signal. When
> the signal handler returns, the kernel tries to restart the clone()
> syscall by rolling back the program counter and various registers, and
> jumping back into userspace at the point the syscall was first
> originally called.
>
> Running my program under strace looks like this (minus noise from
> other processes/threads):
>
> 2530  syscall(0x1018, 0x12, 0, 0, 0, 0, 0 <unfinished ...>
> 2532  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3113,
> si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
> 2530  <... syscall resumed> )           = ? ERESTARTNOINTR (To be restarted)
> 2530  syscall(0x12, 0, 0, 0, 0, 0, 0)   = -1 ENOSYS (Function not implemented)
> 2532  rt_sigreturn( <unfinished ...>
> 2532  <... rt_sigreturn resumed> )      = 2
>
> syscall(0x1018) (where 0x1018 is the syscall number for clone on
> 32-bit MIPS) first returns ERESTARTNOINTR (as expected, this never
> actually propagates back to userspace). But the next attempt uses
> syscall number 0x22, which returns ENOSYS because there's no such
> syscall.
>
> I assume it is no coincidence that 0x12 is the first argument to the
> original syscall.
>
> For comparison, when I compile my program against the original libgo
> which calls fork() and run it under strace I see the following:
>
> 16791 clone( <unfinished ...>
> 16792 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=17006,
> si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
> 16792 rt_sigreturn( <unfinished ...>
> 16791 <... clone resumed> child_stack=0,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x3bc843c8) = ? ERESTARTNOINTR (To be restarted)
> 16792 <... rt_sigreturn resumed> )      = 0
> 16791 clone( <unfinished ...>
> 16791 <... clone resumed> child_stack=0,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x3bc843c8) = 17008
>
> Note that the second call to clone() has exactly the same arguments as
> the first one, and returns the new PID as expected.
>
> I spent quite some time digging into the syscall code in the kernel
> and glibc, but couldn't figure out who is supposed to shift arguments
> and push some of them to the stack and others to registers, and so on.
>
> I tried the same experiment with a 64-bit little-endian userspace from
> the Debian mips64el repository and a gcc 4.9.2 toolchain targeting
> mips64el. The program works fine. So the problem appears limited to
> O32 userspace on N64 kernel (not clear whether endianness is an
> issue).
>
> I can prepare a self-contained test case, but thought I'd first ask if
> this symptom rings a bell with anyone on the list.
>
> --Ed
