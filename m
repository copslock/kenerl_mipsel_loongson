Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 14:53:35 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:35359 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134414AbWAIOxS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 14:53:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k09EuB7g005590;
	Mon, 9 Jan 2006 14:56:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k09EuAwv005589;
	Mon, 9 Jan 2006 14:56:10 GMT
Date:	Mon, 9 Jan 2006 14:56:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060109145610.GB4286@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 09, 2006 at 01:59:34PM +0800, zhuzhenhua wrote:

> i download a standard 2.6.14 kernel, and compile it for dbau1100, and
> i find the early_initcall(au1x00_setup) was not compiled into the
> vmlinux.
> and i find at the linux-mips cvs, it used plat_setup instead of early_initcall.
> does it means my toolchain is not correct to compile the
> early_initcall, or in the standard 2.6.14 kernel, the early_initcall
> do not work well?

You've downloaded a kernel.org kernel it would seem - doesn't fly for MIPS.
Instead get a kernel from linux-mips.org.

The early_initcall() construct has been removed.

  Ralf
