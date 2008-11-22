Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 20:54:46 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:10923 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S23841528AbYKVUyi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 20:54:38 +0000
Received: from lagash (X5e0c.x.pppool.de [89.59.94.12])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5DB48481A8;
	Sat, 22 Nov 2008 21:54:35 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1L3zUw-0003ak-BV; Sat, 22 Nov 2008 21:54:34 +0100
Date:	Sat, 22 Nov 2008 21:54:34 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Andrew Randrianasulu <randrik_a@yahoo.com>
Cc:	linux-mips@linux-mips.org, binutils@sourceware.org
Subject: Re: old binutils-2.13-msp.diff and binutils 2.19
Message-ID: <20081122205434.GA17042@networkno.de>
References: <922652.90789.qm@web59801.mail.ac4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922652.90789.qm@web59801.mail.ac4.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Andrew Randrianasulu wrote:
> Hello. Sorry for asking this question - but while trying to move 
> forward this patch, i faced with duplicated opcode in
> opcodes/mips-ops.c One "vmulu" was defined for Octeon, and one -
> for SGI O2 VICE coprocessor. After commenting out one from Octeon
> - my [patched] binutils finally was able to pass gcc-3.4.6 compilation.
> I saw some duplicates in this file, apart from my case,  but i'm
> really unsure what to do in this case? Move patch parts around?
> But moving them in random order will break assembler, already learned
> this ....
> 
> Also I'm lost in gas/config/tc-mips.c Original patch was designed for
> (K, m, n) [i don't know what they mean .. some form of internal
> markers?]

Exactly that, their meaning is documented in include/opcode/mips.h

> and i changed it for (+K, +m,+n). But i'm really lost in those big
> switches there. Right now my new code disabled, looking at old patch
> i must add some logic before yet another switch. Where is the best
> place for discussing this - here or on gcc mail list?

Use binutils@sourceware.org


Thiemo
