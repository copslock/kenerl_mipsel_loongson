Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 10:26:50 +0100 (BST)
Received: from p508B5AC4.dip.t-dialin.net ([IPv6:::ffff:80.139.90.196]:51527
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225763AbUE0JZ0>; Thu, 27 May 2004 10:25:26 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4R9PHFK024976;
	Thu, 27 May 2004 11:25:17 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4R9PGsr024975;
	Thu, 27 May 2004 11:25:16 +0200
Date: Thu, 27 May 2004 11:25:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Nilanjan Roychowdhury <nilanjan@genesis-microchip.com>
Cc: linux-mips@linux-mips.org
Subject: Re: gp_disp
Message-ID: <20040527092515.GA24811@linux-mips.org>
References: <9A45247F1AEBB94189B16E7083981F932360AE@INDIAEXCH.gmi.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A45247F1AEBB94189B16E7083981F932360AE@INDIAEXCH.gmi.domain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5201
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2004 at 02:26:54PM +0530, Nilanjan Roychowdhury wrote:

> Hi,
> I have a kernel module which works fine with linux X86 combo.

Which provides aproximately zero proof for the correctness of your code,
sorry ...

> But when I try to compile it with mips cross toll chain it compiles well
> but insmod gives me error on "_gp_disp" unknown symbol.
>  
> How do I get rid of that ??? Do I need to do anything special with my
> compiler flags.

Read the FAQ, it's described there.

  Ralf
