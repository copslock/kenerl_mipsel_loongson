Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15N57522011
	for linux-mips-outgoing; Tue, 5 Feb 2002 15:05:07 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15N4tA21965
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 15:04:55 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 54B88125C8; Tue,  5 Feb 2002 15:04:54 -0800 (PST)
Date: Tue, 5 Feb 2002 15:04:54 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: gcc-patches@gcc.gnu.org,
   "linux-mips @ oss . sgi . com" <linux-mips@oss.sgi.com>
Subject: PATCH: Re: SNaN & QNaN on mips
Message-ID: <20020205150454.A8759@lucon.org>
References: <20020205095056.735A5125C8@ocean.lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205095056.735A5125C8@ocean.lucon.org>; from fxzhang@ict.ac.cn on Tue, Feb 05, 2002 at 05:48:18PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 05:48:18PM +0800, Zhang Fuxin wrote:
> hi,
> 
>   I am sorry but it seems i can't fix this without ugly changes.
> since i am not familiar with gcc code, i decide to leave it to you,
> but provide some information instead.
> 
>   In gcc there are 3 spaces where the NaN handling is assumed the 
> Intel way.
> 
>    1. gcc/real.c (the most important one)
>        here the author seems to have known the NaN pattern problem,so
>      he leaves a interface macro for defining non intel NaN patterns:
>      (comment of function "make_nan()",at about line 6219)
> 
> /* Output a binary NaN bit pattern in the target machine's format.  */
> 
> /* If special NaN bit patterns are required, define them in tm.h
>    as arrays of unsigned 16-bit shorts.  Otherwise, use the default
>    patterns here.  */
> 
>   I have read through this file and decided that the follow defined should
> be enough for mips:
>  
> /* NaN pattern,mips QNAN & SNAN is different from intel's 
>  * DFMODE_NAN and SFMODE_NAN is used in real.c */
> #define DFMODE_NAN \
>         unsigned short DFbignan[4] = {0x7ff7, 0xffff, 0xffff, 0xffff}; \
>         unsigned short DFlittlenan[4] = {0xffff, 0xffff, 0xffff, 0xfff7}
> #define SFMODE_NAN \
>         unsigned short SFbignan[2] = {0x7fbf, 0xffff}; \
>         unsigned short SFlittlenan[2] = {0xffff, 0xffbf}
> 
>    But the problem is where to put them:(. Obviously it is target specified
> definitions and should be in config/mips/. Documents say tm.h is a symbol
> link and included in config.h,but it is no long true.If i add them to xm-mips.h
> then for native compilation it is ok but it fails for cross-compile.

I am enclosing a patch here.

> 
>    2.gcc/reg-stack.c
>      There is a hardcoded QNaN used around line 477:
>       nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
>      I sugest defining a macro QNAN_HAS_1ST_FRACBIT_CLEARED for mips and change
>      it to,just don't know where to put it:
>       #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
>          nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
>       #else
>          nan = gen_lowpart (SFmode, GEN_INT (0x7fbfffff));
>       #endif

MIPS doesn't use reg-stack.c.

> 
>    3. config/fp-bit.c
>       this is for machine having no fpu hardware.
>       again i susgest define QNAN_HAS_1ST_FRACBIT_CLEARED and then apply this patch:
> 
> 190d189
> < #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
> 192,195d190
> < #else
> <         fraction &= ~QUIET_NAN;
> < #endif
> < 
> 379,380d373
> < 
> < #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
> 382,384d374
> < #else
> <         if (!(fraction & QUIET_NAN))
> < #endif


This one is tricky. fp-bit.c is not supposed to be target specific. I
think we add SET_QUIET_NAN/IS_QUIET_NAN and provide the special ones
for MIPS.


H.J.
----
2002-02-05  H.J. Lu <hjl@gnu.org>

	Base on suggestions from Zhang Fuxin <fxzhang@ict.ac.cn>:

	* config/mips/mips.h (DFMODE_NAN): Defined.
	(SFMODE_NAN): Likewise.

--- gcc/config/mips/mips.h.ieee	Thu Nov 15 12:21:17 2001
+++ gcc/config/mips/mips.h	Tue Feb  5 14:38:11 2002
@@ -4637,3 +4637,10 @@ do									\
       }									\
   }									\
 while (0)
+
+#define DFMODE_NAN \
+	unsigned short DFbignan[4] = {0x7ff7, 0xffff, 0xffff, 0xffff}; \
+	unsigned short DFlittlenan[4] = {0xffff, 0xffff, 0xffff, 0xfff7}
+#define SFMODE_NAN \
+	unsigned short SFbignan[2] = {0x7fbf, 0xffff}; \
+	unsigned short SFlittlenan[2] = {0xffff, 0xffbf}
