Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 12:02:19 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:18458 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226016AbVDDLCD>; Mon, 4 Apr 2005 12:02:03 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j34B1uIU008104;
	Mon, 4 Apr 2005 12:01:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j34B1qHB008077;
	Mon, 4 Apr 2005 12:01:52 +0100
Date:	Mon, 4 Apr 2005 12:01:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	dfsd df <tomcs163@yahoo.com.cn>
Cc:	linux-mips@linux-mips.org
Subject: Re: questions about early-printk
Message-ID: <20050404110152.GF6016@linux-mips.org>
References: <20050404044953.86817.qmail@web15808.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404044953.86817.qmail@web15808.mail.cnb.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 04, 2005 at 12:49:53PM +0800, dfsd df wrote:

> Hi:
>   Had somebody used early-printk? Now, I'm porting
> linux to a MIPS machine under instructions of "Linux
> MIPS Porting Guide" from junsun.net.

There's an updated version in the www.linux-mips.org wiki.

> But at the first step, I want to modify the source
> code of the barebone program to display "helloworld".
> 
> The program uses memory map addr as the UART device's
> "base addr",and access the UART by adding offset to
> this "base addr".
> 
> The "base addr" is assigned to a constant value. and
> from the other early-printk patchs, the value of "base
> addr" are not equals. So I want to know can I assign
> the right value to this "base addr"?

You haven't even mentioned what hardware you're using so don't expect
answer ...

  Ralf
