Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 11:50:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:36265 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039157AbXBMLtz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 11:49:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DBnYda005887;
	Tue, 13 Feb 2007 11:49:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1D25u0o024231;
	Tue, 13 Feb 2007 02:05:56 GMT
Date:	Tue, 13 Feb 2007 02:05:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, fbuihuu@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Message-ID: <20070213020556.GA5875@linux-mips.org>
References: <20070209210014.GA26939@linux-mips.org> <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com> <20070212140459.GA9679@linux-mips.org> <20070213.002545.03977174.anemo@mba.ocn.ne.jp> <20070213014345.GA30988@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070213014345.GA30988@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 13, 2007 at 01:43:45AM +0000, Ralf Baechle wrote:

> Well, I reverted that the old state of a warning is definately preferable
> until we found a proper solution.

Type-punning should do the trick.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index c12ebc5..36b3a42 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -265,7 +265,10 @@ do {									\
  */
 #define __get_user_asm_ll32(val, addr)					\
 {									\
-        unsigned long long __gu_tmp;					\
+	union {								\
+		unsigned long long	l;				\
+		__typeof__(*(addr))	t;				\
+	} __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
@@ -281,9 +284,10 @@ do {									\
 	"	" __UA_ADDR "	1b, 4b				\n"	\
 	"	" __UA_ADDR "	2b, 4b				\n"	\
 	"	.previous					\n"	\
-	: "=r" (__gu_err), "=&r" (__gu_tmp)				\
+	: "=r" (__gu_err), "=&r" (__gu_tmp.l)				\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
-	(val) = (__typeof__(*(addr))) __gu_tmp;				\
+									\
+	(val) = __gu_tmp.t;						\
 }
 
 /*
