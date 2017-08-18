Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 01:05:15 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:35857
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994943AbdHRXFIbOqpJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Aug 2017 01:05:08 +0200
Received: by mail-wm0-x243.google.com with SMTP id d40so5643628wma.3
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2017 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=nbU3/at6YMfadCaa+JUHoOUBFmWyyP0wqNxerddM7xk=;
        b=GMiFBCNJGePGVGc1ylv3EDOowwkeSMOUiKmrXYxQWMuxcDgw8uhG9zY7L5mKqUoMXM
         uY0HtmRCGOknzfsRcdoNkOG8aF3x/mUmetVNaulwPc7QTotEWE/uVKkZ+S8nSYPoW7iV
         0KJhJCzQWT2ZTX8hg0c7GV+c/qT7gRjbzY/hJW+Y29mBdzybPSTOMNkKBb60AJCL/ulw
         ll6pDLI1AV4yDjmef2jX7thtTI0XLcSMXA4Hir245Pqk1YuVjGdORSTX9S8XEbNnyJ0o
         7vBBeaNwP7783RJax70O43BkK4vDiwpAQFBREq5lxJ0ydQxYp4XISRjkFqDDKCddn9ns
         9X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=nbU3/at6YMfadCaa+JUHoOUBFmWyyP0wqNxerddM7xk=;
        b=SB6CJOludP9JnQEXg55EakDb+nAqhSZ4KUszqTWKs9frSE7RcFKkNa+qCsP3Ki8SCe
         F6bItnmqqTZXyxGVt84p44pZcD7UuGSzPJCNPWkEJiA09T+aIdwiVJrY7l6MN7lXpT9o
         jP7Q4Z5kDqaO/98kZ0nFe0ynltICqfZdBc7/lXwEhic/j5zpqgODmWw/8wveIyF+NP8j
         JMbGbxPkuHyroR+buSK8GDUqI9bYKJ7/RCvg7cuy/lvUk1D9SG1bKpQ04kNdylrmjCB3
         1qnvzqbk+wLEwDwAIUmNZlSFRsfkEVRywh1mG4TJ22Li07v3ET6/Q/prTckWYJE8/1rn
         1fUQ==
X-Gm-Message-State: AHYfb5gD4l9Ecab2fHBkhtiNhL0ALjGBuN/sYfr8DCGrRC9Vsjs2XFGR
        rJAzzc/5j98v24IAYy4=
X-Received: by 10.28.4.148 with SMTP id 142mr650960wme.145.1503097502772;
        Fri, 18 Aug 2017 16:05:02 -0700 (PDT)
