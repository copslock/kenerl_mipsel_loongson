Received:  by oss.sgi.com id <S305158AbQBPJr7>;
	Wed, 16 Feb 2000 01:47:59 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:54843 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPJr3>;
	Wed, 16 Feb 2000 01:47:29 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA01309; Wed, 16 Feb 2000 01:42:58 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA62798; Wed, 16 Feb 2000 01:47:28 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA31576
	for linux-list;
	Wed, 16 Feb 2000 01:35:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA48656
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 16 Feb 2000 01:35:07 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA00500
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 01:35:07 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from mail3.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (02/04/00) with ESMTP id SAA29351
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 18:35:01 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (3.7W99051310c) with ESMTP id SAA04398
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 18:35:01 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id SAA02246 for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 18:34:59 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id SAA20704 for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 18:34:30 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id SAA24425; Wed, 16 Feb 2000 18:34:30 +0900 (JST)
To:     linux@cthulhu.engr.sgi.com
Subject: Question about copy_from_user()
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000216183429L.machida@sm.sony.co.jp>
Date:   Wed, 16 Feb 2000 18:34:29 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi.

I think I found a redundant code in copy_from_user() and
__copy_from_user() at current CVS asm-mips/uaccess.h.

I think '*'-marked part in the definiton is obsolete and
redundant. It had to used in the exception fixup routine as
commented at arch/mips/lib/memcpy.S. (Of course the comment is also
obsolete, I think.)

#define __copy_from_user(to,from,n) ({ \
	void *__cu_to; \
	const void *__cu_from; \
	long __cu_len; \
	\
	__cu_to = (to); \
	__cu_from = (from); \
	__cu_len = (n); \
	__asm__ __volatile__( \
		"move\t$4, %1\n\t" \
		"move\t$5, %2\n\t" \
		"move\t$6, %3\n\t" \
*		".set\tnoat\n\t" \
*		"addu\t$1, %2, %3\n\t" \
*		".set\tat\n\t" \
		__MODULE_JAL(__copy_user) \
		"move\t%0, $6" \
		: "=r" (__cu_len) \
		: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
		: "$4", "$5", "$6", "$8", "$9", "$10", "$11", "$12", "$15", \
		  "$24", "$31","memory"); \
	__cu_len; \
})

(Even if $1 is still used at the exception fixup routine, when
MODULE is defined, __MODULE_JAL will overwrite $1 at the next line.)

Is my concern correct? Please let me know.

Thanks.
---
Hiroyuki Machida
Creative Station		SCE Inc./Sony Corp.
