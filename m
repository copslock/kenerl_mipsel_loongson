Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 17:52:58 +0100 (BST)
Received: from p508B60FA.dip.t-dialin.net ([IPv6:::ffff:80.139.96.250]:10166
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225344AbTHBQwy>; Sat, 2 Aug 2003 17:52:54 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h72GqqpR004831;
	Sat, 2 Aug 2003 18:52:52 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h72GqpRe004830;
	Sat, 2 Aug 2003 18:52:51 +0200
Date: Sat, 2 Aug 2003 18:52:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: sead_int.c
Message-ID: <20030802165250.GA3697@linux-mips.org>
References: <Pine.GSO.4.44.0308011043090.7852-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308011043090.7852-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 10:47:51AM -0400, David Kesselring wrote:

> Tell me if I'm incorrect but it looks like this for condition is wrong.
> There are only 2 defined irqs.
> 
> 	for (i = 0; i <= SEADINT_END; i++)
> 	              ^^	should be just < ??

Looks like you're right ...

  Ralf
