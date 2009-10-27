Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 02:04:48 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:57457 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493340AbZJ0BEl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 02:04:41 +0100
Received: by ywh3 with SMTP id 3so11008986ywh.22
        for <multiple recipients>; Mon, 26 Oct 2009 18:04:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mW49tvU/lkHRf9iRtYiJaWyhlKYKXDhm8droR+3gOpU=;
        b=Kz/lRZgBtvQkI26mzmtJa/2GpSvAfznx/ZlYbx3VcTM7f6fRzBR/piR4RL9lw56Vie
         BJsBT7hH+5fviF6Kvfi9QdwEp0JfUo3OxSLhfQzE98u6WIdjQe1RszdBg9wB6iD9AqDS
         MwpvFed54RidpfvJaBTp9UvklqYTE7/tA8oYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tx6iA6IFyWVUW0qAoKRzpeRXJkIySiaB2SQ6JUojq7zHX5OQQqp98hMUFfpLrB7yCd
         K07SeftCpCbL9WKkdgL+5CHZB146l5Y/V92sip7PVXigvj89f/v/0Q/HwWeDByfha+N8
         LnGcyz5gndoSNjYbgHoNftHDkUP2Z/yuUecOw=
Received: by 10.91.50.3 with SMTP id c3mr3769271agk.38.1256605473774;
        Mon, 26 Oct 2009 18:04:33 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 36sm1453931yxh.67.2009.10.26.18.04.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 18:04:32 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Add option to pass return address location to
 _mcount.
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	GCC Patches <gcc-patches@gcc.gnu.org>, rdsandiford@googlemail.com,
	linux-mips@linux-mips.org, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <4AE5F392.5020405@caviumnetworks.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon>	<4AE0A5BE.8000601@caviumnetworks.com>
	 <87y6n36plp.fsf@firetop.home>	<4AE232AD.4050308@caviumnetworks.com>
	 <87my3htau1.fsf@firetop.home>  <4AE5F392.5020405@caviumnetworks.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 27 Oct 2009 09:04:18 +0800
Message-Id: <1256605458.5499.4.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

[...]
> > 
> > Looks good otherwise, but I'd be interested in other suggestions for
> > the option name.  I kept misreading "raloc" as a typo for "reloc".
> 
> Well how about raaddr?  (Return-Address Address)
> 
> Still not tested, but how about this version instead?
> 

I will help to test it later(but maybe tomorrow to later), I think this
will can not pass the compiling, have tried it with the 4.4-200903...,
some of the macros are not defined, such as RETURN_ADDR_REGNUM(not sure
in the latest version of gcc).

Regards,
	Wu Zhangjin
 
