Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 20:15:46 +0000 (GMT)
Received: from voldemort.codesourcery.com ([65.74.133.5]:16619 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S8133434AbWBGUPd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 20:15:33 +0000
Received: (qmail 15907 invoked by uid 1010); 7 Feb 2006 20:21:14 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,Martin Michlmayr <tbm@cyrius.com>,  MIPS Linux List <linux-mips@linux-mips.org>,  Stuart Anderson <anderson@netsweng.com>,  David Daney <ddaney@avtrex.com>, richard@codesourcery.com
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>,
	David Daney <ddaney@avtrex.com>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
References: <20060123150507.GA18665@linux-mips.org>
Date:	Tue, 07 Feb 2006 20:21:11 +0000
In-Reply-To: <20060123150507.GA18665@linux-mips.org> (Ralf Baechle's message
	of "Mon, 23 Jan 2006 15:05:07 +0000")
Message-ID: <87wtg6c43s.fsf@talisman.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:
> I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> below.

Sorry in advance if this is a dup, but...

This patch caused a miscompilation of the restore_gp_regs() block
in restore_sigcontext().  This was in a 32-bit kernel compiled with
GCC CVS head.

restore_gp_regs() copies 64-bit user fields into 32-bit variables,
and in this combination, the new __get_user_asm_ll32() clobbers too
many registers.  It says:

/*
 * Get a long long 64 using 32 bit registers.
 */
#define __get_user_asm_ll32(val, addr)					\
{									\
	__asm__ __volatile__(						\
	"1:	lw	%1, (%3)				\n"	\
	"2:	lw	%D1, 4(%3)				\n"	\
	"	move	%0, $0					\n"	\
	"3:	.section	.fixup,\"ax\"			\n"	\
	"4:	li	%0, %4					\n"	\
	"	move	%1, $0					\n"	\
	"	move	%D1, $0					\n"	\
	"	j	3b					\n"	\
	"	.previous					\n"	\
	"	.section	__ex_table,\"a\"		\n"	\
	"	" __UA_ADDR "	1b, 4b				\n"	\
	"	" __UA_ADDR "	2b, 4b				\n"	\
	"	.previous					\n"	\
	: "=r" (__gu_err), "=&r" (val)					\
	: "0" (0), "r" (addr), "i" (-EFAULT));				\
}

and this requires val (%1) to be a 64-bit value.  In the case I saw,
gcc was using $3 for the 32-bit val, and wasn't expecting $4 to be
clobbered.

FWIW, the patch below fixes it for me.

Richard


diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 91d813a..1208cae 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -266,6 +266,7 @@ do {									\
  */
 #define __get_user_asm_ll32(val, addr)					\
 {									\
+        unsigned long long __gu_tmp;					\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
 	"2:	lw	%D1, 4(%3)				\n"	\
@@ -280,8 +281,9 @@ do {									\
 	"	" __UA_ADDR "	1b, 4b				\n"	\
 	"	" __UA_ADDR "	2b, 4b				\n"	\
 	"	.previous					\n"	\
-	: "=r" (__gu_err), "=&r" (val)					\
+	: "=r" (__gu_err), "=&r" (__gu_tmp)				\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
+	(val) = __gu_tmp;						\
 }
 
 /*
