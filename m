Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 14:26:42 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:33980 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20026858AbXKAO0e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 14:26:34 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 607A4490D8;
	Thu,  1 Nov 2007 15:15:41 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1Inb05-00021y-FE; Thu, 01 Nov 2007 14:26:25 +0000
Date:	Thu, 1 Nov 2007 14:26:25 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Hyon Lim <alex@alexlab.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS assembly directives in GCC
Message-ID: <20071101142625.GQ7712@networkno.de>
References: <dd7dc2bc0711010536l18f9f2f6gbda4e9ef1158da61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7dc2bc0711010536l18f9f2f6gbda4e9ef1158da61@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hyon Lim wrote:
> I investigated kernel assembly source code in my kernel (2.6.10).
> I found that there are a lot of assembly directives (e.g., .align, .set
> reorder, .cpload, .frame etc.).
> Is there any documents which explains those directives? (not only I
> described above. All of directives)

Short of reading the assembler sourcecode I believe the best document
is "See MIPS Run Linux".


Thiemo
