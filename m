Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 15:35:36 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:54388
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbVBCPfV>; Thu, 3 Feb 2005 15:35:21 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13FZKwk014938;
	Thu, 3 Feb 2005 16:35:20 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13FZKja014937;
	Thu, 3 Feb 2005 16:35:20 +0100
Date:	Thu, 3 Feb 2005 16:35:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050203153520.GF13804@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED20E3.60309@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2005 at 03:44:51PM +0100, Rojhalat Ibrahim wrote:

> is there anything special I have to do
> when I want to use more than 512MB of memory?
> My Yosemite board works fine with 512MB
> but when I try 1GB it crashes in 32bit mode
> with highmem and also in 64bit mode.
> The boot monitor (PMON) maps the 1024MB
> to physical addresses 0x0000.0000 - 0x4000.0000.

Interesting.  It's supposed to work but I don't have enough memory for
testing this.

  Ralf
