Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA98903 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Jul 1998 07:15:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA57183
	for linux-list;
	Wed, 1 Jul 1998 07:15:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA19813
	for <linux@engr.sgi.com>;
	Wed, 1 Jul 1998 07:15:11 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04565
	for <linux@engr.sgi.com>; Wed, 1 Jul 1998 07:15:10 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id HAA10514
	for <linux@engr.sgi.com>; Wed, 1 Jul 1998 07:15:08 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by dredd.mcom.com
          (Netscape Messaging Server 3.52)  with ESMTP id AAA377A
          for <linux@engr.sgi.com>; Wed, 1 Jul 1998 07:15:07 -0700
Message-ID: <359A447B.2D25377D@netscape.com>
Date: Wed, 01 Jul 1998 10:15:23 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.06 [en] (X11; I; Linux 2.0.34 i686)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: mozilla on the Indy
Content-Type: multipart/mixed; boundary="------------86403D215537936A11F8BCA8"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------86403D215537936A11F8BCA8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It builds.
It links (now that Alex made lesstif go, and I fixed up xpm).
It crashes very early in the startup.

I think it's probably something in the NSPR thread initialization, but
I'll have to build some test stuff to be sure.  The files I've changed
that matter (not Makefiles and link lines, but actual source) are
attached, and are the likely source of my problems.  Since the final
mostly-static link takes about 40 minutes, experimentation is expensive.

I'm also taking donations of gdb.

Mike

-- 
73275.46 64180.31
--------------86403D215537936A11F8BCA8
Content-Type: text/plain; charset=us-ascii; name="_linux.cfg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="_linux.cfg"

/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/*
 * The contents of this file are subject to the Netscape Public License
 * Version 1.0 (the "NPL"); you may not use this file except in
 * compliance with the NPL.  You may obtain a copy of the NPL at
 * http://www.mozilla.org/NPL/
 * 
 * Software distributed under the NPL is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the NPL
 * for the specific language governing rights and limitations under the
 * NPL.
 * 
 * The Initial Developer of this code under the NPL is Netscape
 * Communications Corporation.  Portions created by Netscape are
 * Copyright (C) 1998 Netscape Communications Corporation.  All Rights
 * Reserved.
 */

#ifndef nspr_cpucfg___
#define nspr_cpucfg___

#ifndef XP_UNIX
#define XP_UNIX
#endif

#ifndef LINUX
#define LINUX
#endif

#ifdef __powerpc__

#undef  IS_LITTLE_ENDIAN
#define IS_BIG_ENDIAN    1

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   4
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   4
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    32
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    32

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   5
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   5

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     4
#define PR_ALIGN_OF_LONG    4
#define PR_ALIGN_OF_INT64   4
#define PR_ALIGN_OF_FLOAT   4
#define PR_ALIGN_OF_DOUBLE  4
#define PR_ALIGN_OF_POINTER 4

#define PR_BYTES_PER_WORD_LOG2   2
#define PR_BYTES_PER_DWORD_LOG2  3

#elif defined(__alpha)

#define IS_LITTLE_ENDIAN 1
#undef  IS_BIG_ENDIAN
#define IS_64

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   8
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   8
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    64
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    64

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   6
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   6

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     4
#define PR_ALIGN_OF_LONG    8
#define PR_ALIGN_OF_INT64   8
#define PR_ALIGN_OF_FLOAT   4
#define PR_ALIGN_OF_DOUBLE  8
#define PR_ALIGN_OF_POINTER 8

#define PR_BYTES_PER_WORD_LOG2  3
#define PR_BYTES_PER_DWORD_LOG2 3

#elif defined(__mc68000__)

#undef  IS_LITTLE_ENDIAN
#define IS_BIG_ENDIAN 1

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   4
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   4
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    32
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    32

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   5
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   5

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     2
#define PR_ALIGN_OF_LONG    2
#define PR_ALIGN_OF_INT64   2
#define PR_ALIGN_OF_FLOAT   2
#define PR_ALIGN_OF_DOUBLE  2
#define PR_ALIGN_OF_POINTER 2

#define PR_BYTES_PER_WORD_LOG2   2
#define PR_BYTES_PER_DWORD_LOG2  3

#elif defined(__sparc__)

