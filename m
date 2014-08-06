Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2014 19:12:16 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:46351 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859942AbaHFRML5uPWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2014 19:12:11 +0200
Received: by mail-la0-f46.google.com with SMTP id b8so2427646lan.5
        for <multiple recipients>; Wed, 06 Aug 2014 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+TscfADFdH1lBX+ssCejKj1Ey+WF7l5WmXXB/imf7q8=;
        b=nAjuyXUHfdBadi6f0esKq6U068PTuBAQdPStO8juUdTOh7akIeNtb2KT29S+yifzFH
         AoVXaF8n7YohzWa3Empr4qop3yQIDIoeBcZoKVwUvanrkDD72FS+ZmNRlcDYqRoVLYxr
         H8t3BLeFFfAZDJ0SAD5MsCpaSnPrXmBSwkJ/DeUjBQ1dxcEzdpGEE2n6QR2Z+/35OHr5
         euCh3vgxo9yk0DXZnxS9qRdOTf8tUOqB0LZ5pE4aD9sx5TXGz1YvI+6TzvvbsQ2hNFkR
         60bCJOLh/J/4b1nrW/qn7Rug0kYnwFqa2Gvqj3itnK12W9F42rqIBlRVRy2BlKAgHwIP
         oT8Q==
MIME-Version: 1.0
X-Received: by 10.153.6.39 with SMTP id cr7mr4707187lad.66.1407345126212; Wed,
 06 Aug 2014 10:12:06 -0700 (PDT)
Received: by 10.112.50.84 with HTTP; Wed, 6 Aug 2014 10:12:06 -0700 (PDT)
In-Reply-To: <CAGXr9JE7v9-hS3irmdgeaEU2iGLZHshEr_N-Do1UAsZhyzMe2g@mail.gmail.com>
References: <20140724055502.301F710077A@puck.mtv.corp.google.com>
        <CAOGqxeXY4x7gyhpsSwm6dohG8rJschsR4yyd2YXdeAarsLp1WQ@mail.gmail.com>
        <CAGXr9JE7v9-hS3irmdgeaEU2iGLZHshEr_N-Do1UAsZhyzMe2g@mail.gmail.com>
Date:   Wed, 6 Aug 2014 13:12:06 -0400
Message-ID: <CAOGqxeW8+cdfUuGqy8d6Ewcyy9oC7ZCsdd1p4aX_-zko38BAuA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Ftrace: Fix dynamic tracing of kernel modules
From:   Alan Cooper <alcooperx@gmail.com>
To:     Petri Gynther <pgynther@google.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Steven Rostedt <rostedt@goodmis.org>, cminyard@mvista.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <alcooperx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

Petri,

