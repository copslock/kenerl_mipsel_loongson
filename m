Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 09:49:53 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:27834 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20022616AbXDPItw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 09:49:52 +0100
Received: (qmail 10017 invoked by uid 507); 16 Apr 2007 16:52:46 +0800
Received: from unknown (HELO ?192.168.1.63?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 16 Apr 2007 16:52:46 +0800
Message-ID: <46233872.7010206@ict.ac.cn>
Date:	Mon, 16 Apr 2007 16:48:50 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	tiansm@lemote.com, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de>
In-Reply-To: <20070415222847.GA1402@networkno.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

>> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> 
> I wonder why this is r4600. I heard the Loongson2 is MIPS IV compatible,
> so r5000 / r8000 / r10000 would be better choices.

Presently Loongson-2E is nearly MIPS III compatible(with some
self-defined extensions), next version will be mips64 release2 compatible.

-march=r4600 is inherited from loongson-1, -march=mips3 might be a
better choice.

> 
> 
> Thiemo
> 
> 
> 
> 