#undef	IS_LITTLE_ENDIAN
#define	IS_BIG_ENDIAN 1

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   4
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   4
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    32
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    32

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   5
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   5

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     4
#define PR_ALIGN_OF_LONG    4
#define PR_ALIGN_OF_INT64   8
#define PR_ALIGN_OF_FLOAT   4
#define PR_ALIGN_OF_DOUBLE  8
#define PR_ALIGN_OF_POINTER 4

#define PR_BYTES_PER_WORD_LOG2   2
#define PR_BYTES_PER_DWORD_LOG2  3

#elif defined(__i386__)

#define IS_LITTLE_ENDIAN 1
#undef  IS_BIG_ENDIAN

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   4
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   4
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    32
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    32

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   5
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   5

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     4
#define PR_ALIGN_OF_LONG    4
#define PR_ALIGN_OF_INT64   4
#define PR_ALIGN_OF_FLOAT   4
#define PR_ALIGN_OF_DOUBLE  4
#define PR_ALIGN_OF_POINTER 4

#define PR_BYTES_PER_WORD_LOG2   2
#define PR_BYTES_PER_DWORD_LOG2  3

#elif defined(__mips__)

#ifdef __MIPSEB__
#define IS_BIG_ENDIAN 1
#undef  IS_LITTLE_ENDIAN
#elif defined(__MIPSEL__
#define IS_LITTLE_ENDIAN 1
#undef  IS_BIG_ENDIAN
#else
#error "Unknown MIPS endianness."
#endif

#define PR_BYTES_PER_BYTE   1
#define PR_BYTES_PER_SHORT  2
#define PR_BYTES_PER_INT    4
#define PR_BYTES_PER_INT64  8
#define PR_BYTES_PER_LONG   4
#define PR_BYTES_PER_FLOAT  4
#define PR_BYTES_PER_DOUBLE 8
#define PR_BYTES_PER_WORD   4
#define PR_BYTES_PER_DWORD  8

#define PR_BITS_PER_BYTE    8
#define PR_BITS_PER_SHORT   16
#define PR_BITS_PER_INT     32
#define PR_BITS_PER_INT64   64
#define PR_BITS_PER_LONG    32
#define PR_BITS_PER_FLOAT   32
#define PR_BITS_PER_DOUBLE  64
#define PR_BITS_PER_WORD    32

#define PR_BITS_PER_BYTE_LOG2   3
#define PR_BITS_PER_SHORT_LOG2  4
#define PR_BITS_PER_INT_LOG2    5
#define PR_BITS_PER_INT64_LOG2  6
#define PR_BITS_PER_LONG_LOG2   5
#define PR_BITS_PER_FLOAT_LOG2  5
#define PR_BITS_PER_DOUBLE_LOG2 6
#define PR_BITS_PER_WORD_LOG2   5

#define PR_ALIGN_OF_SHORT   2
#define PR_ALIGN_OF_INT     4
#define PR_ALIGN_OF_LONG    4
#define PR_ALIGN_OF_INT64   4
#define PR_ALIGN_OF_FLOAT   4
#define PR_ALIGN_OF_DOUBLE  4
#define PR_ALIGN_OF_POINTER 4

#define PR_BYTES_PER_WORD_LOG2   2
#define PR_BYTES_PER_DWORD_LOG2  3

#else
#error "Unknown CPU architecture"

#endif

#define	HAVE_LONG_LONG
/*
 * XXX These two macros need to be investigated for different architectures.
 */
#undef	HAVE_ALIGNED_DOUBLES
#undef	HAVE_ALIGNED_LONGLONGS

#ifndef NO_NSPR_10_SUPPORT

#define BYTES_PER_BYTE		PR_BYTES_PER_BYTE
#define BYTES_PER_SHORT 	PR_BYTES_PER_SHORT
#define BYTES_PER_INT 		PR_BYTES_PER_INT
#define BYTES_PER_INT64		PR_BYTES_PER_INT64
#define BYTES_PER_LONG		PR_BYTES_PER_LONG
#define BYTES_PER_FLOAT		PR_BYTES_PER_FLOAT
#define BYTES_PER_DOUBLE	PR_BYTES_PER_DOUBLE
#define BYTES_PER_WORD		PR_BYTES_PER_WORD
#define BYTES_PER_DWORD		PR_BYTES_PER_DWORD

