Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 01:41:57 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34941 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006211AbbAMAl4WRlWy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 01:41:56 +0100
Received: by mail-ie0-f173.google.com with SMTP id y20so115404ier.4
        for <linux-mips@linux-mips.org>; Mon, 12 Jan 2015 16:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oT+sAghXyP74mGXJy7EHTXdeS4/6QtxRaYpUAc2jJCw=;
        b=KT5rp1wUi4r2JdUBAoHcXp9E8dpsXIk+07Ln+EB0XnFz5VO9qRBc8HjZ8kTqkoR0ph
         8PIXrCdDpDP4MLzZb+zZ4fb5r+ce7YClY8QxWDkdQX438wnoBhIIROQAY9/X7GT7nuos
         yaW3N8M2+ticdxfdKesws4GCaeGj2pikv3ky/V+GOfZhV5dkfheybo5vE4PgiZ/s6MTy
         Eyx+iewKMu5cwUE/XWadZWNRqbjNf9tnrDfuQzKjosW4P/g92abU8mCYuL2TdU8t1qZC
         fIok0iVgB000KsidiYM4C6Lmx/ND1BMvkUtnuBZrskmA/OGVI+ucRkuniQ5yw5Jk5smM
         HkDg==
X-Received: by 10.42.235.80 with SMTP id kf16mr26580236icb.77.1421109710242;
        Mon, 12 Jan 2015 16:41:50 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id e33sm9410223ioi.9.2015.01.12.16.41.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 12 Jan 2015 16:41:49 -0800 (PST)
Message-ID: <54B469CC.2030601@gmail.com>
Date:   Mon, 12 Jan 2015 16:41:48 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ed Swierk <eswierk@skyportsystems.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Indirect syscall restarted incorrectly after signal
References: <CAO_EM_mMj1bs4jy3H3bftT94LxcDTue25Hfc_iWO3h-CFJj39w@mail.gmail.com>
In-Reply-To: <CAO_EM_mMj1bs4jy3H3bftT94LxcDTue25Hfc_iWO3h-CFJj39w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/12/2015 04:31 PM, Ed Swierk wrote:
> I'm trying to track down a strange problem affecting an O32 userspace
> program on an N64 MIPS kernel. I'm using a 64-bit kernel from Cavium
> that's nominally 3.10.20 but has an assortment of patches, including
> rt and grsec and various Cavium stuff.

If you have all that stuff, you should also have access to the OCTEON 
simulator, that can produce an instruction trace...

If you can create a testcase that fails within fewer than 10^9 
instructions on the simulator (on say fewer than 4 CPUs), then it would 
be child's play to find the problem...

David Daney

> My glibc is stock 2.19-13 from
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
>
>
>
