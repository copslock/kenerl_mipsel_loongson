Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K1ngF00776
	for linux-mips-outgoing; Tue, 19 Feb 2002 17:49:42 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K1nT900770
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 17:49:29 -0800
Message-Id: <200202200149.g1K1nT900770@oss.sgi.com>
Received: (qmail 31397 invoked from network); 20 Feb 2002 00:52:16 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 20 Feb 2002 00:52:16 -0000
Date: Wed, 20 Feb 2002 8:46:40 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: math broken on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1K1nT900771
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
   a quick example:
 main()
{
   float t,zero=0.0;
   t = 0.0/0.0;
   printf("t=%08lx\n",*(unsigned long*)&t); (0x7fc00000)
   t = zero/zero;
   printf("t=%08lx\n",*(unsigned long*)&t); (0x7fbfffff)
}

you should see different output,because the first one is optimized by gcc to 
a QNaN,but it's signalling for MIPS.


ÔÚ 2002-02-19 16:37:00 you wrote£º
>Hello Zhang,
>
>I am going to test your reported bugs on the current SDE compiler.
>
>Do you have some test example for the first problem (Nan handling)?  
>If you have found it in the sources, and that source is actually being
>used by the MIPS compiler generated, it must be possible to provide
>a small example showing wrong behaviour from the compiler?
>
>/Hartvig
>
>
>Zhang Fuxin writes:
>> 
>> hi,
>>     I find that you are asking only gcc related parts,that is related less,
>> here they are(from posts on linux-mips,i cc them to the list in case it is
>> useful,sorry if it brings you inconvenience):
>> 
>> 1.about NaN handling
>> -----------------begin of the first problem--------------------------------
>> I am sorry but it seems i can't fix this without ugly changes.
>> since i am not familiar with gcc code, i decide to leave it to you,
>> but provide some information instead.
>> 
>>   In gcc there are 3 spaces where the NaN handling is assumed the 
>> Intel way.
>> 
>>    1. gcc/real.c (the most important one)
>>        here the author seems to have known the NaN pattern problem,so
>>      he leaves a interface macro for defining non intel NaN patterns:
>>      (comment of function "make_nan()",at about line 6219)
>> 
>> /* Output a binary NaN bit pattern in the target machine's format.  */
>> 
>> /* If special NaN bit patterns are required, define them in tm.h
>>    as arrays of unsigned 16-bit shorts.  Otherwise, use the default
>>    patterns here.  */
>> 
>>   I have read through this file and decided that the follow defined should
>> be enough for mips:
>>  
>> /* NaN pattern,mips QNAN & SNAN is different from intel's 
>>  * DFMODE_NAN and SFMODE_NAN is used in real.c */
>> #define DFMODE_NAN \
>>         unsigned short DFbignan[4] = {0x7ff7, 0xffff, 0xffff, 0xffff}; \
>>         unsigned short DFlittlenan[4] = {0xffff, 0xffff, 0xffff, 0xfff7}
>> #define SFMODE_NAN \
>>         unsigned short SFbignan[2] = {0x7fbf, 0xffff}; \
>>         unsigned short SFlittlenan[2] = {0xffff, 0xffbf}
>> 
>>    But the problem is where to put them:(. Obviously it is target specified
>> definitions and should be in config/mips/. Documents say tm.h is a symbol
>> link and included in config.h,but it is no long true.If i add them to xm-mips.h
>> then for native compilation it is ok but it fails for cross-compile.
>> 
>>    2.gcc/reg-stack.c (H.J. tell me it is not used on mips)
>>      There is a hardcoded QNaN used around line 477:
>>       nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
>>      I sugest defining a macro QNAN_HAS_1ST_FRACBIT_CLEARED for mips and change
>>      it to,just don't know where to put it:
>>       #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
>>          nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
>>       #else
>>          nan = gen_lowpart (SFmode, GEN_INT (0x7fbfffff));
>>       #endif
>> 
>>    3. config/fp-bit.c (H.J. said it is not mean to target specified)
>>       this is for machine having no fpu hardware.
>>       again i susgest define QNAN_HAS_1ST_FRACBIT_CLEARED and then apply this patch:
>> 
>> 190d189
>> < #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
>> 192,195d190
>> < #else
>> <         fraction &= ~QUIET_NAN;
>> < #endif
>> < 
>> 379,380d373
>> < 
>> < #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
>> 382,384d374
>> < #else
>> <         if (!(fraction & QUIET_NAN))
>> < #endif
>>      
>>  
>> ÔÚ 2002-02-03 22:54:00 you wrote£º
>> >On Mon, Feb 04, 2002 at 02:22:48PM +0800, Zhang Fuxin wrote:
>> >> hi,
>> >> 
>> >> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
>> >> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
>> >> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>> >>  say so.And experiments confirm this.
>> >> 
>> >> Should we correct it?
>> >
>> >Yes. Do you have a patch?
>> >
>> >Thanks.
>> >
>> >
>> >H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