#define BITS_PER_BYTE		PR_BITS_PER_BYTE
#define BITS_PER_SHORT		PR_BITS_PER_SHORT
#define BITS_PER_INT		PR_BITS_PER_INT
#define BITS_PER_INT64		PR_BITS_PER_INT64
#define BITS_PER_LONG		PR_BITS_PER_LONG
#define BITS_PER_FLOAT		PR_BITS_PER_FLOAT
#define BITS_PER_DOUBLE		PR_BITS_PER_DOUBLE
#define BITS_PER_WORD		PR_BITS_PER_WORD

#define BITS_PER_BYTE_LOG2	PR_BITS_PER_BYTE_LOG2
#define BITS_PER_SHORT_LOG2	PR_BITS_PER_SHORT_LOG2
#define BITS_PER_INT_LOG2	PR_BITS_PER_INT_LOG2
#define BITS_PER_INT64_LOG2	PR_BITS_PER_INT64_LOG2
#define BITS_PER_LONG_LOG2	PR_BITS_PER_LONG_LOG2
#define BITS_PER_FLOAT_LOG2	PR_BITS_PER_FLOAT_LOG2
#define BITS_PER_DOUBLE_LOG2 	PR_BITS_PER_DOUBLE_LOG2
#define BITS_PER_WORD_LOG2	PR_BITS_PER_WORD_LOG2

#define ALIGN_OF_SHORT		PR_ALIGN_OF_SHORT
#define ALIGN_OF_INT		PR_ALIGN_OF_INT
#define ALIGN_OF_LONG		PR_ALIGN_OF_LONG
#define ALIGN_OF_INT64		PR_ALIGN_OF_INT64
#define ALIGN_OF_FLOAT		PR_ALIGN_OF_FLOAT
#define ALIGN_OF_DOUBLE		PR_ALIGN_OF_DOUBLE
#define ALIGN_OF_POINTER	PR_ALIGN_OF_POINTER
#define ALIGN_OF_WORD		PR_ALIGN_OF_WORD

#define BYTES_PER_WORD_LOG2	PR_BYTES_PER_WORD_LOG2
#define BYTES_PER_DWORD_LOG2	PR_BYTES_PER_DWORD_LOG2
#define WORDS_PER_DWORD_LOG2	PR_WORDS_PER_DWORD_LOG2

#endif /* NO_NSPR_10_SUPPORT */

#endif /* nspr_cpucfg___ */

--------------86403D215537936A11F8BCA8
Content-Type: text/plain; charset=us-ascii; name="_linux.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="_linux.h"

/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/*
 * The contents of this file are subject to the Netscape Public License
 * Version 1.0 (the "NPL"); you may not use this file except in
 * compliance with the NPL.  You may obtain a copy of the NPL at
 * http://www.mozilla.org/NPL/
 * 
 * Software distributed under the NPL is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the NPL
 * for the specific language governing rights and limitations under the
 * NPL.
 * 
 * The Initial Developer of this code under the NPL is Netscape
 * Communications Corporation.  Portions created by Netscape are
 * Copyright (C) 1998 Netscape Communications Corporation.  All Rights
 * Reserved.
 */

#ifndef nspr_linux_defs_h___
#define nspr_linux_defs_h___

#include "prthread.h"

/*
 * Internal configuration macros
 */

#define PR_LINKER_ARCH	"linux"
#define _PR_SI_SYSNAME  "LINUX"
#ifdef __powerpc__
#define _PR_SI_ARCHITECTURE "ppc"
#elif defined(__alpha)
#define _PR_SI_ARCHITECTURE "alpha"
#elif defined(__mc68000__)
#define _PR_SI_ARCHITECTURE "m68k"
#elif defined(__sparc__)
#define _PR_SI_ARCHITECTURE "sparc"
#elif defined(__i386__)
#define _PR_SI_ARCHITECTURE "x86"
#elif defined(__mips__)
#define _PR_SI_ARCHITECTURE "mips"
#else
#error "Unknown CPU architecture"
#endif
#define PR_DLL_SUFFIX		".so"

#define _PR_VMBASE              0x30000000
#define _PR_STACK_VMBASE	0x50000000
#define _MD_DEFAULT_STACK_SIZE	65536L
#define _MD_MMAP_FLAGS          MAP_PRIVATE

