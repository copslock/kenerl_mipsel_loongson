Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g159p8609646
	for linux-mips-outgoing; Tue, 5 Feb 2002 01:51:08 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g159owA09632
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 01:50:58 -0800
Message-Id: <200202050950.g159owA09632@oss.sgi.com>
Received: (qmail 5848 invoked from network); 5 Feb 2002 09:51:27 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 5 Feb 2002 09:51:27 -0000
Date: Tue, 5 Feb 2002 17:48:18 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "H . J . Lu" <hjl@lucon.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: SNaN & QNaN on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g159owA09633
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

  I am sorry but it seems i can't fix this without ugly changes.
since i am not familiar with gcc code, i decide to leave it to you,
but provide some information instead.

  In gcc there are 3 spaces where the NaN handling is assumed the 
Intel way.

   1. gcc/real.c (the most important one)
       here the author seems to have known the NaN pattern problem,so
     he leaves a interface macro for defining non intel NaN patterns:
     (comment of function "make_nan()",at about line 6219)

/* Output a binary NaN bit pattern in the target machine's format.  */

/* If special NaN bit patterns are required, define them in tm.h
   as arrays of unsigned 16-bit shorts.  Otherwise, use the default
   patterns here.  */

  I have read through this file and decided that the follow defined should
be enough for mips:
 
/* NaN pattern,mips QNAN & SNAN is different from intel's 
 * DFMODE_NAN and SFMODE_NAN is used in real.c */
#define DFMODE_NAN \
        unsigned short DFbignan[4] = {0x7ff7, 0xffff, 0xffff, 0xffff}; \
        unsigned short DFlittlenan[4] = {0xffff, 0xffff, 0xffff, 0xfff7}
#define SFMODE_NAN \
        unsigned short SFbignan[2] = {0x7fbf, 0xffff}; \
        unsigned short SFlittlenan[2] = {0xffff, 0xffbf}

   But the problem is where to put them:(. Obviously it is target specified
definitions and should be in config/mips/. Documents say tm.h is a symbol
link and included in config.h,but it is no long true.If i add them to xm-mips.h
then for native compilation it is ok but it fails for cross-compile.

   2.gcc/reg-stack.c
     There is a hardcoded QNaN used around line 477:
      nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
     I sugest defining a macro QNAN_HAS_1ST_FRACBIT_CLEARED for mips and change
     it to,just don't know where to put it:
      #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
         nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
      #else
         nan = gen_lowpart (SFmode, GEN_INT (0x7fbfffff));
      #endif

   3. config/fp-bit.c
      this is for machine having no fpu hardware.
      again i susgest define QNAN_HAS_1ST_FRACBIT_CLEARED and then apply this patch:

190d189
< #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
192,195d190
< #else
<         fraction &= ~QUIET_NAN;
< #endif
< 
379,380d373
< 
< #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
382,384d374
< #else
<         if (!(fraction & QUIET_NAN))
< #endif
     
 
ÔÚ 2002-02-03 22:54:00 you wrote£º
>On Mon, Feb 04, 2002 at 02:22:48PM +0800, Zhang Fuxin wrote:
>> hi,
>> 
>> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
>> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
>> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>>  say so.And experiments confirm this.
>> 
>> Should we correct it?
>
>Yes. Do you have a patch?
>
>Thanks.
>
>
>H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
