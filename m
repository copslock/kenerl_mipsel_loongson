Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 09:37:20 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:41953 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133457AbWGaIhK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 09:37:10 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3DDA546693; Mon, 31 Jul 2006 10:35:08 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G7TEN-0000k6-MF; Mon, 31 Jul 2006 09:34:31 +0100
Date:	Mon, 31 Jul 2006 09:34:31 +0100
To:	wyb@topsec.com.cn
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: unmatched R_MIPS_HI16/LO16 on gcc 3.4.3
Message-ID: <20060731083431.GG15011@networkno.de>
References: <004001c6af95$14585900$0100000a@codingman> <20060725034424.GB22138@linux-mips.org> <000f01c6b444$e1e820e0$0100000a@codingman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c6b444$e1e820e0$0100000a@codingman>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

wyb@topsec.com.cn wrote:
> 
> Attachment is a testsuit. It costed me a week to make this testsuit.

FWIW, I can't reproduce the failure with Debian's gcc 3.4.6.
ISTR this bug was fixed in later 3.4.x versions.

> If I added -mno-explicit-relocs -mno-split-addresses to makefile, this bug
> disappeared. Is there any performance difference with and without these
> flags ?

-mno-explicit-relocs will degrade the efficiency of the compiler's
instruction scheduling since some macro expansions are left to the
assembler in that case. It will likely affect both execution speed
and code size.


Thiemo
