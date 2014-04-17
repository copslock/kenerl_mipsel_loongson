Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 21:39:05 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:43222 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834698AbaDQTjCa1yV- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 21:39:02 +0200
Received: by mail-la0-f54.google.com with SMTP id mc6so758861lab.27
        for <linux-mips@linux-mips.org>; Thu, 17 Apr 2014 12:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YLvtjL+3UciaH9/XtTlVYUjOQM3flwfjnjd1ThaIqHM=;
        b=WUkitrOMzJnwsR4KuFv50BO0dQrBjUoqu+XI1AgJ0lgeh2YiZ5HaRZEfVleF3aP+EN
         1webKPKW/SqEdRPlAg7GSj4m12MKlYr5/R8/PewY40m+QkxaG/t5wHiUNe586PRmq0fQ
         O7nCmoJEe92eOwmQev3uShaKE8X88dcfIV7Wt2biR49QdMKNfxj8H4ZjHP7zGs/eDEsV
         MiVciTs0sMkUiIb7ltnbATfsOTCkYeCt+lXr+2wPycSNW6bbKdn900hefLi//JTEoKWO
         KD6Mt/orMMbZnmZaHoDyDhQdslRT6iqDtkClx3WfrVjgyLIiqBHoRjODNfRXWSaEkMmb
         0RQg==
X-Gm-Message-State: ALoCoQnE31CANE2WNQOQ8MxnnW+OjEK2xfkQzhwDLfiU8LG3WP5MIm5V0QD2KcMh2r21IkzQpNqP
X-Received: by 10.112.235.229 with SMTP id up5mr28027lbc.62.1397763536730;
 Thu, 17 Apr 2014 12:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.21.7 with HTTP; Thu, 17 Apr 2014 12:38:36 -0700 (PDT)
In-Reply-To: <20140417191359.GR11180@linux-mips.org>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com>
 <1397738551.2725.18.camel@localhost> <534FCF75.7060708@imgtec.com>
 <4648181.no7KCQCtEi@sifl> <534FFBCF.5010800@imgtec.com> <1397750939.750.1.camel@localhost>
 <CALCETrVdHuJ-uh1K=4RtVBwctsgU3Y4=6VyNvO_QeGrL21PkXw@mail.gmail.com>
 <5350002F.4080104@imgtec.com> <20140417191359.GR11180@linux-mips.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 17 Apr 2014 12:38:36 -0700
Message-ID: <CALCETrVTptDpPmC_aqL1T10Pm5tTMXJpBLK=osZmc5Vei0bMkA@mail.gmail.com>
Subject: Re: [libseccomp-discuss] [PATCH v3 0/2] Add support for MIPS BE/LE
 and O32 ABI
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Eric Paris <eparis@redhat.com>,
        libseccomp-discuss@lists.sourceforge.net, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Thu, Apr 17, 2014 at 12:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Apr 17, 2014 at 05:24:15PM +0100, Markos Chandras wrote:
