Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 18:00:45 +0000 (GMT)
Received: from p508B767E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.126]:34868
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbUKVSAk>; Mon, 22 Nov 2004 18:00:40 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAMI0Ub3008146;
	Mon, 22 Nov 2004 19:00:30 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAMI0UD1008145;
	Mon, 22 Nov 2004 19:00:30 +0100
Date: Mon, 22 Nov 2004 19:00:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ralf R?sch <ralf.roesch@rw-gmbh.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix for Toshiba  tx4297.h
Message-ID: <20041122180030.GA8075@linux-mips.org>
References: <NHBBLBCCGMJFJIKAMKLHEEHGCCAA.ralf.roesch@rw-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHEEHGCCAA.ralf.roesch@rw-gmbh.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 20, 2004 at 10:40:20AM +0100, Ralf R?sch wrote:

> This patch fixes wrong address registers for the TX4927.
> I have checked against the TMPR4927A data sheet and 
> tested with some of the registers.
> 
> The patch included is against 2.6.
> Could anyone review and apply please?

And it applies to 2.4 also, interesting.

Applied,

  Ralf
