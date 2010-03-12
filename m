Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 12:50:28 +0100 (CET)
Received: from mail-pz0-f185.google.com ([209.85.222.185]:63194 "EHLO
        mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab0CLLuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 12:50:20 +0100
Received: by pzk15 with SMTP id 15so644972pzk.21
        for <multiple recipients>; Fri, 12 Mar 2010 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=0dqy4Ue13PuSaX+6VsF1ieX9t0MvOCcxs1TN4dFE82A=;
        b=t5KrgIzlj5Wpvjy7+SmU0yNOdo5stFtba9KqxZQF6sspw9VO4sVzTKl7UgPLNKQQyQ
         Tkci0pxgCR8uV4mZJj7qXcA7C+GhfAXHULRQtPQJkPLruGaPMSUT/yEs46602G1yKWR9
         g8beuLR4mT0c+wR4+1lfzs6YPe/L4flV6N+WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=H1pTaPUywPsII/3DQ2GgDp4YLN5b19+33MU7pzA/zZjjI6GuwSDGIJ173bd5pildTE
         /DxJ3rYCYVLI4io/PX7Lp4ibJnbArAwRkK5hSxBqK2a4Dokoc05K5By4poqi0J+eHq4R
         3yNF/KmWqgSXLGIFs+wUK7CnDYt/LXeFk1pN4=
Received: by 10.141.213.22 with SMTP id p22mr2868815rvq.94.1268394613387;
        Fri, 12 Mar 2010 03:50:13 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 20sm1195946pzk.11.2010.03.12.03.50.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 03:50:12 -0800 (PST)
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
In-Reply-To: <4B993B32.7000006@caviumnetworks.com>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
         <4B993B32.7000006@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 12 Mar 2010 19:43:29 +0800
Message-ID: <1268394209.6447.94.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2010-03-11 at 10:49 -0800, David Daney wrote:
[...]
> > +/*
> > + * If the Instruction Pointer is in module space (0xc0000000), return ture;
> 
> s/ture/true/
> 

yeah.

> > + * otherwise, it is in kernel space (0x80000000), return false.
> > + */
> > +#define in_module(ip) (unlikely((ip)&  0x40000000))
> > +
> 
> This isn't universally true, but it does hold for most configurations I 
> think.

Although I'm not sure who is the exception, we always need an universal
solution, what about this:

Compare module with kernel:

module:

        <saving registers>

        lui     v1, hi16_mcount                <--- ip
        addiu   v1, v1, lo16_mcount
        move    at, ra
        jalr    v1
         nop

kernel:

        <saving registers>

         move    at, ra
         jal     _mcount                       <--- ip

The above _ip_ is the address have been recorded into the __mcount_loc
section of the kernel by scripts/recordmcount.pl, as we can see, for
kernel, the *(ip - 4) is "move at, ra": 03e0082d, a certain instruction,
but for module, there is no possibility(?) of existing a "move at, ra"
at *(ip -4) but a register saving operation("s {d,w} rs, offset(sp)",
prefixed by 0xffb0 for 64bit and 0xafb0 for 32bit. ), and reversly, for
kernel, there is no such instruction there.

And consider the new option -mmcount-ra-address of gcc, some more
instructions will be inserted between "move at, ra" and the calling site
to mcount, so, *(ip-4) will not always be "move at, ra", then we need to
check if there is a "s {d,w} rs, offset(sp)" there, if yes, it is in
module, otherwise, it should be in kernel.

#define S_RS_SP          0xafb00000      /* s{d,w} rs, offset(sp) */

static inline int in_module(ip)
{
	insn = *(ip - 4); /* need to use safe_load_code instead, what about big
endian? */

	return ((insn & S_RS_SP) == S_RS_SP)
}

> 
> [...]
> 
> > +	/*
> > +	 * We have compiled modules with -mlong-calls, but compiled kernel
> > +	 * without it, therefore, need to cope with them respectively.
> > +	 *
> > +	 * For module:
> > +	 *
> > +	 *	lui	v1, hi16_mcount		-->  b	1f
> > +	 *	addiu	v1, v1, lo16_mcount
> > +	 *	move	at, ra
> > +	 *	jalr	v1
> > +	 *	 nop
> > +	 *					1f: (ip + 16)
> 
> 
> Have you thought about just overwriting the jalr here instead of 
> branching around it?  In any event, I don't think you can count on a 
> fixed size code sequence for calling _mcount.  We are passing the 
> address of the save location of RA to _mcount too.  The size of the code 
> will depend on the size of the functions stack frame *and* weather or 
> not it is a leaf function.  Although in the kernel we are unlikely to 
> see functions with large stack frames.

So even with "b 1f", we need to use the right offset, the original
version for module with -mmcount-ra-address should have bugs here for
the offset should be 16 + 8 or 4 (two instructions for leaf function,
one instruction for non-leaf function).

but for we only recorded the position of "lui v1, hi16_mcount" in the
__mcount_loc section, so we need to search the position of the real
calling site of mcount(jalr v1), this will goes to what you have
suggested below.

> 
> 
> > +	 * For kernel:
> > +	 *
> > +	 *	move	at, ra
> > +	 *	jal	_mcount			-->  nop
> > +	 *
> > +	 */
> > +	new = in_module(ip) ? INSN_B_1F : INSN_NOP;
> 
> 
> What would happen if you read the code to find the first JAL or JALR, 
> and then overwrote it with a NOP instead of relying on the function 
> address to figure out which type of prolog it has?
> 
> The reason I suggest this is that sometimes we place the entire kernel 
> in CSSEG.  When this is done, everything has the same (short) _mcount 
> calling sequence.

Right, then, we can search the JAL or JALR, for kernel, will get it
immediatly, for module, will only several instructions, we can do this
searching in ftrace_make_nop and ftrace_make_call at run-time, but just
found we can use the following function to do it in ftrace_init(), looks
good.

static inline int is_call_mcount(unsigned int insn)
{
	return ((insn & JAL) == JAL) || (insn == JALR_V1);
}

static inline unsinged long mcount_callsite(unsigned long addr)
{
	unsigned int insn;

	insn = *(unsigned int *)addr; /*need safe_load_code*/
	if (is_call_mcount(insn))
		return addr;

	do {
		addr += 4;	/* what about big endian? */
		insn = *(unsigned int *)addr; /*need safe_load_code*/
	} while (!is_call_mcount(insn));

	return addr;
}

static inline unsigned long ftrace_call_adjust(unsigned long addr)
{
        return mcount_callsite(addr);
}

With the above support, we only need this new ftrace_make_nop:

*(unsigned int *)ip = INSN_NOP;

(But for module, this may need more overhead than "b 1f". )

and ftrace_make_call:

*(unsigned int *)ip = in_module(ip) : INSN_JALR_V1 : insn_jal_mcount;

(And here, for module, we need more time to determine which space we
are.)

Any more suggestion?

Thanks & Regards,
	Wu Zhangjin
