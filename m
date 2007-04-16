Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 16:11:15 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:38016 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20023319AbXDPPLN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 16:11:13 +0100
Received: (qmail 8073 invoked by uid 511); 16 Apr 2007 15:13:13 -0000
Received: from unknown (HELO ?192.168.1.63?) (222.92.8.142)
  by lemote.com with SMTP; 16 Apr 2007 15:13:13 -0000
Message-ID: <462391D5.90707@lemote.com>
Date:	Mon, 16 Apr 2007 23:10:13 +0800
From:	Zhang Fuxin <zhangfx@lemote.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de> <4623387F.3070905@lemote.com> <20070416124422.GB1402@networkno.de>
In-Reply-To: <20070416124422.GB1402@networkno.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer 写道:
> Maybe. The 'mips3' maps to -march=r4000, it would assume more memory
> latency and a slower integer divider then -march=r4600.
>   
Just like Ralf has said, -march might not lead to significant
performance difference, but -mtune=
may. Two years ago, I found that adding a machine.def to descripe
pipeline and resources for loongson2
and -mtune=loongson boost many programs by 2-5%。

>
> Thiemo
>
>
>   
