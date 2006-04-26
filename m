Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 11:03:34 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:32201 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133554AbWDZKD0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 11:03:26 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 91EE144B82; Wed, 26 Apr 2006 12:16:42 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FYh3z-0002Vb-Ba; Wed, 26 Apr 2006 11:16:03 +0100
Date:	Wed, 26 Apr 2006 11:16:03 +0100
To:	"Kim, Jong-Sung" <jsungkim@lge.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Reading an entire cacheline
Message-ID: <20060426101603.GB29550@networkno.de>
References: <081a01c66784$c6f7cb30$f3479696@LGE.NET> <009f01c6690e$0501a3d0$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009f01c6690e$0501a3d0$f3479696@LGE.NET>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

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
