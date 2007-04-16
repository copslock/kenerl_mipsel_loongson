Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 13:43:55 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:50085 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20023175AbXDPMny (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 13:43:54 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 4342EB8AAB;
	Mon, 16 Apr 2007 14:43:48 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HdQZC-0005u9-I5; Mon, 16 Apr 2007 13:44:22 +0100
Date:	Mon, 16 Apr 2007 13:44:22 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Zhang Fuxin <zhangfx@lemote.com>
Cc:	tiansm@lemote.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
Message-ID: <20070416124422.GB1402@networkno.de>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de> <4623387F.3070905@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4623387F.3070905@lemote.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Zhang Fuxin wrote:
> >> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> > 
> > I wonder why this is r4600. I heard the Loongson2 is MIPS IV compatible,
> > so r5000 / r8000 / r10000 would be better choices.
> 
> Presently Loongson-2E is nearly MIPS III compatible(with some
> self-defined extensions), next version will be mips64 release2 compatible.

I see.

> -march=r4600 is inherited from loongson-1, -march=mips3 might be a
> better choice.

Maybe. The 'mips3' maps to -march=r4000, it would assume more memory
latency and a slower integer divider then -march=r4600.


Thiemo
