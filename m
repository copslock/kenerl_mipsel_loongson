Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 18:04:23 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:10645 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492603AbZFYQEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2009 18:04:15 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
Date:	Thu, 25 Jun 2009 09:00:19 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501C35485@exchange.ZeugmaSystems.local>
In-Reply-To: <20090625134511.GC10661@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
Thread-Index: Acn1m1TTDKQ20u7fRq26aJyxWnJLXAADr/iQ
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf wrote:
> I found this in IRIX 6.5 documentation:
> 
>   Caution: Signals raised by the instruction stream, SIGILL, 
>   SIGEMT, SIGBUS, and SIGSEGV, will cause infinite loops
>   if their handler returns, or the action is set to SIG_IGN. 

The Single Unix Specification (Issue 6) marks the behavior
explicitly undefined.

Bookmark this: http://www.opengroup.org/onlinepubs/009695399

Not the latest set of documents, but that can be regarded
as a virtue. :)

Under pthread_sigmask and sigprocmask, for blocking:

  If any of the SIGFPE, SIGILL, SIGSEGV, or SIGBUS
  signals are generated while they are blocked,
  the result is undefined, unless the signal
  was generated by the kill() function, the
  sigqueue() function, or the raise() function.

Under ``2.4 Signal Concepts'', for SIG_IGN:

  SIG_IGN 

  Ignore signal. 

  Delivery of the signal shall have no effect on
  the process. The behavior of a process is undefined
  after it ignores a   SIGFPE, SIGILL, SIGSEGV,
  or SIGBUS  signal that was not generated by kill(),
  sigqueue(), or raise().

So, as I suspected, there are in fact no requirements
from the applicable spec. Infinite looping or
stopping the process anyway are conforming responses,
as is rebooting or halting the machine with a
``panic'' message. 
