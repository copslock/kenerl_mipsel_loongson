Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2005 12:03:15 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:27164 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225877AbVHOLC6>; Mon, 15 Aug 2005 12:02:58 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7FB7Pkr011968;
	Mon, 15 Aug 2005 12:07:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7FB7Pqa011967;
	Mon, 15 Aug 2005 12:07:25 +0100
Date:	Mon, 15 Aug 2005 12:07:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Danny Home Educator <dannyhsdad@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and mips linux
Message-ID: <20050815110725.GC2727@linux-mips.org>
References: <1634a4f105081110194fe8603d@mail.gmail.com> <20050811174128.GA31760@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811174128.GA31760@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 11, 2005 at 06:41:28PM +0100, Ralf Baechle wrote:

> > % qemu-system-mips -kernel vmlinux -m 16 -nographic
> > (qemu) mips_r4k_init: start
> > mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072
> > 
> > And hangs there.
> > 
> > Has anyone else tried qemu with the latest mips linux? Thanks.
> 
> You need to enable serial console and add -append console=ttyS0 to the
> Qemu options.  That all won't help you too much because the emulator will
> hang on the first instruction in user mode.

Qemu as of before the weekend which needed slight tweaks to compile was
haning just in the BogoMIPS loop.  With minor fixes it's now getting
beyond that point and sometimes running trivial userspace code ok.

  Ralf
