Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 15:07:29 +0100 (BST)
Received: from p508B62CE.dip.t-dialin.net ([IPv6:::ffff:80.139.98.206]:61729
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225778AbUENOH2>; Fri, 14 May 2004 15:07:28 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4EE7LxT015759;
	Fri, 14 May 2004 16:07:21 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4EE7Kns015758;
	Fri, 14 May 2004 16:07:20 +0200
Date: Fri, 14 May 2004 16:07:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org,
	Manish Lachwani <Manish_Lachwani@pmc-sierra.com>
Subject: Re: titan ethernet driver
Message-ID: <20040514140720.GC24402@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259022536FB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca> <200405141458.01277.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405141458.01277.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 14, 2004 at 02:58:01PM +0200, Thomas Koeller wrote:

> This is all about 2.6. From the CVS change logs I see that Ralf is
> applying 2.6-specific changes to the driver. Now that there is no
> working support for 2.6 on the yosemite, the only platform I know of
> that has this H/W, I just wondered how these changes are tested.

On Yosemite, of course :-)  The reason why I put this driver already into
CVS before the remainder of the Yosemite port is to make it accessible
for outside review by one of the Linux networking gods.

  Ralf
