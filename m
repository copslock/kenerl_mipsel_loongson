Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 19:42:31 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:58007 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038589AbWJRSmZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2006 19:42:25 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id EBE6544424; Wed, 18 Oct 2006 20:42:24 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GaGMZ-00069j-Aa; Wed, 18 Oct 2006 19:41:59 +0100
Date:	Wed, 18 Oct 2006 19:41:59 +0100
To:	Antonio SJ Musumeci <bile@landofbile.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061018184159.GC4051@networkno.de>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com> <20061013104250.GA16820@linux-mips.org> <452F9A41.4020505@landofbile.com> <20061013141101.GA19260@linux-mips.org> <20061013151841.3a902627@amiga> <20061015184226.GA3259@linux-mips.org> <20061018140818.3e40b0a4@amiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018140818.3e40b0a4@amiga>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Antonio SJ Musumeci wrote:
> I'm not talking about that. This patch explains it. Moving
> the conditional compilation from the optimizer to the preprocessor.
> I see no reason to be using hard coded 1's and 0's in runtime logic.

It is easier to read than a ifdef maze, and the net result is the same.


Thiemo
