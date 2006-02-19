Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 10:56:03 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:1821 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133589AbWBTKzK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 10:55:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB1Gwf005775;
	Mon, 20 Feb 2006 11:01:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1JJrgbk024317;
	Sun, 19 Feb 2006 19:53:42 GMT
Date:	Sun, 19 Feb 2006 19:53:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shuveb Hussain <shuveb@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: mem_in? and mem_out? functions
Message-ID: <20060219195342.GF21416@linux-mips.org>
References: <c24555040510150133x7d42afe6x9526b6eecc216b5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c24555040510150133x7d42afe6x9526b6eecc216b5f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 15, 2005 at 02:03:13PM +0530, Shuveb Hussain wrote:

> Hi,
> I am compiling the source from git. There are definitions of macros in
> include/asm/io.h for the following:
> 
> mem_inb
> mem_outb
> mem_inl
> mem_outl
> ...
> ...
> 
> The issue is that the driver :
> drivers/char/ipmi/  - have redeclared these macros as functions
> statically, in the file - ipmi_si_intf.c
> 
> I do not know if this driver is used on MIPS at all, but it does get
> into the way of proper compilation. If compilation of the IPMI driver
> in any form is disabled (by default it gets compiled as a module),
> then the compilation goes on smoothly.
> 
> I changed the names of these functions slightly and made other
> modifications as to compile properly and now everything is OK, but I
> do not know if this is the best way to do it, though it works for me
> now.
> 
> What is the best solution for this issue?

This has now been fixed by commit 290f10ae4230ef06b71e57673101b7e70c1b29a6.

  Ralf
