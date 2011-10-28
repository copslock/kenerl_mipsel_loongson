Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2011 02:26:53 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17335 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab1J1A0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2011 02:26:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ea9f7160000>; Thu, 27 Oct 2011 17:28:06 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 17:26:45 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 17:26:45 -0700
Message-ID: <4EA9F6C4.9010804@cavium.com>
Date:   Thu, 27 Oct 2011 17:26:44 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Bruno Haible <bruno@clisp.org>
CC:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: bug in fchownat in n32 and 64 ABIs
References: <201110272107.38510.bruno@clisp.org> <4EA9B072.5000107@cavium.com> <201110280159.41533.bruno@clisp.org>
In-Reply-To: <201110280159.41533.bruno@clisp.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2011 00:26:45.0239 (UTC) FILETIME=[45EDC870:01CC9508]
X-archive-position: 31318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20139

On 10/27/2011 04:59 PM, Bruno Haible wrote:
> David Daney wrote:
>>> 'strace' of this program shows that the system call that returns with -1/EPERM
>>> is a call to SYS_6254 (in n32 ABI) or SYS_5250 (in 64 ABI).
>>>
>> Can you get strace -- version 4.5.20 or later and build it for the
>> corresponding ABI?  That should properly decode the relevant syscalls.
>
> Version 4.6, built with "gcc -m64", compared to version 4.5.17:
>
>
> For the program in ABI 64:
>
> strace 4.5.17 reports
> SYS_5250()                              = -1 EPERM (Operation not permitted)
>
> strace 4.6 reports nothing, it stopped the log after it saw an exit() call:
> getsockopt(1099511620912, 0xfffff820 /* SOL_??? */, 1099511625776, 0, 0x5555748ed0) = 0
> svr4_syscall()                          = 5012
> exit(1099511623472)                     = ?
> fchownat: Operation not permitted
> fchownat: Operation not permitted
> fchownat: Operation not permitted
>
>
> For the program in ABI n32:
>
> strace 4.5.17 reports
> SYS_6254()                              = -1 EPERM (Operation not permitted)
>
> strace 4.6 reports
> n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0xffffffff) = -1 EPERM (Operation not permitted)
> n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0x4f0) = -1 EPERM (Operation not permitted)
> n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0xffffffff) = -1 EPERM (Operation not permitted)
>
>
> For the program in ABI 32:
>
> strace 4.5.17 reports
> fchownat(AT_FDCWD, "foo.c", -1, 1264, 0) = 0
> fchownat(AT_FDCWD, "foo.c", 1264, -1, 0) = 0
> fchownat(AT_FDCWD, "foo.c", -1, -1, 0)  = 0
>
> strace 4.6 reports
> o32_fchownat(0xffffffffffffff9c, 0x400b00, 0xffffffffffffffff, 0x4f0, 0) = 0
> o32_fchownat(0xffffffffffffff9c, 0x400b00, 0x4f0, 0xffffffffffffffff, 0) = 0
> o32_fchownat(0xffffffffffffff9c, 0x400b00, 0xffffffffffffffff, 0xffffffffffffffff, 0) = 0
>
>
> These traces reveal that
>    - in ABI 32 (the case that works) the value (uid_t)-1 is being passed
>      to the kernel as 0xffffffffffffffff,
>    - in ABI n32 (the case that fails) the value (uid_t)-1 is being passed
>      to the kernel as 0x00000000ffffffff.
>
> Note that 'uid_t' is 'unsigned int' in userland.
>

Your test program works find for me under both n32 and n64 ABIs, so I 
think you must have either an obsolete kernel or obsolete glibc (or 
perhaps both).  Perhaps you should consider upgrading your system.

David Daney
