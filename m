Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 15:06:25 +0100 (BST)
Received: from p508B58B4.dip.t-dialin.net ([IPv6:::ffff:80.139.88.180]:22446
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225370AbTIKOGZ>; Thu, 11 Sep 2003 15:06:25 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8BE6BLT015678;
	Thu, 11 Sep 2003 16:06:11 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8BE69Ad015677;
	Thu, 11 Sep 2003 16:06:09 +0200
Date:	Thu, 11 Sep 2003 16:06:08 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	durai <durai@isofttech.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: unresolved symbol dptoli
Message-ID: <20030911140608.GA15365@linux-mips.org>
References: <BLEMJDCPNEFOILECKALMMEDICAAA.durai@isofttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLEMJDCPNEFOILECKALMMEDICAAA.durai@isofttech.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 11, 2003 at 11:33:07AM +0530, durai wrote:

> i compiled a wireless lan driver using the mips-linux-gcc compiler 2.95.3.
> When i try to insmod the driver i got the following errors. any ideas?
> 
> insmod: unresolved symbol dptoli
> insmod: unresolved symbol dpmul
> insmod: unresolved symbol litodp
> 
> Note that, i havent used any of these above functions in my code. It appears
> only in the .o files

These are symbols used by gcc's software fp code.  Don't use floating
point in kernel code.

  Ralf
