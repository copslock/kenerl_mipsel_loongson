Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 15:01:12 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:4583 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225841AbUFOOBH>;
	Tue, 15 Jun 2004 15:01:07 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA11569;
	Tue, 15 Jun 2004 23:01:01 +0900 (JST)
Received: 4UMDO00 id i5FE10B21708; Tue, 15 Jun 2004 23:01:01 +0900 (JST)
Received: 4UMRO01 id i5FE0vS02170; Tue, 15 Jun 2004 23:00:58 +0900 (JST)
	from stratos (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 15 Jun 2004 23:00:56 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: suresh@mistralsoftware.com
Cc: linux-mips@linux-mips.org
Subject: Re: PCMCIA VR4131
Message-Id: <20040615230056.2480e18f.yuasa@hh.iij4u.or.jp>
In-Reply-To: <1087299491.2974.8.camel@sarge>
References: <1087299491.2974.8.camel@sarge>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi

On Tue, 15 Jun 2004 17:08:12 +0530
"Suresh. R" <suresh@mistralsoftware.com> wrote:

> Hi,
>   I am modifying the PCMCIA driver (linux 2.4.18 for mips) to make it
> work it with the Richo controller(RF5C296). I made some hack and now the
> driver is able to detect the type of controller and also the cardmgr is
> detecting the type of the card plugged in properly(and properly
> inserting the module for that card). But then (I am right now just
> trying to make the CF storage card work with the kernel) when I load all
> the modules and then run cardmgr and insert the card, I am getting the
> following message. 
> 
> ide0: ports already in use, skipping probe
> 
> This messages keeps repeating for some time and then it stops saying the
> resource is busy.

What did you set ioport range in your config.opts?

> The pcmcia driver is right now working in the polling mode. Please help
> me, if someone has done it before. I just modified the MEM base and IO
> base and now outb and inb are reading from that location. So I think the
> CIS is being read properly. What could be wrong ?.

Yoichi
