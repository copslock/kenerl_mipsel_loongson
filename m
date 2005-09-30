Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:44:28 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:44308 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465568AbVI3Kmc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:32 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLuc005536;
	Fri, 30 Sep 2005 11:42:21 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8U8dAW2024366;
	Fri, 30 Sep 2005 09:39:10 +0100
Date:	Fri, 30 Sep 2005 09:39:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	oski <oski2001@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiling a kernel for ibm z50
Message-ID: <20050930083910.GI3983@linux-mips.org>
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl> <20050928183731.GA18480@linux-mips.org> <BAY101-DAV183674DFDB1AD65FC8FF36D28C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY101-DAV183674DFDB1AD65FC8FF36D28C0@phx.gbl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 29, 2005 at 01:21:43PM +0100, oski wrote:

> After config I run make and got an error.
> The last few lines are
> LD    init/built-in.o
> LD    .tmp_vmlinux1
> drivers/built-in.o: in function 'pnp_check_dma':
> : undefined reference to :'request_dma'
> drivers/built-in.o: in function 'pnp_check_dma':
> : relocation truncated to fit: R_MIPS_26 against 'request_dma'
> drivers/built-in.o: In function 'pnp_check_dma':
> : undefined reference to 'free_dma'
> drivers/built-in.o: In function 'pnp_check_dma':
> : relocation truncated to fit: R_MIPS_26 against 'free_dma'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Any suggestions how can I solve this error problem and progressing in
> building the kernel?

Disable CONFIG_PNP; I don't think that option makes sense on a Z50 but
Yoichi may want to correct me here.

  Ralf
