Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2011 01:59:59 +0200 (CEST)
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:28482 "EHLO
        mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903608Ab1J0X7u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2011 01:59:50 +0200
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1319759989; l=2103;
        s=domk; d=haible.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:
        References:Cc:Date:Subject:To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
        bh=h3BaJbNyPHFjAtbe+PrYgfkpT44=;
        b=kqYnbhmdChMw3FlePhy2zGZw81R62MFzWPHJ7cMlF3q3S7gN8cQB0hEf+wzIGeIgg/J
        j3S1OSf/dnFO8bFbj1Vx0CnUcXqLjgU1NKanqW4D0LKOCbtNyKQGL67e+UlJVXVbKTJkP
        1V9DjIrszt1QgGDsEhaoyr8VKYJZPRNsbuc=
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRb/444HDCpg==
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
        (dslb-088-068-068-248.pools.arcor-ip.net [88.68.68.248])
        by post.strato.de (mrclete mo35) (RZmta 26.10 AUTH)
        with ESMTPA id a017e3n9RN01HY ; Fri, 28 Oct 2011 01:59:42 +0200 (MEST)
From:   Bruno Haible <bruno@clisp.org>
To:     David Daney <david.daney@cavium.com>
Subject: Re: bug in fchownat in n32 and 64 ABIs
Date:   Fri, 28 Oct 2011 01:59:41 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.37.6-0.5-desktop; KDE/4.6.0; x86_64; ; )
Cc:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <201110272107.38510.bruno@clisp.org> <4EA9B072.5000107@cavium.com>
In-Reply-To: <4EA9B072.5000107@cavium.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <201110280159.41533.bruno@clisp.org>
X-archive-position: 31317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno@clisp.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20125

David Daney wrote:
> > 'strace' of this program shows that the system call that returns with -1/EPERM
> > is a call to SYS_6254 (in n32 ABI) or SYS_5250 (in 64 ABI).
> >
> Can you get strace -- version 4.5.20 or later and build it for the 
> corresponding ABI?  That should properly decode the relevant syscalls.

Version 4.6, built with "gcc -m64", compared to version 4.5.17:


For the program in ABI 64:

strace 4.5.17 reports
SYS_5250()                              = -1 EPERM (Operation not permitted)

strace 4.6 reports nothing, it stopped the log after it saw an exit() call:
getsockopt(1099511620912, 0xfffff820 /* SOL_??? */, 1099511625776, 0, 0x5555748ed0) = 0
svr4_syscall()                          = 5012
exit(1099511623472)                     = ?
fchownat: Operation not permitted
fchownat: Operation not permitted
fchownat: Operation not permitted


For the program in ABI n32:

strace 4.5.17 reports
SYS_6254()                              = -1 EPERM (Operation not permitted)

strace 4.6 reports
n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0xffffffff) = -1 EPERM (Operation not permitted)
n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0x4f0) = -1 EPERM (Operation not permitted)
n32_inotify_add_watch(0xffffffffffffff9c, 0x10000a30, 0xffffffff) = -1 EPERM (Operation not permitted)


For the program in ABI 32:

strace 4.5.17 reports
fchownat(AT_FDCWD, "foo.c", -1, 1264, 0) = 0
fchownat(AT_FDCWD, "foo.c", 1264, -1, 0) = 0
fchownat(AT_FDCWD, "foo.c", -1, -1, 0)  = 0

strace 4.6 reports
o32_fchownat(0xffffffffffffff9c, 0x400b00, 0xffffffffffffffff, 0x4f0, 0) = 0
o32_fchownat(0xffffffffffffff9c, 0x400b00, 0x4f0, 0xffffffffffffffff, 0) = 0
o32_fchownat(0xffffffffffffff9c, 0x400b00, 0xffffffffffffffff, 0xffffffffffffffff, 0) = 0


These traces reveal that
  - in ABI 32 (the case that works) the value (uid_t)-1 is being passed
    to the kernel as 0xffffffffffffffff,
  - in ABI n32 (the case that fails) the value (uid_t)-1 is being passed
    to the kernel as 0x00000000ffffffff.

Note that 'uid_t' is 'unsigned int' in userland.

Bruno
-- 
In memoriam Helmuth Hübener <http://en.wikipedia.org/wiki/Helmuth_Hübener>
