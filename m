Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 00:01:33 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34079 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011579AbbA2XBbcjCPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 00:01:31 +0100
Received: by mail-ie0-f171.google.com with SMTP id tr6so972163ieb.2
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6GwDS/WgPIsjE/mfNjYRHwIr9EnwNSjpPDofM/aUB/k=;
        b=MwP1xIfgAegL2bbMq+S7t2DmX1YnHjptrgdV5bSt9sjHJ4VEywmWUhPrAI7MDzgFCG
         ZiPHz97MOZG+Tc9FuipqWitpFF7Tsmjkq1riR+/Vn8Hq9dyIRMrkgAsGlK6aSUN1KuyW
         Ul/dtagV/5Pi3fnCK0jSu66vtT3H1nTaeGHGTKY0xhZ0JKXCY8DmtN+47baQj9ECtIKz
         vWO3Fs/ZX0VxHIt2Qk9Cb/ylLn417pIXA26E3vQOBvE/jR34Nl/ZzBx9ApWYwMARav6H
         /H1bdrtTuk43LAkotYJffMT7pzxtlK8Ci1tb74XDDE/M2l2Ixn+f/RonZluBT2LN3707
         hzkA==
X-Received: by 10.50.79.135 with SMTP id j7mr3383157igx.32.1422572485557;
        Thu, 29 Jan 2015 15:01:25 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id x64sm176732iod.30.2015.01.29.15.01.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Jan 2015 15:01:25 -0800 (PST)
Message-ID: <54CABBC3.6000006@gmail.com>
Date:   Thu, 29 Jan 2015 15:01:23 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Bruce Korb <bruce.korb@gmail.com>
CC:     gdb@sourceware.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: Hardware breakpoints on MIPS
References: <CAKRnqN+Js_zDn==T0+-EGzyTSW4P-dpvB7jKsLmFJEbKhxifJw@mail.gmail.com>
In-Reply-To: <CAKRnqN+Js_zDn==T0+-EGzyTSW4P-dpvB7jKsLmFJEbKhxifJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45551
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

On 01/29/2015 02:05 PM, Bruce Korb wrote:
>      FSF's Position regarding SCO's attacks on Free Software
>
> This comes from gdb's GNU.org web page.
> I think SCO has stopped attacking now. :)
>
> Anyway, I need to set a hardware breakpoint on a Mips CPU on a "Cavium" platform
> in a kernel module.  As I read the data sheet, I should need to write
> to CP0 registers
> 18 and 19, with 18 containing a kernel virtual address plus three bits
> for indicating
> an instruction, write access or read access; then I need to write 0x40000007 to
> register 19.  Except the interrupt doesn't fire and I've been unable
> to figure out
> what I've got wrong.  Code follows, for folks that can follow it and know how it
> ought to work.  I surely do thank you for any hints you can give:
>

This would appear to be for the most part, completely independent of 
GDB, and thus perhaps not a good candidate for the gdb@mailing list. 
What happens inside of the Linux kernel running on a MIPS{,64} CPU is 
often discussed on linux-mips@linux-mips.org.

Since many years ago, WatchLo and WatchHi have been under the control of 
the Linux kernel.  If you set these registers and a Watch Exception is 
triggered, it will cause the registers to be cleared and the exception 
will be ignored, unless they were configured via ptrace(2) for userspace 
addresses.

For debugging kernel space with watchpoint registers on OCTEON it is 
probably best to use the facilities in the EJTAG unit.

David Daney



>
> #define WW_W_BIT 0
> #define WW_R_BIT 1
> #define WW_I_BIT 2
>
> #define WW_W_MASK (1UL << WW_W_BIT)
> #define WW_R_MASK (1UL << WW_R_BIT)
> #define WW_I_MASK (1UL << WW_I_BIT)
>
> #define WW_IRW_MASK (WW_I_MASK | WW_R_MASK | WW_W_MASK)
>
> static inline void watch_word(void * addr, unsigned int mask)
> {
>      typedef struct {
>          unsigned is_inst_watch : 1; // true --> instruction watch
>          unsigned do_exception  : 1;
>          unsigned unused_29_24  : 6;
>          unsigned asid          : 8; // IFF "do_exception" is false
>          unsigned unused_15_12  : 4;
>          unsigned mask          : 9;
>          unsigned found_ins     : 1;
>          unsigned found_read    : 1;
>          unsigned found_write   : 1;
>      } watch_lo_bits_t;
>
>      U64 watchlo;
>      union {
>          watch_lo_bits_t bits;
>          U32 word;
>      } watchhi;
>
>      watchlo = (U64)addr;
>      watchlo = (watchlo & ~WW_IRW_MASK) | mask;  // watch for write access
>
>      watchhi.bits = (watch_lo_bits_t) {
>          .do_exception  = 1,
>          .found_ins     = 1,
>          .found_read    = 1,
>          .found_write   = 1
>      };
>      assert(watchhi.word == 0x40000007);
>
>      if ((mask & WW_I_MASK) != 0) {
>          write_c0_watchlo0(watchlo);  // macro from asm/mipsregs.h
>          write_c0_watchhi0(watchhi.word);
>      } else {
>          write_c0_watchlo1(watchlo);
>          write_c0_watchhi1(watchhi.word);
>      }
> }
>
>
