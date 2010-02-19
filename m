Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 23:09:09 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7506 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491925Ab0BSWJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 23:09:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7f0c050000>; Fri, 19 Feb 2010 14:09:09 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 19 Feb 2010 14:08:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 19 Feb 2010 14:08:22 -0800
Message-ID: <4B7F0BD4.3070909@caviumnetworks.com>
Date:   Fri, 19 Feb 2010 14:08:20 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS vdso and signal delivery optimization (v2)
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com> <4B7DF12B.6090802@caviumnetworks.com>
In-Reply-To: <4B7DF12B.6090802@caviumnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------070502040600090805080501"
X-OriginalArrivalTime: 19 Feb 2010 22:08:22.0509 (UTC) FILETIME=[0D1179D0:01CAB1B0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070502040600090805080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/18/2010 06:02 PM, David Daney wrote:
> Well this patch set does cause gdb to no longer be able to generate
> stack traces from signal handlers, but that just means gdb needs to be
> fixed. We will work on that next.

Attached is the corresponding gdb patch.  I will push it into the 
upstream gdb.

David Daney


>
> libgcc can unwind through signal handlers both with and without the patch.
>
> David Daney
>
>
> On 02/18/2010 04:13 PM, David Daney wrote:
>> This patch set creates a vdso and moves the signal
>> trampolines to it from their previous home on the stack.
>>
>> In the original patch set:
>> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=49EE3B0F.3040506%40caviumnetworks.com
>>
>>
>> I stated:
>>
>> Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
>> following results from lmbench2:
>>
>> Before:
>> n64 - Signal handler overhead: 14.517 microseconds
>> n32 - Signal handler overhead: 14.497 microseconds
>> o32 - Signal handler overhead: 16.637 microseconds
>>
>> After:
>>
>> n64 - Signal handler overhead: 7.935 microseconds
>> n32 - Signal handler overhead: 7.334 microseconds
>> o32 - Signal handler overhead: 8.628 microsecond
>>
>> All that is still true.
>>
>> Improvements from the first version:
>>
>> * Compiles and runs in 32-bit kernels (on qemu at least).
>>
>> * Updated for linux-queue based 2.6.33-rc8
>>
>> David Daney (3):
>> MIPS: Add SYSCALL to uasm.
>> MIPS: Preliminary vdso.
>> MIPS: Move signal trampolines off of the stack.
>>
>> arch/mips/include/asm/abi.h | 6 +-
>> arch/mips/include/asm/elf.h | 4 +
>> arch/mips/include/asm/mmu.h | 5 +-
>> arch/mips/include/asm/mmu_context.h | 2 +-
>> arch/mips/include/asm/processor.h | 11 +++-
>> arch/mips/include/asm/uasm.h | 1 +
>> arch/mips/include/asm/vdso.h | 29 +++++++++
>> arch/mips/kernel/Makefile | 2 +-
>> arch/mips/kernel/signal-common.h | 5 --
>> arch/mips/kernel/signal.c | 86 ++++++---------------------
>> arch/mips/kernel/signal32.c | 55 ++++-------------
>> arch/mips/kernel/signal_n32.c | 26 ++------
>> arch/mips/kernel/syscall.c | 6 ++-
>> arch/mips/kernel/vdso.c | 112 +++++++++++++++++++++++++++++++++++
>> arch/mips/mm/uasm.c | 19 +++++-
>> 15 files changed, 226 insertions(+), 143 deletions(-)
>> create mode 100644 arch/mips/include/asm/vdso.h
>> create mode 100644 arch/mips/kernel/vdso.c
>>
>>
>
>


--------------070502040600090805080501
Content-Type: text/plain;
 name="gdb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gdb.patch"

Index: gdb/mips-linux-tdep.c
===================================================================
RCS file: /cvs/src/src/gdb/mips-linux-tdep.c,v
retrieving revision 1.81
diff -u -p -r1.81 mips-linux-tdep.c
--- gdb/mips-linux-tdep.c	1 Jan 2010 07:31:37 -0000	1.81
+++ gdb/mips-linux-tdep.c	19 Feb 2010 21:58:32 -0000
@@ -797,7 +797,7 @@ static const struct tramp_frame mips_lin
 
    struct sigframe {
      u32 sf_ass[4];            [argument save space for o32]
-     u32 sf_code[2];           [signal trampoline]
+     u32 sf_code[2];           [signal trampoline or fill]
      struct sigcontext sf_sc;
      sigset_t sf_mask;
    };
@@ -827,7 +827,7 @@ static const struct tramp_frame mips_lin
 
    struct rt_sigframe {
      u32 rs_ass[4];            [argument save space for o32]
-     u32 rs_code[2]            [signal trampoline]
+     u32 rs_code[2]            [signal trampoline or fill]
      struct siginfo rs_info;
      struct ucontext rs_uc;
    };
@@ -871,7 +871,7 @@ mips_linux_o32_sigframe_init (const stru
 {
   struct gdbarch *gdbarch = get_frame_arch (this_frame);
   int ireg, reg_position;
-  CORE_ADDR sigcontext_base = func - SIGFRAME_CODE_OFFSET;
+  CORE_ADDR sigcontext_base = get_frame_sp (this_frame);
   const struct mips_regnum *regs = mips_regnum (gdbarch);
   CORE_ADDR regs_base;
 
@@ -1038,7 +1038,7 @@ mips_linux_n32n64_sigframe_init (const s
 {
   struct gdbarch *gdbarch = get_frame_arch (this_frame);
   int ireg, reg_position;
-  CORE_ADDR sigcontext_base = func - SIGFRAME_CODE_OFFSET;
+  CORE_ADDR sigcontext_base =  get_frame_sp (this_frame);
   const struct mips_regnum *regs = mips_regnum (gdbarch);
 
   if (self == &mips_linux_n32_rt_sigframe)

--------------070502040600090805080501--
