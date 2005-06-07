Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2005 12:39:51 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:62985 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224907AbVFGLjf>; Tue, 7 Jun 2005 12:39:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j57BbVKL016081;
	Tue, 7 Jun 2005 12:37:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j57BbVul016080;
	Tue, 7 Jun 2005 12:37:31 +0100
Date:	Tue, 7 Jun 2005 12:37:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ralf =?iso-8859-1?Q?R=F6sch?= <linux@cantastic.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiler warnings / linux-2.6
Message-ID: <20050607113731.GB4654@linux-mips.org>
References: <42A47252.2010906@cantastic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A47252.2010906@cantastic.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 06, 2005 at 05:57:06PM +0200, Ralf Rösch wrote:

> Since a few days I get a lot of compiler warnings:
> 
> include2/asm/dsp.h: In function `__init_dsp':
> include2/asm/dsp.h:34: warning: statement with no effect
> 
> What could I do to prevent these?

Reporting them.  A fairly obvious and harmless problem.  I'm surprised my
compiler (gcc 3.4) doesn't throw these warnings.

  Ralf

Index: include/asm-mips/mipsregs.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mipsregs.h,v
retrieving revision 1.73
diff -u -r1.73 mipsregs.h
--- include/asm-mips/mipsregs.h	31 May 2005 11:49:19 -0000	1.73
+++ include/asm-mips/mipsregs.h	7 Jun 2005 11:39:10 -0000
@@ -1010,8 +1010,6 @@
 
 #define wrdsp(val, mask)						\
 do {									\
-	unsigned int __res;						\
-									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
@@ -1021,7 +1019,6 @@
 	"	.set	pop					\n"	\
         :								\
 	: "r" (val), "i" (mask));					\
-        __res;								\
 } while (0)
 
 #if 0	/* Need DSP ASE capable assembler ... */
