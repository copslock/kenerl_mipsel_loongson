Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 17:05:18 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:31690 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038636AbWISQFR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2006 17:05:17 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 03A2447355; Tue, 19 Sep 2006 18:05:16 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GPi5x-0003o1-Qy; Tue, 19 Sep 2006 17:05:13 +0100
Date:	Tue, 19 Sep 2006 17:05:13 +0100
To:	Eric DeVolder <edevolder@razamicroelectronics.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers
Message-ID: <20060919160513.GD4553@networkno.de>
References: <2E96546B3C2C8B4CA739323C6058204A0163548B@hq-ex-mb01.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A0163548B@hq-ex-mb01.razamicroelectronics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Eric DeVolder wrote:
[snip]
> I would have thought that for this simple example I'd get identical
> results. For reasons I have yet to figure out, the cross compiler is
> finding better optimizations than the native, though both are the
> same gcc version. I checked the specs files, and the two are identical
> other than the "cross_compile" setting.

Have you checked (with -v) if the assembler gets the same optimisations
in both cases, and/or (with -save-temps) where in the compile things
start to diverge?


Thiemo
