Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 18:55:27 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:45516 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037591AbWHWRzX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2006 18:55:23 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 5890945953; Wed, 23 Aug 2006 19:55:31 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GFwvL-0001SY-Tz; Wed, 23 Aug 2006 18:53:55 +0100
Date:	Wed, 23 Aug 2006 18:53:55 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Peter Watkins <treestem@gmail.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] 64K page size
Message-ID: <20060823175355.GA2887@networkno.de>
References: <20060823160011.GE20395@networkno.de> <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> I am extremely interested in big pages (64K, etc), and
> the sooner the better. If there is anything not
> considered OK for immediate inclusion in the Linux
> MIPS git tree, I would love to have a copy anyway.
> Large pages will be necessary for some high-priority
> work I'm doing, although stability at this point seems
> to be an optional extra. (Hence why the patches are
> much more important than whether they're actually
> finished yet.)

Biggest drawback (besides stability concerns and some broken userspace
programs) is the insane amount of memory it can take. Every tiny file
would currently take 64k in the page cache. There's some work going on
to collate such partially used pages into single ones, but that may
take a while to become usable.


Thiemo
