Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 09:50:18 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:33260 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022625AbXDPIuP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 09:50:15 +0100
Received: (qmail 5338 invoked by uid 511); 16 Apr 2007 08:51:58 -0000
Received: from unknown (HELO ?192.168.1.63?) (222.92.8.142)
  by lemote.com with SMTP; 16 Apr 2007 08:51:58 -0000
Message-ID: <4623387F.3070905@lemote.com>
Date:	Mon, 16 Apr 2007 16:49:03 +0800
From:	Zhang Fuxin <zhangfx@lemote.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	tiansm@lemote.com, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de>
In-Reply-To: <20070415222847.GA1402@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
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