#undef	HAVE_STACK_GROWING_UP

/*
 * Elf linux supports dl* functions
 */
#define HAVE_DLL
#define USE_DLFCN

#if !defined(MKLINUX) && !defined(NEED_TIME_R)
#define NEED_TIME_R
#endif

#define USE_SETJMP

#ifdef _PR_PTHREADS

extern void _MD_CleanupBeforeExit(void);
#define _MD_CLEANUP_BEFORE_EXIT _MD_CleanupBeforeExit

#else  /* ! _PR_PTHREADS */

#include <setjmp.h>

#define PR_CONTEXT_TYPE	sigjmp_buf

#define CONTEXT(_th) ((_th)->md.context)

#ifdef __powerpc__
/* PowerPC based MkLinux */
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__misc[0]
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
/* aix = 64, macos = 70 */
#define PR_NUM_GCREGS  64

#elif defined(__alpha)
/* Alpha based Linux */

#if defined(__GLIBC__) && __GLIBC__ >= 2
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[JB_SP]
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
#define _MD_SP_TYPE long int
#else
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__sp
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
#define _MD_SP_TYPE __ptr_t
#endif /* defined(__GLIBC__) && __GLIBC__ >= 2 */

/* XXX not sure if this is correct, or maybe it should be 17? */
#define PR_NUM_GCREGS 9

#elif defined(__mc68000__)
/* m68k based Linux */

/*
 * On the m68k, glibc still uses the old style sigjmp_buf, even
 * in glibc 2.0.7.
 */
#if defined(__GLIBC__) && __GLIBC__ >= 2
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__sp
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
#else
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__sp
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
#endif /* defined(__GLIBC__) && __GLIBC__ >= 2 */

/* XXX not sure if this is correct, or maybe it should be 17? */
#define PR_NUM_GCREGS 9

#elif defined(__sparc__)
/* Sparc */
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__fp
#define _MD_SET_FP(_t, val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) ((void *) 0)
#define _MD_SP_TYPE __ptr_t

#elif defined(__i386__)
/* Intel based Linux */
#if defined(__GLIBC__) && __GLIBC__ >= 2
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[JB_SP]
#define _MD_SET_FP(_t, val) ((_t)->md.context[0].__jmpbuf[JB_BP] = val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) (&(_t)->md.context[0].__jmpbuf[JB_BP])
#define _MD_SP_TYPE int
#else
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__sp
#define _MD_SET_FP(_t, val) ((_t)->md.context[0].__jmpbuf[0].__bp = val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) &((_t)->md.context[0].__jmpbuf[0].__bp)
#define _MD_SP_TYPE __ptr_t
#endif /* defined(__GLIBC__) && __GLIBC__ >= 2 */
#define PR_NUM_GCREGS   6

#elif defined(__mips)
/* Linux/MIPS */
#if defined(__GLIBC__) && __GLIBC__ >= 2
#define _MD_GET_SP(_t) (_t)->md.context[0].__jmpbuf[0].__sp
#define _MD_SET_FP(_t, val) ((_t)->md.context[0].__jmpbuf[0].__fp = val)
#define _MD_GET_SP_PTR(_t) &(_MD_GET_SP(_t))
#define _MD_GET_FP_PTR(_t) (&(_t)->md.context[0].__jmpbuf[0].__fp)
#define _MD_SP_TYPE __ptr_t
#else
#error "Linux/MIPS pre glibc2 not supported yet (hack away!)"
#endif /* defined(__GLIBC__) && __GLIBC__ >= 2 */
#else

#error "Unknown CPU architecture"

#endif /*__powerpc__*/

/*
** Initialize a thread context to run "_main()" when started
*/
#ifdef __powerpc__

#define _MD_INIT_CONTEXT(_thread, _sp, _main, status)  \
{  \
    *status = PR_TRUE;  \
    if (sigsetjmp(CONTEXT(_thread), 1)) {  \
        _main();  \
    }  \
    _MD_GET_SP(_thread) = (unsigned char*) ((_sp) - 128); \
	_thread->md.sp = _MD_GET_SP_PTR(_thread); \
	_thread->md.fp = _MD_GET_FP_PTR(_thread); \
    _MD_SET_FP(_thread, 0); \
}