>
>> On 04/17/2014 05:20 PM, Andy Lutomirski wrote:
>> >[cc's added]
>> >
>> >On Thu, Apr 17, 2014 at 9:08 AM, Eric Paris <eparis@redhat.com> wrote:
>> >>On Thu, 2014-04-17 at 17:05 +0100, Markos Chandras wrote:
>> >>>On 04/17/2014 04:38 PM, Paul Moore wrote:
>> >>>>>Similarly, for MIPS, restricting open() on all 3 ABIs means 3 filters.
>> >>>>>1) AUDIT_ARCH_MIPS(EL) syscall=4005
>> >>>>>2) AUDIT_ARCH_MIPS64(EL) syscall=5005 (n64)
>> >>>>>3) AUDIT_ARCH_MIPS64(EL) syscall=6005 (n32)
>> >>>>>
>> >>>>>Is this bad?
>> >>>>
>> >>>>In my seccomp-heavy opinion it isn't good, but we can work around it.  MIPS64
>> >>>>looks like x86_64/x32, which means we can't identify the ABI by the AUDIT_ARCH
>> >>>>token alone, we need to factor in the syscall number as well; this complicates
>> >>>>the filter generation as well as the filter itself.
>> >>>>
>> >>>>Take a look at the x86_64 BPF generated from the 01-sim-allow test.  You'll
>> >>>>notice that the test creates a seccomp filter without any rules, simply a
>> >>>>default action, yet if you look at the raw BPF below you will notice that we
>> >>>>are checking both the the architecture token ($data[4]) and the syscall
>> >>>>($data[0]).  Granted, this is a contrived example (look at the more complex
>> >>>>multi-arch examples to understand why this is important) but it is a simple
>> >>>>demonstration.
>> >>>>
>> >>>>   line  OP   JT   JF   K
>> >>>>=================================
>> >>>>   0000: 0x20 0x00 0x00 0x00000004   ld  $data[4]
>> >>>>   0001: 0x15 0x00 0x03 0xc000003e   jeq 3221225534 true:0002 false:0005
>> >>>>   0002: 0x20 0x00 0x00 0x00000000   ld  $data[0]
>> >>>>   0003: 0x35 0x01 0x00 0x40000000   jge 1073741824 true:0005 false:0004
>> >>>>   0004: 0x06 0x00 0x00 0x7fff0000   ret ALLOW
>> >>>>   0005: 0x06 0x00 0x00 0x00000000   ret KILL
>> >>>
>> >>>I see what you mean. That was very helpful
>> >>>
>> >>>>[.....]
>> >>>>>Even if seccomp could identify the ABI, you still need filters to restrict
>> >>>>>the actual system calls.
>> >>>>
>> >>>>Let me twist the phrasing above a bit ... The libseccomp library must be able
>> >>>>to identify the ABI and apply the correct ABI specific filter rules.
>> >>>>
>> >>>>>I am sorry if my replies make no sense, but it's probably because I
>> >>>>>don't understand why multiple filters (1 filter per ABI syscall) is not
>> >>>>>an option.
>> >>>>
>> >>>>It is more than an option, it is a requirement. :)
>> >>>
>> >>>I understand the problem now. So yeah, it's not a problem, it's more
>> >>>like a desired optimization to simplify the logic in filters as well as
>> >>>making them less complex. And it's not libseccomp specific.
>> >>>
>> >>>So, a quick patch to solve this in the kernel would be something like
>> >>>the following one (completely untested). Given this code hasn't been
>> >>>part of a released kernel, I believe there is time to add this to 3.15.
>> >>>Would something like this make things simpler?
>> >>>
>> >>>diff --git a/arch/mips/include/asm/syscall.h
>> >>>b/arch/mips/include/asm/syscall.h
>> >>>index c6e9cd2..bd7543c 100644
>> >>>--- a/arch/mips/include/asm/syscall.h
>> >>>+++ b/arch/mips/include/asm/syscall.h
>> >>>@@ -133,6 +133,8 @@ static inline int syscall_get_arch(void)
>> >>>   #ifdef CONFIG_64BIT
>> >>>           if (!test_thread_flag(TIF_32BIT_REGS))
>> >>>                   arch |= __AUDIT_ARCH_64BIT;
>> >>>+        if (test_thread_flag(TIF_32BIT_ADDR))
>> >>>+                arch |= __AUDIT_ARCH_MIPS64_N32;
>> >>>   #endif
>> >>>   #if defined(__LITTLE_ENDIAN)
>> >>>           arch |=  __AUDIT_ARCH_LE;
>> >>>diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> >>>index 11917f7..6bd9322 100644
>> >>>--- a/include/uapi/linux/audit.h
>> >>>+++ b/include/uapi/linux/audit.h
>> >>>@@ -334,6 +334,8 @@ enum {
>> >>>   /* distinguish syscall tables */
>> >>>   #define __AUDIT_ARCH_64BIT 0x80000000
>> >>>   #define __AUDIT_ARCH_LE    0x40000000
>> >>>+#define __AUDIT_ARCH_MIPS64_N32 0x20000000
>> >>>+
>> >>>   #define AUDIT_ARCH_ALPHA
>> >>>(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>> >>>   #define AUDIT_ARCH_ARM          (EM_ARM|__AUDIT_ARCH_LE)
>> >>>   #define AUDIT_ARCH_ARMEB        (EM_ARM)
>> >>>@@ -346,7 +348,11 @@ enum {
>> >>>   #define AUDIT_ARCH_MIPS         (EM_MIPS)
>> >>>   #define AUDIT_ARCH_MIPSEL       (EM_MIPS|__AUDIT_ARCH_LE)
>> >>>   #define AUDIT_ARCH_MIPS64       (EM_MIPS|__AUDIT_ARCH_64BIT)
>> >>>+#define AUDIT_ARCH_MIPS64N32    (EM_MIPS|__AUDIT_ARCH_64BIT|\
>> >>>+                                 __AUDIT_ARCH_MIPS64_N32)
>> >>>   #define AUDIT_ARCH_MIPSEL64
>> >>>(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>> >>>+#define AUDIT_ARCH_MIPSEL64N32
>> >>>(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE\
>> >>>+                                 __AUDIT_ARCH_MIPS64_N32)
>> >>>   #define AUDIT_ARCH_OPENRISC     (EM_OPENRISC)
>> >>>   #define AUDIT_ARCH_PARISC       (EM_PARISC)
>> >>>   #define AUDIT_ARCH_PARISC64     (EM_PARISC|__AUDIT_ARCH_64BIT)
>> >>
>> >>I love it from both an audit and libseccomp PoV...
>> >>
>> >
>> >I know nothing about the MIPS entry code, but the concept is:
>> >
>> >Acked-by: Andy Lutomirski <luto@amacapital.net>
>> >
>> >That being said, here's a minor nit:
>> >
>> >#define __AUDIT_ARCH_MIPS64_N32 0x20000000
>> >
>> >in a cross-arch header doesn't seem like the best idea.  Might it be
>> >better to do:
>
> In another patch of mine adding audit support I've named the
> bit __AUDIT_ARCH_ALT which should be a sufficiently neutral name,
> I'd hope.
>
>> >/* These bits disambiguate different calling conventions that share an
>> >ELF machine type, bitness, and endianness */
>> >#define __AUDIT_ARCH_CONVENTION_MASK 0x30000000
>> >#define __AUDIT_ARCH_CONVENTION_MIPS64_N32 0x20000000
>> >
>> >This will encourage reuse of the same bit the next time this happens.
>> >
>> >--Andy
>> >
>>
>> Thanks. I will change the patch based on your proposal and send it
>> to the kernel mailing lists for review.
>
> I can't imagine any legitimate reason why an application of a particular
> ABI would want to try a syscall of another ABI, for example why an N64
> process would want to call the O32 open(2) syscall.

I've done it for testing.  And x32 does it because it's x32.

>
> For that reason I've long been contemplating to make syscalls of other ABIs
> unavailable, even without seccomp.  Would that be useful for seccomp?

It's still possible to execve something else.

>
> One exception though - I've seen a non-O32 application using syscall 4000,
> the indirect syscall syscall.  Some needs to be the first to be taken out
> and shot ;-)
>

Aargh.  Let me guess: the indirect syscall syscall uses seven argument
registers.  I guess ARM wasn't the only architecture to make the
mistake of having one of those :(

--Andy
