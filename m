Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 19:52:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:1752 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133622AbWENRwb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 May 2006 19:52:31 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4EHqac9025906;
	Sun, 14 May 2006 18:52:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4EHqYIu025905;
	Sun, 14 May 2006 18:52:34 +0100
Date:	Sun, 14 May 2006 18:52:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, Thiemo Seufer <ths@networkno.de>
Subject: Re: kernel patch for QEMU ?
Message-ID: <20060514175234.GA25659@linux-mips.org>
References: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 15, 2006 at 01:08:46AM +0900, Atsushi Nemoto wrote:

> Now I'm trying QEMU 0.8.1 on mips.
> 
> I found mips-test-0.1.tar.gz on QEMU download page and can run it
> (thanks ths!), but I still can not run a kernel (current lmo git)
> compiled by myself.  My kernel stops after the famous "Checking for
> 'wait' instruction...  available." message.
> 
> The mips-test-0.1 contains kernel 2.6.16-rc6.  Is this a stock
> kernel.org's kernel or lmo's kernel?  Or is there any patch to make
> kernel run on QEMU?

Thiemo promised to send me patches so I hope it's only a matter of days
to get this fixed.

  Ralf
