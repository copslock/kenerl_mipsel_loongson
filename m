Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 14:35:51 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:57355 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225275AbVCKOfa>; Fri, 11 Mar 2005 14:35:30 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2BEZ3EE006193;
	Fri, 11 Mar 2005 14:35:03 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2BEZ2R5006192;
	Fri, 11 Mar 2005 14:35:02 GMT
Date:	Fri, 11 Mar 2005 14:35:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	ppopov@embeddedalley.com,
	Linux Mailinglist <mailinglist.linux@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Linux 2.6 support for Brecis MSP2100 processor !
Message-ID: <20050311143502.GB5958@linux-mips.org>
References: <77fd3fe0050308202654a4432a@mail.gmail.com> <20050309173044.GA18688@linux-mips.org> <77fd3fe00503101746fed176b@mail.gmail.com> <4230FAC9.6040304@embeddedalley.com> <4230FEED.9090402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4230FEED.9090402@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 10, 2005 at 06:14:05PM -0800, Manish Lachwani wrote:

> 4Km is a 4Kc without TLB. I think this is supported.

Maybe at uclinux.org but certainly not on linux-mips.org.  There have never
been many requests for Linux on TLB-less processors and in recent years
the interest that low interest seems to have fallen even further.

That said, if anybody wants to working on supporting MIPS with
CONFIG_MMU=n by all means, go ahead.

  Ralf
