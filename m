Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 14:03:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10982 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022271AbXCMODU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 14:03:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2DE1RFE000653
	for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 14:01:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2DE1R0K000652
	for linux-mips@linux-mips.org; Tue, 13 Mar 2007 14:01:27 GMT
Date:	Tue, 13 Mar 2007 14:01:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: PNX8550_V2PCI build breakage
Message-ID: <20070313140127.GA560@linux-mips.org>
References: <20070304162030.GA2853@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070304162030.GA2853@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 04, 2007 at 04:20:30PM +0000, Ralf Baechle wrote:

> pnx8550-v2pci_defconfig fails with:
> 
>   AR      arch/mips/lib-32/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> /usr/bin/mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:37: syntax error
> make: *** [.tmp_vmlinux1] Error 1
> 
> Can somebody PNX knowledgable take care of that?

Nobody did reply and in fact there is just 10 lines of code (including
comments that is!) for the CONFIG_PNX8550_V2PCI, so I killed it.

That's aintainer's favorite anyway ;-)

  Ralf