Actually , there's no reason to write the second NOP when nop'ing the
mcount call site in a module. This was done to remove the stack adjust
instruction which only exists at this location for internal kernel
routines. The following diff seems like a simpler way to solve issue
#1:

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 60e7e5e..643e501 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -157,25 +157,28 @@ static int ftrace_modify_code_2(unsigned long
ip, unsigned int new_code1,
 int ftrace_make_nop(struct module *mod,
     struct dyn_ftrace *rec, unsigned long addr)
 {
- unsigned int new;
  unsigned long ip = rec->ip;

  /*
- * If ip is in kernel space, no long call, otherwise, long call is
- * needed.
+ * If the ip is not in kernel space, the call to mcount is a
+ * long call consisting of multiple instructions so use
+ * a branch forward to skip the call. If the ip is in the
+ * kernel, the call is a single instruction so use a NOP.
  */
- new = in_kernel_space(ip) ? INSN_NOP : INSN_B_1F;
+ if (!in_kernel_space(ip))
+ return ftrace_modify_code(ip, INSN_B_1F);
+
 #ifdef CONFIG_64BIT
- return ftrace_modify_code(ip, new);
+ return ftrace_modify_code(ip, INSN_NOP);
 #else
  /*
- * On 32 bit MIPS platforms, gcc adds a stack adjust
- * instruction in the delay slot after the branch to
- * mcount and expects mcount to restore the sp on return.
- * This is based on a legacy API and does nothing but
- * waste instructions so it's being removed at runtime.
+ * For non-module kernel functions on 32 bit MIPS platforms,
+ * gcc adds a stack adjust instruction in the delay slot
+ * after the branch to mcount and expects mcount to restore
+ * the sp on return. This is based on a legacy API and does
+ * nothing but waste instructions so it's being removed at runtime.
  */
- return ftrace_modify_code_2(ip, new, INSN_NOP);
+ return ftrace_modify_code_2(ip, INSN_NOP, INSN_NOP);
 #endif
 }

-- 
1.9.0.138.g2de3478



On Tue, Aug 5, 2014 at 4:28 PM, Petri Gynther <pgynther@google.com> wrote:
> Hi Al,
>
> On Tue, Aug 5, 2014 at 9:41 AM, Alan Cooper <alcooperx@gmail.com> wrote:
>>
>> Petri,
>>
>> >However, when ftrace is later enabled for a call site, ftrace_make_call()
>> >does not currently restore the _mcount call correctly for module call
>> > sites
>>
>> I just did some testing on a BMIPS5000 system with a 3.3 kernel and
>> module tracing worked correctly without these changes. I see that the call
>> site is being restored correctly by writing a single 0x3c038001 which is
>> what
>> the compiler originally generated. What are the first 2 instructions of
>> your
>> modules call site and what version kernel and toolchain are you using?
>
>
>
> I am using 3.15 kernel on BMIPS5000 platform.
>
> Relevant config is:
> CONFIG_32BIT=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
>
> Compiler:
> $ mipsel-linux-gcc --version
> mipsel-linux-gcc (Broadcom stbgcc-4.5.3-1.3) 4.5.3
>
> Two sample callsites from bluetooth.ko kernel module:
> $ mipsel-linux-objdump -d bluetooth.ko
> 00000000 <bt_seq_stop>:
> =>   0: 3c030000  lui v1,0x0
>        4: 24630000  addiu v1,v1,0
>        8: 03e00821  move at,ra
>        c: 00006021  move t4,zero
>       10: 0060f809  jalr v1
>       14: 27bdfff8  addiu sp,sp,-8
>       18: 8c820080  lw v0,128(a0)
>       1c: 3c190000  lui t9,0x0
>       20: 8c440000  lw a0,0(v0)
>       24: 27390000  addiu t9,t9,0
>       28: 03200008  jr t9
>       2c: 24840004  addiu a0,a0,4
>
> 00000030 <bt_procfs_cleanup>:
> =>  30: 3c030000  lui v1,0x0
>       34: 24630000  addiu v1,v1,0
>       38: 03e00821  move at,ra
>       3c: 00006021  move t4,zero
>       40: 0060f809  jalr v1
>       44: 27bdfff8  addiu sp,sp,-8
>       ...
>
> 00000000 <__mcount_loc>:
>    0: 00000000
>    4: 00000030
>    ...
>
> $ mipsel-linux-objdump -r bluetooth.ko
> RELOCATION RECORDS FOR [.text]:
> OFFSET   TYPE              VALUE
> 00000000 R_MIPS_HI16       _mcount
> 00000004 R_MIPS_LO16       _mcount
> ...
> 00000030 R_MIPS_HI16       _mcount
> 00000034 R_MIPS_LO16       _mcount
>
>
> When bluetooth.ko is loaded, ftrace_make_nop() turns the first two
> instructions to branch + nop:
> 00000000 <bt_seq_stop>:
> =>   0: 10000005  branch 5 instructions forward to 18:
>        4: 00000000  nop
>        8: 03e00821  move at,ra
>        c: 00006021  move t4,zero
>       10: 0060f809  jalr v1
>       14: 27bdfff8  addiu sp,sp,-8
>       18:
>
> However, when tracing is later turned on, ftrace_make_call() only converts
> the branch back to "lui v1, HI16(_mcount)":
> 00000000 <bt_seq_stop>:
> =>   0: 3c030000  lui v1,0x0
>        4: 00000000  nop
>        8: 03e00821  move at,ra
>        c: 00006021  move t4,zero
>       10: 0060f809  jalr v1
>       14: 27bdfff8  addiu sp,sp,-8
>       18:
>
> The nop at 4 is not turned back to "addiu v1, v1, LO16(_mcount)", which
> leads to bad address in v1, subsequent jalr v1, and kernel crash.
>
> Also, when the module calls _mcount via "jalr v1", ra will contain address
> that is 0x18 greater than the recorded mcount callsite. Thus, a0 needs to be
> adjusted accordingly in _mcount code.
>
> -- Petri
>
>
>>
>>
>> Al
>>
>> On Thu, Jul 24, 2014 at 1:55 AM, Petri Gynther <pgynther@google.com>
>> wrote:
>> > Dynamic tracing of kernel modules is broken on 32-bit MIPS. When modules
>> > are loaded, the kernel crashes when dynamic tracing is enabled with:
>> >  cd /sys/kernel/debug/tracing
>> >  echo > set_ftrace_filter
>> >  echo function > current_tracer
>> >
>> > 1) arch/mips/kernel/ftrace.c
>> > When the kernel boots, or when a module is initialized,
>> > ftrace_make_nop()
>> > modifies every _mcount call site to eliminate the ftrace overhead.
>> > However, when ftrace is later enabled for a call site,
>> > ftrace_make_call()
>> > does not currently restore the _mcount call correctly for module call
>> > sites.
>> > Added ftrace_modify_code_2r() and modified ftrace_make_call() to fix
>> > this.
>> >
>> > 2) arch/mips/kernel/mcount.S
>> > _mcount assembly routine is supposed to have the caller's _mcount call
>> > site
>> > address in register a0. However, a0 is currently not calculated
>> > correctly for
>> > module call sites. a0 should be (ra - 20) or (ra - 24), depending on
>> > whether
>> > the kernel was built with KBUILD_MCOUNT_RA_ADDRESS or not.
>> >
>> > This fix has been tested on Broadcom BMIPS5000 processor. Dynamic
>> > tracing
>> > now works for both built-in functions and module functions.
>> >
>> > Signed-off-by: Petri Gynther <pgynther@google.com>
>> > ---
>> >  arch/mips/kernel/ftrace.c | 56
>> > +++++++++++++++++++++++++++++++++++++++--------
>> >  arch/mips/kernel/mcount.S | 13 +++++++++++
>> >  2 files changed, 60 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
>> > index 60e7e5e..2a72208 100644
>> > --- a/arch/mips/kernel/ftrace.c
>> > +++ b/arch/mips/kernel/ftrace.c
>> > @@ -63,7 +63,7 @@ static inline int in_kernel_space(unsigned long ip)
>> >         ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
>> >
>> >  static unsigned int insn_jal_ftrace_caller __read_mostly;
>> > -static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
>> > +static unsigned int insn_la_mcount[2] __read_mostly;
>> >  static unsigned int insn_j_ftrace_graph_caller __maybe_unused
>> > __read_mostly;
>> >
>> >  static inline void ftrace_dyn_arch_init_insns(void)
>> > @@ -71,10 +71,10 @@ static inline void ftrace_dyn_arch_init_insns(void)
>> >         u32 *buf;
>> >         unsigned int v1;
>> >
>> > -       /* lui v1, hi16_mcount */
>> > +       /* la v1, _mcount */
>> >         v1 = 3;
>> > -       buf = (u32 *)&insn_lui_v1_hi16_mcount;
>> > -       UASM_i_LA_mostly(&buf, v1, MCOUNT_ADDR);
>> > +       buf = (u32 *)&insn_la_mcount[0];
>> > +       UASM_i_LA(&buf, v1, MCOUNT_ADDR);
>> >
>> >         /* jal (ftrace_caller + 8), jump over the first two instruction
>> > */
>> >         buf = (u32 *)&insn_jal_ftrace_caller;
>> > @@ -111,14 +111,47 @@ static int ftrace_modify_code_2(unsigned long ip,
>> > unsigned int new_code1,
>> >                                 unsigned int new_code2)
>> >  {
>> >         int faulted;
>> > +       mm_segment_t old_fs;
>> >
>> >         safe_store_code(new_code1, ip, faulted);
>> >         if (unlikely(faulted))
>> >                 return -EFAULT;
>> > -       safe_store_code(new_code2, ip + 4, faulted);
>> > +
>> > +       ip += 4;
>> > +       safe_store_code(new_code2, ip, faulted);
>> >         if (unlikely(faulted))
>> >                 return -EFAULT;
>> > +
>> > +       ip -= 4;
>> > +       old_fs = get_fs();
>> > +       set_fs(get_ds());
>> >         flush_icache_range(ip, ip + 8);
>> > +       set_fs(old_fs);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int ftrace_modify_code_2r(unsigned long ip, unsigned int
>> > new_code1,
>> > +                                unsigned int new_code2)
>> > +{
>> > +       int faulted;
>> > +       mm_segment_t old_fs;
>> > +
>> > +       ip += 4;
>> > +       safe_store_code(new_code2, ip, faulted);
>> > +       if (unlikely(faulted))
>> > +               return -EFAULT;
>> > +
>> > +       ip -= 4;
>> > +       safe_store_code(new_code1, ip, faulted);
>> > +       if (unlikely(faulted))
>> > +               return -EFAULT;
>> > +
>> > +       old_fs = get_fs();
>> > +       set_fs(get_ds());
>> > +       flush_icache_range(ip, ip + 8);
>> > +       set_fs(old_fs);
>> > +
>> >         return 0;
>> >  }
>> >  #endif
>> > @@ -130,13 +163,14 @@ static int ftrace_modify_code_2(unsigned long ip,
>> > unsigned int new_code1,
>> >   *
>> >   * move at, ra
>> >   * jal _mcount         --> nop
>> > + *  sub sp, sp, 8      --> nop  (CONFIG_32BIT)
>> >   *
>> >   * 2. For modules:
>> >   *
>> >   * 2.1 For KBUILD_MCOUNT_RA_ADDRESS and CONFIG_32BIT
>> >   *
>> >   * lui v1, hi_16bit_of_mcount       --> b 1f (0x10000005)
>> > - * addiu v1, v1, low_16bit_of_mcount
>> > + * addiu v1, v1, low_16bit_of_mcount --> nop  (CONFIG_32BIT)
>> >   * move at, ra
>> >   * move $12, ra_address
>> >   * jalr v1
>> > @@ -145,7 +179,7 @@ static int ftrace_modify_code_2(unsigned long ip,
>> > unsigned int new_code1,
>> >   * 2.2 For the Other situations
>> >   *
>> >   * lui v1, hi_16bit_of_mcount       --> b 1f (0x10000004)
>> > - * addiu v1, v1, low_16bit_of_mcount
>> > + * addiu v1, v1, low_16bit_of_mcount --> nop  (CONFIG_32BIT)
>> >   * move at, ra
>> >   * jalr v1
>> >   *  nop | move $12, ra_address | sub sp, sp, 8
>> > @@ -184,10 +218,14 @@ int ftrace_make_call(struct dyn_ftrace *rec,
>> > unsigned long addr)
>> >         unsigned int new;
>> >         unsigned long ip = rec->ip;
>> >
>> > -       new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
>> > -               insn_lui_v1_hi16_mcount;
>> > +       new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
>> > insn_la_mcount[0];
>> >
>> > +#ifdef CONFIG_64BIT
>> >         return ftrace_modify_code(ip, new);
>> > +#else
>> > +       return ftrace_modify_code_2r(ip, new, in_kernel_space(ip) ?
>> > +                                               INSN_NOP :
>> > insn_la_mcount[1]);
>> > +#endif
>> >  }
>> >
>> >  #define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
>> > diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
>> > index 539b629..26ceb3c 100644
>> > --- a/arch/mips/kernel/mcount.S
>> > +++ b/arch/mips/kernel/mcount.S
>> > @@ -84,6 +84,19 @@ _mcount:
>> >  #endif
>> >
>> >         PTR_SUBU a0, ra, 8      /* arg1: self address */
>> > +       PTR_LA   t1, _stext
>> > +       sltu     t2, a0, t1     /* t2 = (a0 < _stext) */
>> > +       PTR_LA   t1, _etext
>> > +       sltu     t3, t1, a0     /* t3 = (a0 > _etext) */
>> > +       or       t1, t2, t3
>> > +       beqz     t1, ftrace_call
>> > +        nop
>> > +#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
>> > +       PTR_SUBU a0, a0, 16     /* arg1: adjust to module's recorded
>> > callsite */
>> > +#else
>> > +       PTR_SUBU a0, a0, 12
>> > +#endif
>> > +
>> >         .globl ftrace_call
>> >  ftrace_call:
>> >         nop     /* a placeholder for the call to a real tracing function
>> > */
>> > --
>> > 2.0.0.526.g5318336
>> >
>
>