> gcc/
> 2009-10-26  David Daney  <ddaney@caviumnetworks.com>
> 
> 	* doc/invoke.texi (mmcount-raaddr): Document new command line
> 	option.
> 	* config/mips/mips.opt (mmcount-raaddr): New option.
> 	* config/mips/mips-protos.h (mips_function_profiler): Declare new
> 	function.
> 	* config/mips/mips.c (struct mips_frame_info): Add ra_fp_offset
> 	member.
> 	(mips_for_each_saved_gpr_and_fpr): Set ra_fp_offset.
> 	(mips_function_profiler): Moved from FUNCTION_PROFILER, and
> 	rewritten.
> 	* config/mips/mips.h (FUNCTION_PROFILER): Body of macro moved to
> 	mips_function_profiler.
> 
> gcc/testsuite/
> 2009-10-26  David Daney  <ddaney@caviumnetworks.com>
> 
> 	* gcc.target/mips/mips.exp (mips_option_groups): Add
> 	mcount-raaddr.
> 	* gcc.target/mips/mmcount-raaddr-1.c: New test.
> 	* gcc.target/mips/mmcount-raaddr-2.c: New test.
> 	* gcc.target/mips/mmcount-raaddr-3.c: New test.
> 
> plain text document attachment (mcount.patch)
> Index: gcc/doc/invoke.texi
> ===================================================================
> --- gcc/doc/invoke.texi	(revision 153502)
> +++ gcc/doc/invoke.texi	(working copy)
> @@ -709,7 +709,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mbranch-cost=@var{num}  -mbranch-likely  -mno-branch-likely @gol
>  -mfp-exceptions -mno-fp-exceptions @gol
>  -mvr4130-align -mno-vr4130-align -msynci -mno-synci @gol
> --mrelax-pic-calls -mno-relax-pic-calls}
> +-mrelax-pic-calls -mno-relax-pic-calls -mmcount-raaddr}
>  
>  @emph{MMIX Options}
>  @gccoptlist{-mlibfuncs  -mno-libfuncs  -mepsilon  -mno-epsilon  -mabi=gnu @gol
> @@ -14192,6 +14192,19 @@ an assembler and a linker that supports 
>  directive and @code{-mexplicit-relocs} is in effect.  With
>  @code{-mno-explicit-relocs}, this optimization can be performed by the
>  assembler and the linker alone without help from the compiler.
> +
> +@item -mmcount-raaddr
> +@itemx -mno-mcount-raaddr
> +@opindex mmcount-raaddr
> +@opindex mno-mcount-raaddr
> +Emit (do not emit) code to pass the address of the return address save
> +location to @code{_mcount}.  The default is @option{-mno-mcount-raaddr}.
> +
> +@option{-mmcount-raaddr} can be used in conjunction with @option{-pg}
> +and a specially coded @code{_mcount} function to record function exit
> +by replacing the saved return address with a pointer to the function
> +exit profiling function.
> +
>  @end table
>  
>  @node MMIX Options
> Index: gcc/testsuite/gcc.target/mips/mips.exp
> ===================================================================
> --- gcc/testsuite/gcc.target/mips/mips.exp	(revision 153502)
> +++ gcc/testsuite/gcc.target/mips/mips.exp	(working copy)
> @@ -263,6 +263,7 @@ foreach option {
>      sym32
>      synci
>      relax-pic-calls
> +    mcount-raaddr
>  } {
>      lappend mips_option_groups $option "-m(no-|)$option"
>  }
> Index: gcc/testsuite/gcc.target/mips/mmcount-raaddr-1.c
> ===================================================================
> --- gcc/testsuite/gcc.target/mips/mmcount-raaddr-1.c	(revision 0)
> +++ gcc/testsuite/gcc.target/mips/mmcount-raaddr-1.c	(revision 0)
> @@ -0,0 +1,7 @@
> +/* { dg-do compile } */
> +/* { dg-options "-O2 -pg -mmcount-raaddr -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
> +/* { dg-final { scan-assembler "\tmove\t\\\$12,\\\$0" } } */
> +int bazl(int i)
> +{
> +  return i + 2;
> +}
> Index: gcc/testsuite/gcc.target/mips/mmcount-raaddr-2.c
> ===================================================================
> --- gcc/testsuite/gcc.target/mips/mmcount-raaddr-2.c	(revision 0)
> +++ gcc/testsuite/gcc.target/mips/mmcount-raaddr-2.c	(revision 0)
> @@ -0,0 +1,8 @@
> +/* { dg-do compile } */
> +/* { dg-options "-O2 -pg -mmcount-raaddr -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
> +/* { dg-final { scan-assembler "\tdaddiu\t\\\$12,\\\$sp,8" } } */
> +int foo (int);
> +int bar (int i)
> +{
> +  return foo (i) + 2;
> +}
> Index: gcc/testsuite/gcc.target/mips/mmcount-raaddr-3.c
> ===================================================================
> --- gcc/testsuite/gcc.target/mips/mmcount-raaddr-3.c	(revision 0)
> +++ gcc/testsuite/gcc.target/mips/mmcount-raaddr-3.c	(revision 0)
> @@ -0,0 +1,10 @@
> +/* { dg-do compile } */
> +/* { dg-options "-O2 -pg -mmcount-raaddr -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
> +/* { dg-final { scan-assembler "\tdli\t\\\$12,200008" } } */
> +/* { dg-final { scan-assembler "\tdaddu\t\\\$12,\\\$12,\\\$sp" } } */
> +int foo (int *);
> +int bar(int i)
> +{
> +  int big[50000];
> +  return foo (big) + 2;
> +}
> Index: gcc/config/mips/mips.opt
> ===================================================================
> --- gcc/config/mips/mips.opt	(revision 153502)
> +++ gcc/config/mips/mips.opt	(working copy)
> @@ -208,6 +208,10 @@ mlong64
>  Target Report RejectNegative Mask(LONG64)
>  Use a 64-bit long type
>  
> +mmcount-raaddr
> +Target Report Var(TARGET_MCOUNT_RAADDR)
> +Pass the address of the ra save location to _mcount in $12
> +
>  mmemcpy
>  Target Report Mask(MEMCPY)
>  Don't optimize block moves
> Index: gcc/config/mips/mips-protos.h
> ===================================================================
> --- gcc/config/mips/mips-protos.h	(revision 153502)
> +++ gcc/config/mips/mips-protos.h	(working copy)
> @@ -344,5 +344,6 @@ extern bool mips_eh_uses (unsigned int);
>  extern bool mips_epilogue_uses (unsigned int);
>  extern void mips_final_prescan_insn (rtx, rtx *, int);
>  extern int mips_trampoline_code_size (void);
> +extern void mips_function_profiler (FILE *);
>  
>  #endif /* ! GCC_MIPS_PROTOS_H */
> Index: gcc/config/mips/mips.c
> ===================================================================
> --- gcc/config/mips/mips.c	(revision 153502)
> +++ gcc/config/mips/mips.c	(working copy)
> @@ -319,6 +319,9 @@ struct GTY(())  mips_frame_info {
>    HOST_WIDE_INT acc_sp_offset;
>    HOST_WIDE_INT cop0_sp_offset;
>  
> +  /* Similar, but the value passed to _mcount.  */
> +  HOST_WIDE_INT ra_fp_offset;
> +
>    /* The offset of arg_pointer_rtx from the bottom of the frame.  */
>    HOST_WIDE_INT arg_pointer_offset;
>  
> @@ -9616,6 +9619,9 @@ mips_for_each_saved_gpr_and_fpr (HOST_WI
>    for (regno = GP_REG_LAST; regno >= GP_REG_FIRST; regno--)
>      if (BITSET_P (cfun->machine->frame.mask, regno - GP_REG_FIRST))
>        {
> +	/* Record the ra offset for use by mips_function_profiler.  */
> +	if (regno == RETURN_ADDR_REGNUM)
> +	  cfun->machine->frame.ra_fp_offset = offset + sp_offset;
>  	mips_save_restore_reg (word_mode, regno, offset, fn);
>  	offset -= UNITS_PER_WORD;
>        }
> @@ -16088,6 +16094,74 @@ mips_trampoline_init (rtx m_tramp, tree 
>    emit_insn (gen_add3_insn (end_addr, addr, GEN_INT (TRAMPOLINE_SIZE)));
>    emit_insn (gen_clear_cache (addr, end_addr));
>  }
> +
> +/* Implement FUNCTION_PROFILER.  */
> +
> +void mips_function_profiler (FILE *file)
> +{
> +  if (TARGET_MIPS16)
> +    sorry ("mips16 function profiling");
> +  if (TARGET_LONG_CALLS)
> +    {
> +      /*  For TARGET_LONG_CALLS use $3 for the address of _mcount.  */
> +      if (Pmode == DImode)
> +	fprintf (file, "\tdla\t%s,_mcount\n", reg_names[3]);
> +      else
> +	fprintf (file, "\tla\t%s,_mcount\n", reg_names[3]);
> +    }
> +  mips_push_asm_switch (&mips_noat);
> +  fprintf (file, "\tmove\t%s,%s\t\t# save current return address\n",
> +	   reg_names[AT_REGNUM], reg_names[RETURN_ADDR_REGNUM]);
> +  /* _mcount treats $2 as the static chain register.  */
> +  if (cfun->static_chain_decl != NULL)
> +    fprintf (file, "\tmove\t%s,%s\n", reg_names[2],
> +	     reg_names[STATIC_CHAIN_REGNUM]);
> +  if (TARGET_MCOUNT_RAADDR)
> +    {
> +      /* If TARGET_MCOUNT_RAADDR load $12 with the address of the ra save
> +	 location.  */
> +      if (cfun->machine->frame.ra_fp_offset == 0)
> +	/* ra not saved, pass zero.  */
> +	fprintf (file, "\tmove\t%s,%s\t\t# address of ra\n",
> +		 reg_names[12], reg_names[0]);
> +      else if (SMALL_OPERAND (cfun->machine->frame.ra_fp_offset))
> +	fprintf (file,
> +		 "\t%s\t%s,%s," HOST_WIDE_INT_PRINT_DEC "\t\t# address of ra\n",
> +		 Pmode == DImode ? "daddiu" : "addiu",
> +		 reg_names[12], reg_names[STACK_POINTER_REGNUM],
> +		 cfun->machine->frame.ra_fp_offset);
> +      else
> +	{
> +	  fprintf (file,
> +		   "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "\n",
> +		   Pmode == DImode ? "dli" : "li",
> +		   reg_names[12],
> +		   cfun->machine->frame.ra_fp_offset);
> +	  fprintf (file, "\t%s\t%s,%s,%s\t\t# address of ra\n",
> +		   Pmode == DImode ? "daddu" : "addu",
> +		   reg_names[12], reg_names[12],
> +		   reg_names[STACK_POINTER_REGNUM]);
> +	}
> +    }
> +  if (!TARGET_NEWABI)
> +    {
> +      fprintf (file,
> +	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",
> +	       TARGET_64BIT ? "dsubu" : "subu",
> +	       reg_names[STACK_POINTER_REGNUM],
> +	       reg_names[STACK_POINTER_REGNUM],
> +	       Pmode == DImode ? 16 : 8);
> +    }
> +  if (TARGET_LONG_CALLS)
> +    fprintf (file, "\tjalr\t%s\n", reg_names[3]);
> +  else
> +    fprintf (file, "\tjal\t_mcount\n");
> +  mips_pop_asm_switch (&mips_noat);
> +  /* _mcount treats $2 as the static chain register.  */
> +  if (cfun->static_chain_decl != NULL)
> +    fprintf (file, "\tmove\t%s,%s\n", reg_names[STATIC_CHAIN_REGNUM],
> +	     reg_names[2]);
> +}
>  
>  /* Initialize the GCC target structure.  */
>  #undef TARGET_ASM_ALIGNED_HI_OP
> Index: gcc/config/mips/mips.h
> ===================================================================
> --- gcc/config/mips/mips.h	(revision 153502)
> +++ gcc/config/mips/mips.h	(working copy)
> @@ -2372,44 +2372,7 @@ typedef struct mips_args {
>  /* Output assembler code to FILE to increment profiler label # LABELNO
>     for profiling a function entry.  */
>  
> -#define FUNCTION_PROFILER(FILE, LABELNO)				\
> -{									\
> -  if (TARGET_MIPS16)							\
> -    sorry ("mips16 function profiling");				\
> -  if (TARGET_LONG_CALLS)						\
> -    {									\
> -      /*  For TARGET_LONG_CALLS use $3 for the address of _mcount.  */	\
> -      if (Pmode == DImode)						\
> -	fprintf (FILE, "\tdla\t%s,_mcount\n", reg_names[GP_REG_FIRST + 3]); \
> -      else								\
> -	fprintf (FILE, "\tla\t%s,_mcount\n", reg_names[GP_REG_FIRST + 3]); \
> -    }									\
> -  mips_push_asm_switch (&mips_noat);					\
> -  fprintf (FILE, "\tmove\t%s,%s\t\t# save current return address\n",	\
> -	   reg_names[AT_REGNUM], reg_names[RETURN_ADDR_REGNUM]);	\
> -  /* _mcount treats $2 as the static chain register.  */		\
> -  if (cfun->static_chain_decl != NULL)					\
> -    fprintf (FILE, "\tmove\t%s,%s\n", reg_names[2],			\
> -	     reg_names[STATIC_CHAIN_REGNUM]);				\
> -  if (!TARGET_NEWABI)							\
> -    {									\
> -      fprintf (FILE,							\
> -	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n", \
> -	       TARGET_64BIT ? "dsubu" : "subu",				\
> -	       reg_names[STACK_POINTER_REGNUM],				\
> -	       reg_names[STACK_POINTER_REGNUM],				\
> -	       Pmode == DImode ? 16 : 8);				\
> -    }									\
> -  if (TARGET_LONG_CALLS)						\
> -    fprintf (FILE, "\tjalr\t%s\n", reg_names[GP_REG_FIRST + 3]);	\
> -  else									\
> -    fprintf (FILE, "\tjal\t_mcount\n");					\
> -  mips_pop_asm_switch (&mips_noat);					\
> -  /* _mcount treats $2 as the static chain register.  */		\
> -  if (cfun->static_chain_decl != NULL)					\
> -    fprintf (FILE, "\tmove\t%s,%s\n", reg_names[STATIC_CHAIN_REGNUM],	\
> -	     reg_names[2]);						\
> -}
> +#define FUNCTION_PROFILER(FILE, LABELNO) mips_function_profiler ((FILE))
>  
>  /* The profiler preserves all interesting registers, including $31.  */
>  #define MIPS_SAVE_REG_FOR_PROFILING_P(REGNO) false
