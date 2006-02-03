Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 02:19:58 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:61910 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133531AbWBCCSW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 02:18:22 +0000
Received: (qmail 27553 invoked from network); 3 Feb 2006 02:23:32 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 3 Feb 2006 02:23:32 -0000
Message-ID: <43E2BF68.2000208@ru.mvista.com>
Date:	Fri, 03 Feb 2006 05:26:48 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl> <20060202165656.GC17352@linux-mips.org>
In-Reply-To: <20060202165656.GC17352@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>Workaround: mask EXL bit of the result or place a nop before mfc0.
>>
>>[...]
>>
>>>@@ -55,8 +56,13 @@ __asm__ (
>>> 	"	di							\n"
>>> #else
>>> 	"	mfc0	$1,$12						\n"
>>>+#if TX49XX_MFC0_WAR && defined(MODULE)
>>>+	"	ori	$1,3						\n"
>>>+	"	xori	$1,3						\n"
>>>+#else
>>> 	"	ori	$1,1						\n"
>>> 	"	xori	$1,1						\n"
>>>+#endif
>>> 	"	.set	noreorder					\n"
>>> 	"	mtc0	$1,$12						\n"
>>> #endif

>> Hmm, wouldn't that "nop" alternative be simpler?

> Simpler maybe - but this variant has zero runtime overhead.

    And.. how do you imagine placing a NOP (which surely just moves MFC0 down 
so that it's a 1st insn. on the next page). What if it'll move it to the 
errata prone address from a safe one instead?

WBR, Sergei
