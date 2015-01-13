Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 01:32:26 +0100 (CET)
Received: from mail-yk0-f178.google.com ([209.85.160.178]:47877 "EHLO
        mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006211AbbAMAcYrAyAN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 01:32:24 +0100
Received: by mail-yk0-f178.google.com with SMTP id 20so30660yks.9
        for <linux-mips@linux-mips.org>; Mon, 12 Jan 2015 16:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=MlFld0hiD40VOE2zx58icpXoruAVniHmZRLiIoc6V9A=;
        b=gWOMaxuAGDMaLu+gxuMEblRLXwdxUR9oJ8ir/DVe2DXqmAJkCOqwYWpzawOzyYpyRT
         27Lxukmh3axiYsLVyQjqC7VUnxKglyD6nGrG8kjxSl27KwikxHM6zkzMm74AEai078Ab
         sCAzPFLkRQhkxyXDW+9uw5HFlMXjsfzdpNSFPoS/1RLjZVxcp9THG3VwJxnaXkoLmKeA
         B55wzwWzC9M2bVl6wGM7gUE2kxqY/OmCJH50cTU5U4dwZROmVYTJoo1BrulpVuji2gkx
         ZDhahPTmA1a41jf5gFgA2iGNyncoZg6hX54t20ZuWvqQzgvgV21gxJ1VXExFxtn0VhLP
         INBQ==
X-Gm-Message-State: ALoCoQk3bL9TeHd1nDJ34dG2Pvjx8py3YJFlkM3rl0xy3gcUaCaVc2AgnxtmxRy8QtYHrSdoUaTf
X-Received: by 10.236.46.49 with SMTP id q37mr24863008yhb.176.1421109138435;
 Mon, 12 Jan 2015 16:32:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.170.42.11 with HTTP; Mon, 12 Jan 2015 16:31:38 -0800 (PST)
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Mon, 12 Jan 2015 16:31:38 -0800
Message-ID: <CAO_EM_mMj1bs4jy3H3bftT94LxcDTue25Hfc_iWO3h-CFJj39w@mail.gmail.com>
Subject: Indirect syscall restarted incorrectly after signal
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45093
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

I'm trying to track down a strange problem affecting an O32 userspace
program on an N64 MIPS kernel. I'm using a 64-bit kernel from Cavium
that's nominally 3.10.20 but has an assortment of patches, including
rt and grsec and various Cavium stuff. My glibc is stock 2.19-13 from
Debian.

The program is written in Go and compiled with gccgo from gcc 4.9.2.
It is using the exec.Command API which is a Go wrapper for fork(),
exec(), wait() and friends. The runtime library (libgo) was changed
sometime before 4.9.2 to call clone() rather than fork() (see
http://patchwork.ozlabs.org/patch/386411/). Presumably for expediency,
the library invokes clone() indirectly via syscall(). Complicating
matters, the clone() calls are invoked from different threads, so the
program also has to deal with handling SIGCHLD whenever one of its
child processes exits.

Most of the time, the indirect clone() call works just fine.
Occasionally, however, the clone() gets interrupted by a signal. When
the signal handler returns, the kernel tries to restart the clone()
syscall by rolling back the program counter and various registers, and
jumping back into userspace at the point the syscall was first
originally called.

Running my program under strace looks like this (minus noise from
other processes/threads):

2530  syscall(0x1018, 0x12, 0, 0, 0, 0, 0 <unfinished ...>
2532  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3113,
si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
2530  <... syscall resumed> )           = ? ERESTARTNOINTR (To be restarted)
2530  syscall(0x12, 0, 0, 0, 0, 0, 0)   = -1 ENOSYS (Function not implemented)
2532  rt_sigreturn( <unfinished ...>
2532  <... rt_sigreturn resumed> )      = 2

syscall(0x1018) (where 0x1018 is the syscall number for clone on
32-bit MIPS) first returns ERESTARTNOINTR (as expected, this never
actually propagates back to userspace). But the next attempt uses
syscall number 0x22, which returns ENOSYS because there's no such
syscall.

I assume it is no coincidence that 0x12 is the first argument to the
original syscall.

For comparison, when I compile my program against the original libgo
which calls fork() and run it under strace I see the following:

16791 clone( <unfinished ...>
16792 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=17006,
si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
16792 rt_sigreturn( <unfinished ...>
16791 <... clone resumed> child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x3bc843c8) = ? ERESTARTNOINTR (To be restarted)
16792 <... rt_sigreturn resumed> )      = 0
16791 clone( <unfinished ...>
16791 <... clone resumed> child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x3bc843c8) = 17008

Note that the second call to clone() has exactly the same arguments as
the first one, and returns the new PID as expected.

I spent quite some time digging into the syscall code in the kernel
and glibc, but couldn't figure out who is supposed to shift arguments
and push some of them to the stack and others to registers, and so on.

I tried the same experiment with a 64-bit little-endian userspace from
the Debian mips64el repository and a gcc 4.9.2 toolchain targeting
mips64el. The program works fine. So the problem appears limited to
O32 userspace on N64 kernel (not clear whether endianness is an
issue).

I can prepare a self-contained test case, but thought I'd first ask if
this symptom rings a bell with anyone on the list.

--Ed
