Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 19:08:38 +0000 (GMT)
Received: from p508B7DF8.dip.t-dialin.net ([IPv6:::ffff:80.139.125.248]:3776
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225344AbTJ0TIf>; Mon, 27 Oct 2003 19:08:35 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9RJ8VNK027659;
	Mon, 27 Oct 2003 20:08:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9RJ8TCm027658;
	Mon, 27 Oct 2003 20:08:30 +0100
Date: Mon, 27 Oct 2003 20:08:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Teresa Tao <TERESAT@TTI-DM.COM>, linux-mips@linux-mips.org
Subject: Re: question regarding bss section
Message-ID: <20031027190829.GB24946@linux-mips.org>
References: <20031027180957.GA25797@linux-mips.org> <20031027181717.1A2E1C59E4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027181717.1A2E1C59E4@atlas.denx.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2003 at 07:17:12PM +0100, Wolfgang Denk wrote:

> > .bss is uninitialized.  Initialized data can't be in .bss.
> 
> No. BSS is initialized as zero.

RTFM.  It's unitialized because not contained in the binaries.

  Ralf
