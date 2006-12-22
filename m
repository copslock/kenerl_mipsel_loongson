Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2006 23:39:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13971 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044527AbWLVXje (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Dec 2006 23:39:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBMNdqht007684;
	Sat, 23 Dec 2006 00:39:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBMNdq0t007683;
	Sat, 23 Dec 2006 00:39:52 +0100
Date:	Sat, 23 Dec 2006 00:39:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Allan Young <auriculatus@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: any hints for running linux on an old galileo ev-64120 eval board?
Message-ID: <20061222233951.GA4929@linux-mips.org>
References: <d31941710612221404t7a6a2b8cnec4854b872e089e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31941710612221404t7a6a2b8cnec4854b872e089e9@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 22, 2006 at 03:04:40PM -0700, Allan Young wrote:

> It would be great if I could get a few hints on how to get Linux
> running on one of these old gt64120 based PCI eval cards from Galileo.
> I know these cards are quite old and crufty but since I see evidence
> of support in the kernel I thought I'd ask if anyone still uses the
> ev-64120 support.

The code for the EV64120 is still there but it's in a sad shape.  I don't
recall any user reports ever since the original code drop in December
2000 ...

> Currently I have an ev-64120 inserted into a passive PCI backplane and
> have access to pmon over the serial port.
> 
> I expect that I should be able to cross compile the kernel, with the
> ev-64120 board support enabled, and convert the resulting elf into
> srec format for loading via pmon (ouch).  However, I'm not sure what
> to do for providing a root filesystem or even how one should specify
> kernel command line parameters.

Presumably argument passing works just like on other PMON platforms.

> I'm wondering if it's feasible to put a supported NIC in the PCI
> passive backplane with the ev-64120 and provide a suitable root file
> system over a network connection?  I'm not aware if the linux kernel
> can perform the PCI configuration (setting up the PCI base address
> registers etc).

By default Linux on MIPS will do full configuration of the bus.

> Any way, if anyone has gone down this ev-64120 path I'd greatly
> appreciate hearing any suggestions, even if they are along the lines
> of "abandon all hope". :)

The code may be rotten - but other platforms such as the Cobalt (based on
the GT64120's small brother the GT64111) or Malta which is also based
on the GT64120 are well supported and old revs of the code are available
in the git repository.

  Ralf
