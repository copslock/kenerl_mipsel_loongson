Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 00:43:34 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:33545 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225209AbTA0And>;
	Mon, 27 Jan 2003 00:43:33 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id 9CDD640E29; Mon, 27 Jan 2003 01:43:30 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18cxNl-0001Um-00; Mon, 27 Jan 2003 01:44:13 +0100
Date: Mon, 27 Jan 2003 01:44:12 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: sigset_t32 broken?
In-Reply-To: <20030124024854.B9031@linux-mips.org>
Message-ID: <Pine.LNX.4.21.0301270135210.3253-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

On Fri, 24 Jan 2003, Ralf Baechle wrote:
> Most of what your patch does is undoing an accidental commit of a signal
> rework that wasn't yet supposed to go out.

Maybe.. but current version is still wrong :) The type of the sig
array in the 32-bit compatibility struct sigset_t32 must be 32bit long,
i.e. unsigned int not unsigned long.
And I think unsigned describes the data better than signed, but that's a
matter of taste :) (coherent with the choice in asm-mips/signal.h).

Vivien.

--- include/asm-mips64/signal.h	2003-01-26 02:41:48.000000000 +0100
+++ include/asm-mips64/signal.h	2003-01-27 01:28:13.000000000 +0100
@@ -16,7 +16,7 @@
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
 typedef struct {
-	long sig[_NSIG_WORDS];
+	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
 #define _NSIG32		128
@@ -24,7 +24,7 @@
 #define _NSIG_WORDS32	(_NSIG32 / _NSIG_BPW32)
 
 typedef struct {
-	long sig[_NSIG_WORDS32];
+	unsigned int sig[_NSIG_WORDS32];
 } sigset_t32;
 
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
