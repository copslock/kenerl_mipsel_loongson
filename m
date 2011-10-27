Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 21:26:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6567 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab1J0T0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2011 21:26:44 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ea9b0c30000>; Thu, 27 Oct 2011 12:28:03 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 12:26:42 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 12:26:42 -0700
Message-ID: <4EA9B072.5000107@cavium.com>
Date:   Thu, 27 Oct 2011 12:26:42 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Bruno Haible <bruno@clisp.org>
CC:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: bug in fchownat in n32 and 64 ABIs
References: <201110272107.38510.bruno@clisp.org>
In-Reply-To: <201110272107.38510.bruno@clisp.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2011 19:26:42.0526 (UTC) FILETIME=[5B79C7E0:01CC94DE]
X-archive-position: 31314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19913

On 10/27/2011 12:07 PM, Bruno Haible wrote:
> Hi Linux/MIPS folks,
>
> Found this bug by running the gnulib POSIX test suite: In the fchownat()
> call, an uid_t or gid_t of value (uid_t)-1 or (gid_t)-1 means no change.
> See<http://pubs.opengroup.org/onlinepubs/9699919799/functions/fchownat.html>.
> This value is correctly recognized on all Unices, _except_ Linux/MIPS
> in n32 and 64 ABIs.
>
[...]
> $ gcc -Wall -mabi=64 foo.c
> $ ./a.out ; echo $?
> fchownat: Operation not permitted
> fchownat: Operation not permitted
> fchownat: Operation not permitted
> 14
> $ gcc -Wall -mabi=n32 foo.c
> $ ./a.out ; echo $?
> fchownat: Operation not permitted
> fchownat: Operation not permitted
> fchownat: Operation not permitted
> 14
> $ gcc -Wall -mabi=32 foo.c
> $ ./a.out ; echo $?
>
> Other relevant data:
> - kernel version is 2.6.27.1
> - glibc version is 2.7
> - gcc version is 4.3.2 (Debian).

Debian doesn't support 64-bit ABIs, so this list is incomplete.  Where 
did you get your 64-bit libc ?

>
> 'strace' of this program shows that the system call that returns with -1/EPERM
> is a call to SYS_6254 (in n32 ABI) or SYS_5250 (in 64 ABI).
>
Can you get strace -- version 4.5.20 or later and build it for the 
corresponding ABI?  That should properly decode the relevant syscalls.

Once you have that, you might post the strace output.

In the mean time I might give it a try with my 2.9 glibc on a 2.6.32.27 
kernels.

David Daney