Received: from android-f8911984c6e3e13 (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id p33sm795268wrc.81.2017.08.18.16.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 16:05:02 -0700 (PDT)
Date:   Sat, 19 Aug 2017 00:05:02 +0100
In-Reply-To: <alpine.DEB.2.00.1708181944260.17596@tp.orcam.me.uk>
References: <20170807231647.19551-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1708181302480.17596@tp.orcam.me.uk> <alpine.DEB.2.00.1708181731080.17596@tp.orcam.me.uk> <8259872.Nrvp2QXiRE@np-p-burton> <alpine.DEB.2.00.1708181944260.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] MIPS: Set ISA bit in entry-y for microMIPS kernels
To:     linux-mips@linux-mips.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>
From:   James Hogan <james.hogan@imgtec.com>
Message-ID: <A75389BC-A9E2-4E30-AD90-49F4F7B9EC83@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 18 August 2017 23:13:39 BST, "Maciej W. Rozycki" <macro@imgtec.com> wrote:
>Hi Paul,
>
>> I originally did this [1], and wrote about it in the
>post-three-dashes notes 
>> for this patch. To quote myself:
>> 
>> > I originally tried using "objdump -f" to obtain the entry address,
>which
>> > works for microMIPS but it always outputs a 32 bit address for a 32
>bit
>> > ELF whilst nm will sign extend to 64 bit. That matters for systems
>where
>> > we might want to run a MIPS32 kernel on a MIPS64 CPU & load it with
>a
>> > MIPS64 bootloader, which would then jump to a non-canonical
>> > (non-sign-extended) address.
>> > 
>> > This works in all cases as it only changes the behaviour for
>microMIPS
>> > kernels, but isn't the prettiest solution. A possible alternative
>would
>> > be to write a custom tool to just extract, sign extend & print the
>entry
>> > point of an ELF executable. I'm open to feedback if that would be
>> > preferred.
>> 
>> So if we were to use objdump we'd need to handle sign extending 32
>bit 
>> addresses to form a canonical address. Perhaps that'd be cleaner
>though.
>
>Hmm, your reasoning sounds right (and I was blind to miss it entirely, 
>sorry), however reality seems to disagree.  As at 5fc9484f5e41^ I get:
>
>make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
>		VMLINUX_LOAD_ADDRESS=0xffffffff80100000
>VMLINUX_ENTRY_ADDRESS=0x804fca20 PLATFORM="generic/" ADDR_BITS=32
>arch/mips/boot/vmlinux.srec
>
>whereas at 5fc9484f5e41^ I get:
>
>make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
>		VMLINUX_LOAD_ADDRESS=0xffffffff80100000
>VMLINUX_ENTRY_ADDRESS=0x804fca21 PLATFORM="generic/" ADDR_BITS=32
>arch/mips/boot/vmlinux.srec
>
>so in both cases the entry address is 32-bit, which is why I didn't see
>
>any disadvantage from using `objdump -f'.  Indeed:
>
>$ mips-linux-gnu-nm vmlinux | grep kernel_entry
>80100000 T __kernel_entry
>804fca20 T kernel_entry
>$ mips-mti-linux-gnu-nm vmlinux | grep kernel_entry
>ffffffff80100000 T __kernel_entry
>ffffffff804fca20 T kernel_entry
>$ 
>
>which means you can't rely on `nm' sign-extending addresses to 64 bits 
>with 32-bit binaries.  And it looks like a bug to me indeed that some 
>versions of `nm' do such sign-extension, unlike `objdump' and
>`readelf'.  
>I'll have to bisect it to see when it started happening and take it
>with 
>upstream binutils.
>
> How about this version then?  It does the right thing for me:
>
>make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
>		VMLINUX_LOAD_ADDRESS=0xffffffff80100000
>VMLINUX_ENTRY_ADDRESS=0xffffffff804fca21 PLATFORM="generic/"
>ADDR_BITS=32 arch/mips/boot/vmlinux.srec
>
>and given than we need to sign-extend in either case I think retrieving
>
>the canonical entry point rather than transforming the entry symbol is 
>simpler and more reliable.
>
>  Maciej
>
>---
> arch/mips/Makefile |   19 +++++--------------
> 1 file changed, 5 insertions(+), 14 deletions(-)
>
>linux-mips-start-address.diff
>Index: linux-sfr-usead/arch/mips/Makefile
>===================================================================
>--- linux-sfr-usead.orig/arch/mips/Makefile	2017-08-18
>22:17:42.962681000 +0100
>+++ linux-sfr-usead/arch/mips/Makefile	2017-08-18 23:01:00.997846000
>+0100
>@@ -244,20 +244,11 @@ ifdef CONFIG_PHYSICAL_START
> load-y					= $(CONFIG_PHYSICAL_START)
> endif
> 
>-entry-noisa-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
>-					| grep "\bkernel_entry\b" | cut -f1 -d \ )
>-ifdef CONFIG_CPU_MICROMIPS
>-  #
>-  # Set the ISA bit, since the kernel_entry symbol in the ELF will
>have it
>-  # clear which would lead to images containing addresses which
>bootloaders may
>-  # jump to as MIPS32 code.
>-  #
>-  entry-y = $(patsubst %0,%1,$(patsubst %2,%3,$(patsubst %4,%5, \
>-              $(patsubst %6,%7,$(patsubst %8,%9,$(patsubst %a,%b, \
>-              $(patsubst %c,%d,$(patsubst
>%e,%f,$(entry-noisa-y)))))))))
>-else
>-  entry-y = $(entry-noisa-y)
>-endif
>+# Knowing that a 32-bit kernel will be linked at a KSEG address

thats not true with CONFIG_KVM_GUEST kernels, which use a separate set of emulated guest kernel segments in useg, i.e. at 0x40000000. I've also seen EVA kernels linked at low addresses like around 0x20000000, though entry gets a bit fiddly for EVA depending on whether bootloader already has the chosen segment configuration set up.

Cheers
James

>+# sign-extend the entry point to 64 bits if retrieved as a 32-bit
>+# number by stuffing `ffffffff' after the leading `0x'.
>+entry-y	= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
>+	| sed -n 's/0x\(........\)$$/0xffffffff\1/;s/start address //p')
> 
> cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
> drivers-$(CONFIG_PCI)		+= arch/mips/pci/


--
James Hogan
