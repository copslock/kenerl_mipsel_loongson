Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jan 2004 12:01:29 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:15353 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225259AbUADMB3>; Sun, 4 Jan 2004 12:01:29 +0000
Received: from localhost (p2085-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.85])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1874D584D; Sun,  4 Jan 2004 21:01:25 +0900 (JST)
Date: Sun, 04 Jan 2004 21:05:32 +0900 (JST)
Message-Id: <20040104.210532.74756709.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: dimitri@sonycom.com, linux-mips@linux-mips.org
Subject: Re: access_ok and CONFIG_MIPS32 for 2.6
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040102194403.GB31092@linux-mips.org>
References: <20040102145941.GA13426@sonycom.com>
	<20040102194403.GB31092@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 2 Jan 2004 20:44:03 +0100, Ralf Baechle <ralf@linux-mips.org> said:

>> Does anybody know why TASK_SIZE is set to 0x7fff8000 and not
>> 0x80000000 ?

ralf> There is a weird special case were 32-bit code running on a
ralf> 64-bit kernel with c0_status.ux set will behave differently than
ralf> on a 32-bit processor or with c0_status.ux clear.  The
ralf> workaround for 64-bit kernels is to leave the top 32kB of the
ralf> 2GB user virtual address space unused.  For sake of symmetry we
ralf> do this on both 32-bit and 64-bit kernels.

Then, access_ok in 2.6 tree is broken, isn't it?

2.4 mips:
#define TASK_SIZE	0x7fff8000UL
#define USER_DS		((mm_segment_t) { (unsigned long) -1L })

2.4 mips64:
#define TASK_SIZE32	   0x7fff8000UL
#define TASK_SIZE	0x10000000000UL
#define USER_DS		((mm_segment_t) { -TASK_SIZE })

2.6:
#ifdef CONFIG_MIPS32
#define TASK_SIZE	0x7fff8000UL
#else
#define TASK_SIZE32	0x7fff8000UL
#define TASK_SIZE	0x10000000000UL
#endif
#define USER_DS		((mm_segment_t) { -TASK_SIZE })

It seems there should be another definition of USER_DS for
CONFIG_MIPS32 in 2.6.


BTW, there are another problems in uaccess.h as I wrote in
http://www.linux-mips.org/archives/linux-mips/2003-09/msg00035.html.

First, 2.4 mips64 __ua_size is broken.

2.4 mips:
#define __ua_size(size)							\
	(__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
2.4 mips64:
#define __ua_size(size)							\
	((__builtin_constant_p(size) && (size)) > 0 ? 0 : (size))
2.6:
#define __ua_size(size)							\
	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))

2.4 mips and 2.6 are identical except for parenthesis.


Second, __access_ok for 64bit kernel is broken both 2.4 and 2.6.  It
returns 0 if 'addr' + 'size' == TASK_SIZE (which should be OK).

2.4 mips64:
#define __access_ok(addr, size, mask)					\
	(((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
2.6:
#define __access_ok(addr, size, mask)					\
	(((signed long)((mask) & ((addr) | ((addr) + (size)) | __ua_size(size)))) == 0)

I think these macros should be:

2.4 mips64:
#define __access_ok(addr, size, mask)					\
	(((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size))) == 0)
2.6:
#define __access_ok(addr, size, mask)					\
	(((signed long)((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size)))) == 0)

---
Atsushi Nemoto