#else

#define _MD_INIT_CONTEXT(_thread, _sp, _main, status)  \
{  \
    *status = PR_TRUE;  \
    if (sigsetjmp(CONTEXT(_thread), 1)) {  \
        _main();  \
    }  \
    _MD_GET_SP(_thread) = (_MD_SP_TYPE) ((_sp) - 64); \
	_thread->md.sp = _MD_GET_SP_PTR(_thread); \
	_thread->md.fp = _MD_GET_FP_PTR(_thread); \
    _MD_SET_FP(_thread, 0); \
}

#endif /*__powerpc__*/

#define _MD_SWITCH_CONTEXT(_thread)  \
    if (!sigsetjmp(CONTEXT(_thread), 1)) {  \
	(_thread)->md.errcode = errno;  \
	_PR_Schedule();  \
    }

/*
** Restore a thread context, saved by _MD_SWITCH_CONTEXT
*/
#define _MD_RESTORE_CONTEXT(_thread) \
{   \
    errno = (_thread)->md.errcode;  \
    _MD_SET_CURRENT_THREAD(_thread);  \
    siglongjmp(CONTEXT(_thread), 1);  \
}

/* Machine-dependent (MD) data structures */

struct _MDThread {
    PR_CONTEXT_TYPE context;
	void *sp;
	void *fp;
    int id;
    int errcode;
};

struct _MDThreadStack {
    PRInt8 notused;
};

struct _MDLock {
    PRInt8 notused;
};

struct _MDSemaphore {
    PRInt8 notused;
};

struct _MDCVar {
    PRInt8 notused;
};

struct _MDSegment {
    PRInt8 notused;
};

struct _MDCPU {
	struct _MDCPU_Unix md_unix;
};

#define _MD_INIT_LOCKS()
#define _MD_NEW_LOCK(lock) PR_SUCCESS
#define _MD_FREE_LOCK(lock)
#define _MD_LOCK(lock)
#define _MD_UNLOCK(lock)
#define _MD_INIT_IO()
#define _MD_IOQ_LOCK()
#define _MD_IOQ_UNLOCK()

extern PRStatus _MD_InitializeThread(PRThread *thread);

#define _MD_INIT_RUNNING_CPU(cpu)       _MD_unix_init_running_cpu(cpu)
#define _MD_INIT_THREAD                 _MD_InitializeThread
#define _MD_EXIT_THREAD(thread)
#define _MD_SUSPEND_THREAD(thread)      _MD_suspend_thread
#define _MD_RESUME_THREAD(thread)       _MD_resume_thread
#define _MD_CLEAN_THREAD(_thread)

extern PRStatus _MD_CREATE_THREAD(
    PRThread *thread,
    void (*start) (void *),
    PRThreadPriority priority,
    PRThreadScope scope,
    PRThreadState state,
    PRUint32 stackSize);
extern void _MD_SET_PRIORITY(struct _MDThread *thread, PRUintn newPri);
extern PRStatus _MD_WAIT(PRThread *, PRIntervalTime timeout);
extern PRStatus _MD_WAKEUP_WAITER(PRThread *);
extern void _MD_YIELD(void);

#endif /* ! _PR_PTHREADS */

extern void _MD_EarlyInit(void);
extern PRIntervalTime _PR_UNIX_GetInterval(void);
extern PRIntervalTime _PR_UNIX_TicksPerSecond(void);

#define _MD_EARLY_INIT                  _MD_EarlyInit
#define _MD_FINAL_INIT					_PR_UnixInit
#define _MD_GET_INTERVAL                _PR_UNIX_GetInterval
#define _MD_INTERVAL_PER_SEC            _PR_UNIX_TicksPerSecond

/*
 * We wrapped the select() call.  _MD_SELECT refers to the built-in,
 * unwrapped version.
 */
#define _MD_SELECT __select

#ifdef _PR_POLL_AVAILABLE
#include <poll.h>
extern int __syscall_poll(struct pollfd *ufds, unsigned long int nfds,
	int timeout);
#define _MD_POLL __syscall_poll
#endif

/* For writev() */
#include <sys/uio.h>

#endif /* nspr_linux_defs_h___ */

--------------86403D215537936A11F8BCA8--
