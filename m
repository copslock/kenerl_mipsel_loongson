Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 20:43:19 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:48769 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225221AbVBQUnE>; Thu, 17 Feb 2005 20:43:04 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1HKauoP010335;
	Thu, 17 Feb 2005 20:36:56 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1HKasGd010334;
	Thu, 17 Feb 2005 20:36:54 GMT
Date:	Thu, 17 Feb 2005 20:36:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rishabh@soc-soft.com
Cc:	linux-mips@linux-mips.org, mel@skynet.ie, jbglaw@lug-owl.de
Subject: Re: HIGHMEM Query
Message-ID: <20050217203654.GA9671@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C53FAF5@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C53FAF5@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 17, 2005 at 10:40:22AM +0530, Rishabh@soc-soft.com wrote:

First, fix your mailer setup, it's littering emails with extra carriage
returns.

> I have been working on HIGHMEM fixation for 2.4.20 linux MVL kernel for
> MIPS architecture.
> I am getting DATA BUS ERROR(ADDR: 0xffffd000) exception when loading
> (copying the data received from ethernet to the kernel space in FIXADDR
> SPACE) "/sbin/init" from TARGET ROOT DIR (through NFS). I figured out
> that this is because there is no corresponding page table entry for the
> same.

That does not make sense.  If you don't have a pagetable entry the CPU will
take a TLB reload exception.  If the entry is invalid, the kernel will
die with an oops.  A bus error has different causes.

  Ralf
