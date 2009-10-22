Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 15:17:41 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:51901 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492346AbZJVNRf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 15:17:35 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091022131725703.ZKUS15360@hrndva-omta03.mail.rr.com>;
          Thu, 22 Oct 2009 13:17:25 +0000
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256211516.3852.47.camel@falcon>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>
	 <4ADF38D5.9060100@caviumnetworks.com>
	 <1256143568.18347.3169.camel@gandalf.stny.rr.com>
	 <4ADF3FE0.5090104@caviumnetworks.com>
	 <1256145813.18347.3210.camel@gandalf.stny.rr.com>
	 <1256211516.3852.47.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Thu, 22 Oct 2009 09:17:24 -0400
Message-Id: <1256217444.20866.599.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-22 at 19:38 +0800, Wu Zhangjin wrote:
> Hi,
> 
> On Wed, 2009-10-21 at 13:23 -0400, Steven Rostedt wrote:

> Ralf have told me -pg really works with -fomit-frame-pointer, although
> the gcc tool tell us they are not incompatible when we use both of them
> together, but when I remove -fno-omit-frame-pointer in
> KBUILD_FLAGS(enabled by CONFIG_FRAME_POINTER), it definitely remove the
> s8(fp) relative source code(Seems -fomit-frame-pionter is used by
> default by gcc), the leaf function becomes this:
> 
> function:
> 
> 80101144 <au1k_wait>:
> 80101144:       03e00821        move    at,ra
> 80101148:       0c04271c        jal     80109c70 <_mcount>
>
> No more instruction,
> 
> and the non-leaf function becomes,
> 
> 80126590 <copy_process>:
> 80126590:       27bdffa0        addiu   sp,sp,-96
> 80126594:       afbf005c        sw      ra,92(sp)
> 80126598:       afbe0058        sw      s8,88(sp)
> 8012659c:       afb70054        sw      s7,84(sp)
> 801265a0:       afb60050        sw      s6,80(sp)
> 801265a4:       afb5004c        sw      s5,76(sp)
> 801265a8:       afb40048        sw      s4,72(sp)
> 801265ac:       afb30044        sw      s3,68(sp)
> 801265b0:       afb20040        sw      s2,64(sp)
> 801265b4:       afb1003c        sw      s1,60(sp)
> 801265b8:       afb00038        sw      s0,56(sp)
> 801265bc:       03e00821        move    at,ra
> 801265c0:       0c04271c        jal     80109c70 <_mcount>
> 
> It may save about two instructions for us.
> 	
> 	sw	s8, offset(sp)
> 	move	s8, fp
> 
> and also, I have tried to just search "Save" instruction, if I find one,

So you look for "sw ..."?

> that should be a non-leaf function, otherwise, it's leaf function, but I
> can not prove no "Save" instruction before the leaf function's "move at,
> ra", for example:

Yes but it should never be saving the ra. You can search all
instructions before the move at,ra until you find the save of the ra, or
you find something that is not a save. If you find the saving of ra, it
is not a leaf, but if you don't find the saving of ra, then it is a
leaf.

> 
> 8010113c:       03e00008        jr      ra
> 80101140:       00020021        nop
> 
> 80101144 <au1k_wait>:
> 80101144:       03e00821        move    at,ra
> 80101148:       0c04271c        jal     80109c70 <_mcount>
> 
> if there is "save" instruction at address 80101140, it will fail.
> Although, I met not failure with several tries, but no prove on it! any
> ABI protection for this? if YES, this should be a better solution, for
> it may works without -fno-omit-frame-pointer and save several
> instructions for us.

If we don't stop at just one save, but look for the saving of ra, it
should not fail.

> 
> and BTW, -fomit-frame-pointer does help "a lot" for us to get the stack
> address without any big load:
> 
>         sp = fp + (code & STACK_OFFSET_MASK);
>         ra = *(unsigned long *)sp;
> 
> although we can calculate it via the parent_addr, I have got this in:
> 
> NESTED(ftrace_graph_caller, PT_SIZE, ra) 
>         MCOUNT_SAVE_REGS
> 
>         PTR_LA  a0, PT_R1(sp)   /* arg1: &AT -> a0 */
>         move    a1, ra          /* arg2: next ip, selfaddr */
>         PTR_SUBU a1, MCOUNT_INSN_SIZE
>         move    a2, fp          /* arg3: frame pointer */
>         jal     prepare_ftrace_return
>         nop
> 
>         MCOUNT_RESTORE_REGS
>         RETURN_BACK
>         END(ftrace_graph_caller)
> 
> so, parent_addr is the current sp + PT_R1:
> 	
> 	sp = sp - PT_SIZE (did in MCOUNT_SAVE_REGS)
> 	parent_addr = sp + PT_R1
> 
> so the fp can be calculated like this:
> 
> 	fp = parent_addr - PT_R1 + PT_SIZE;
> 
> this will take use a little time to calculate it.
> 
> ooh, so,  both -fomit-frame-pointer and -fno-omit-frame-pointer work for
> us, the left job is that: we need to prove them are really SAFE here.
> 

Great!

-- Steve

> > > 
> > >     move    s8,sp
> > > 
> > > To identify function prologs, but it would still be ad hoc, as modern 
> > > versions of GCC will reorder instructions in the prolog for better 
> > > scheduling.
> > 
