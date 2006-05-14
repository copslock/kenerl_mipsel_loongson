Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 20:22:07 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:12218 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133622AbWENSV7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 May 2006 20:21:59 +0200
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 56978448AF; Sun, 14 May 2006 20:21:58 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfLDz-0008G3-QU; Sun, 14 May 2006 19:21:51 +0100
Date:	Sun, 14 May 2006 19:21:51 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel patch for QEMU ?
Message-ID: <20060514182151.GB800@networkno.de>
References: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Now I'm trying QEMU 0.8.1 on mips.
> 
> I found mips-test-0.1.tar.gz on QEMU download page and can run it
> (thanks ths!), but I still can not run a kernel (current lmo git)
> compiled by myself.  My kernel stops after the famous "Checking for
> 'wait' instruction...  available." message.
> 
> The mips-test-0.1 contains kernel 2.6.16-rc6.  Is this a stock
> kernel.org's kernel or lmo's kernel?  Or is there any patch to make
> kernel run on QEMU?

This kernel is stock lmo except for a small patch which allows clean
system shutdown (qemu 0.8.1 does not have the counterpart to it).
The patch should be completely irrelevant otherwise.

However, later kernels try to access the CP0 pagemask register which
is R10000 specific, IIRC Qemu throws an Reserved Instruction exception
on accessing it.

I use a heavily patched version of Qemu which mostly supports mips32r2,
it also has better decoding of CP0 accesses. My current patchset is
available at http://people.debian.org/~ths/qemu/qemu-patches-bogus2,
it needs more work before it is ready for inclusion, and may be
completely useless for anybody else, since it works ATM only on powerpc
hosts.


Thiemo
