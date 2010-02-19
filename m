Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 03:03:30 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11250 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492183Ab0BSCDW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 03:03:22 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7df1710002>; Thu, 18 Feb 2010 18:03:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 18:02:19 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 18:02:19 -0800
Message-ID: <4B7DF12B.6090802@caviumnetworks.com>
Date:   Thu, 18 Feb 2010 18:02:19 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS vdso and signal delivery optimization (v2)
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Feb 2010 02:02:19.0504 (UTC) FILETIME=[915B2F00:01CAB107]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Well this patch set does cause gdb to no longer be able to generate 
stack traces from signal handlers, but that just means gdb needs to be 
fixed.  We will work on that next.

libgcc can unwind through signal handlers both with and without the patch.

David Daney


On 02/18/2010 04:13 PM, David Daney wrote:
> This patch set creates a vdso and moves the signal
> trampolines to it from their previous home on the stack.
>
> In the original patch set:
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=49EE3B0F.3040506%40caviumnetworks.com
>
> I stated:
>
> Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
> following results from lmbench2:
>
> Before:
> n64 - Signal handler overhead: 14.517 microseconds
> n32 - Signal handler overhead: 14.497 microseconds
> o32 - Signal handler overhead: 16.637 microseconds
>
> After:
>
> n64 - Signal handler overhead: 7.935 microseconds
> n32 - Signal handler overhead: 7.334 microseconds
> o32 - Signal handler overhead: 8.628 microsecond
>
> All that is still true.
>
> Improvements from the first version:
>
> * Compiles and runs in 32-bit kernels (on qemu at least).
>
> * Updated for linux-queue based 2.6.33-rc8
>
> David Daney (3):
>    MIPS: Add SYSCALL to uasm.
>    MIPS: Preliminary vdso.
>    MIPS: Move signal trampolines off of the stack.
>
>   arch/mips/include/asm/abi.h         |    6 +-
>   arch/mips/include/asm/elf.h         |    4 +
>   arch/mips/include/asm/mmu.h         |    5 +-
>   arch/mips/include/asm/mmu_context.h |    2 +-
>   arch/mips/include/asm/processor.h   |   11 +++-
>   arch/mips/include/asm/uasm.h        |    1 +
>   arch/mips/include/asm/vdso.h        |   29 +++++++++
>   arch/mips/kernel/Makefile           |    2 +-
>   arch/mips/kernel/signal-common.h    |    5 --
>   arch/mips/kernel/signal.c           |   86 ++++++---------------------
>   arch/mips/kernel/signal32.c         |   55 ++++-------------
>   arch/mips/kernel/signal_n32.c       |   26 ++------
>   arch/mips/kernel/syscall.c          |    6 ++-
>   arch/mips/kernel/vdso.c             |  112 +++++++++++++++++++++++++++++++++++
>   arch/mips/mm/uasm.c                 |   19 +++++-
>   15 files changed, 226 insertions(+), 143 deletions(-)
>   create mode 100644 arch/mips/include/asm/vdso.h
>   create mode 100644 arch/mips/kernel/vdso.c
>
>
