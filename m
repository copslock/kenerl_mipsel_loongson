Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 14:58:57 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:9227 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225273AbVIHN6l>; Thu, 8 Sep 2005 14:58:41 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j88E5F3o017201;
	Thu, 8 Sep 2005 15:05:15 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j88E5EaM017200;
	Thu, 8 Sep 2005 15:05:14 +0100
Date:	Thu, 8 Sep 2005 15:05:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	vasanth <vasanth@aelixsystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: unresolved symbol
Message-ID: <20050908140513.GD3608@linux-mips.org>
References: <005201c5b47d$20a0d4d0$3c00a8c0@vasanth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005201c5b47d$20a0d4d0$3c00a8c0@vasanth>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 08, 2005 at 07:26:17PM +0530, vasanth wrote:

> I am getting the folowing error message when i do insmod .
> insmod: unresolved symbol __udelay
> insmod: unresolved symbol atomic_add
> insmod: unresolved symbol atomic_sub
> 
> I complied the driver code for mips processor using the folowing command
> mips-linux-gcc -G O -mno-abicalls -fno-pic -pipe -mtune=4kc -mips32 -c lcddriver.c -I/mykernel/include
> It is compiling without any error . 

Use -O2.  In fact use _exactly_ the same options as for the kernel build
itself.

  Ralf
