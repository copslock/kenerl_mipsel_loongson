Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 00:49:11 +0000 (GMT)
Received: from p508B63AE.dip.t-dialin.net ([IPv6:::ffff:80.139.99.174]:16668
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbUKLAtG>; Fri, 12 Nov 2004 00:49:06 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAC0mw8S010987;
	Fri, 12 Nov 2004 01:48:58 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAC0mww3010980;
	Fri, 12 Nov 2004 01:48:58 +0100
Date: Fri, 12 Nov 2004 01:48:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove duplicates from drivers/mtd/maps/Makefile
Message-ID: <20041112004858.GB2952@linux-mips.org>
References: <20041111152955.GF3815@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111152955.GF3815@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 11, 2004 at 08:29:55AM -0700, Tom Rini wrote:

> There are 2 duplicate entries in drivers/mtd/maps/Makefile only found in
> CVS.

Thanks, applied.

  Ralf
