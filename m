Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 06:14:00 +0100 (BST)
Received: from mail1.lge.co.kr ([156.147.1.151]:31976 "EHLO mail1.lge.co.kr")
	by ftp.linux-mips.org with ESMTP id S8133352AbWD0FNw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Apr 2006 06:13:52 +0100
Received: from [150.150.71.243] (jsungkim@lge.com) by 
          mail1.lge.co.kr (Terrace MailWatcher) 
          with ESMTP id 2006042714:13:44:186057.280.138
          for <linux-mips@linux-mips.org>; 
          Thu, 27 Apr 2006 14:13:44 +0900 (KST) 
From:	"Kim, Jong-Sung" <jsungkim@lge.com>
To:	"'Thiemo Seufer'" <ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: Reading an entire cacheline
Date:	Thu, 27 Apr 2006 14:13:00 +0900
Message-ID: <00fd01c669b9$411095b0$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
thread-index: AcZpGn8n6Gx6q28mTPWwTUADed6KuwAnY3gA
In-Reply-To: <20060426101603.GB29550@networkno.de>
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Return-Path: <jsungkim@lge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsungkim@lge.com
Precedence: bulk
X-list: linux-mips

Dear Mr. Seufer,

Thank you for your advice about directives. That's exactly what I meant. I
have confused them with push/pop style operations. Thanks.

Regards,
JS.

-----Original Message-----
From: Thiemo Seufer [mailto:ths@networkno.de] 
Sent: Wednesday, April 26, 2006 7:16 PM
To: Kim, Jong-Sung
Cc: linux-mips@linux-mips.org
Subject: Re: Reading an entire cacheline

Kim, Jong-Sung wrote:
> Hi all,
> 
> Please look at following codes:
> 
> save_flags(flags);
> cli();
> __asm__ __volatile__(
> 	"	.set	noreorder\n"
> 	"	.set	mips32\n"
> 	"2:	.set	mips3\n"
> 	"	cache	5, 0x00(%12)\n"
> 	"	.set	mips0\n"

Irrelevant sidemark:
.set mips0 resets to the original value, not to mips32. You probably want

	.set	push
	.set	noreorder
	.set 	mips32

	... <the whole code sequence>

	.set	pop

[snip]
> 	//"	bne	%0, %9, 2b\n"
> 	"	.set	mips0\n"
> 	"	.set	reorder"
> 	: "=r" (tag[1][way][0]), "=r" (datalo[1][way][0]),
> 	  "=r" (datahi[1][way][0]),
> 	  "=r" (tag[1][way][1]), "=r" (datalo[1][way][1]),
> 	  "=r" (datahi[1][way][1]),
> 	  "=r" (tag[1][way][2]), "=r" (datalo[1][way][2]),
> 	  "=r" (datahi[1][way][2]),
> 	  "=r" (tag[1][way][3]), "=r" (datalo[1][way][3]),
> 	  "=r" (datahi[1][way][3])
> 	: "r" (0x80000000 | (way << 14) | (line << 5))
> );

And this part may cause the problem you are seeing, I presume
datalo/datahi live in memory, and accesses of it change the dcache.

As Kevin mentioned, disassembling the binary might be helpful.


Thiemo
