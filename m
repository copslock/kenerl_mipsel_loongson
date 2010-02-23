Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 22:28:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7848 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492399Ab0BWV14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 22:27:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8448630000>; Tue, 23 Feb 2010 13:28:03 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Feb 2010 13:27:51 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Feb 2010 13:27:51 -0800
Message-ID: <4B844852.6020301@caviumnetworks.com>
Date:   Tue, 23 Feb 2010 13:27:46 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Preliminary vdso.
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>        <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com> <f861ec6f1002231240l40e1b07di6e751e40a2caa110@mail.gmail.com>
In-Reply-To: <f861ec6f1002231240l40e1b07di6e751e40a2caa110@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2010 21:27:51.0757 (UTC) FILETIME=[0DE127D0:01CAB4CF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/23/2010 12:40 PM, Manuel Lauss wrote:
> Hi David,
>
> On Fri, Feb 19, 2010 at 1:13 AM, David Daney<ddaney@caviumnetworks.com>  wrote:
>> This is a preliminary patch to add a vdso to all user processes.
>> Still missing are ELF headers and .eh_frame information.  But it is
>> enough to allow us to move signal trampolines off of the stack.  Note
>> that emulation of branch delay slots in the FPU emulator still
>> requires the stack.
>>
>> We allocate a single page (the vdso) and write all possible signal
>> trampolines into it.  The stack is moved down by one page and the vdso
>> is mapped into this space.
>
> Is there anything special required (i.e. special glibc, ..) to make use of these
> fine patches?
>

No.  Quite the opposite really, they are designed for the most part to 
be transparent to userspace.

There are a couple of changes that shouldn't break anything serious:

1) The  process' VMA will have a [vdso] region at the highest possible 
address (above the stack).  Most code will not care about this.  However 
if you mprotect(PROT_WRITE) the region and then clobber it or munmap it, 
you will likely lose the ability to return from signal handlers.  It is 
copy-on-write, so this will not affect other processes.

2) The libgcc built by some older versions of GCC will not be able throw 
exceptions across a signal frame.  This is mostly a problem if you are 
using libgcj (the GCC java runtime).  Note however that the faulty 
versions of libgcc would also fail on kernels that need 
ICACHE_REFILLS_WORKAROUND_WAR (SGI O2).  Most code doesn't try to throw 
exceptions across signal frames, so it would be unaffected.  Also note 
that really old versions of libgcc don't support this trans-signal-frame 
throwing at all.

3) GDB will not show a valid backtrace from a signal handler.  I have 
submitted a gdb patch, but it has not been accepted yet.

David Daney
