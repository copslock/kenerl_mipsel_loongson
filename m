Received:  by oss.sgi.com id <S554369AbRB0OkV>;
	Tue, 27 Feb 2001 06:40:21 -0800
Received: from enst.enst.fr ([137.194.2.16]:11502 "HELO enst.enst.fr")
	by oss.sgi.com with SMTP id <S554365AbRB0OkQ>;
	Tue, 27 Feb 2001 06:40:16 -0800
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP id 085BB1C918
	for <linux-mips@oss.sgi.com>; Tue, 27 Feb 2001 15:40:14 +0100 (MET)
Received: from donjuan.enst.fr (donjuan.enst.fr [137.194.168.21])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id PAA00253
	for <linux-mips@oss.sgi.com>; Tue, 27 Feb 2001 15:40:13 +0100 (MET)
Received: from localhost (bellard@localhost)
	by donjuan.enst.fr (8.9.3+Sun/8.9.3) with SMTP id PAA22829
	for <linux-mips@oss.sgi.com>; Tue, 27 Feb 2001 15:40:11 +0100 (MET)
Date:   Tue, 27 Feb 2001 15:40:11 +0100 (MET)
From:   Fabrice Bellard <bellard@email.enst.fr>
To:     linux-mips@oss.sgi.com
Subject: Serious bug in uaccess.h
Message-ID: <Pine.GSO.4.02.10102271534030.22188-100000@donjuan.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi!

I found a serious bug in the assembler macros in asm-mips/uaccess.h. They
all do something like that:

		__asm__ __volatile__( \
			"move\t$4, %1\n\t" \
			"move\t$5, %2\n\t" \
			"move\t$6, %3\n\t" \
			".set\tnoreorder\n\t" \
			__MODULE_JAL(__copy_user) \
...

The problem is that you cannot assume that gcc will not put %1, %2 or %3
in registers different from $4, $5 or $6. For example, if %2 is put in $4,
the code is incorrect. (With gcc-2.95.2 I got a bug in
generic_file_write!).

Did someone already fixed this bug ?

A possible fix would be to use asm registers:

#define copy_from_user(to,from,n) ({ \
	register void *__cu_to asm("$4"); \
	register const void *__cu_from asm("$5"); \
	register long __cu_len asm("$6"); \
	\
	__cu_to = (to); \
	__cu_from = (from); \
	__cu_len = (n); \
	if (access_ok(VERIFY_READ, __cu_from, __cu_len)) \
		__asm__ __volatile__( \
			".set\tnoreorder\n\t" \
			__MODULE_JAL(__copy_user) \
...

But I am not sure that it is always correct. Any idea ?

Fabrice.
