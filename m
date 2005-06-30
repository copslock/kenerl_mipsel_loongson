Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 10:14:14 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:15888 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225722AbVF3JNz>; Thu, 30 Jun 2005 10:13:55 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j5U9AvNe004940;
	Thu, 30 Jun 2005 10:10:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j5U9AuNF004939;
	Thu, 30 Jun 2005 10:10:56 +0100
Date:	Thu, 30 Jun 2005 10:10:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Krishna B S <bskris@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Popular MIPS4Kc boards?
Message-ID: <20050630091056.GA2935@linux-mips.org>
References: <1943a413050629014858a124f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1943a413050629014858a124f7@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 29, 2005 at 02:18:40PM +0530, Krishna B S wrote:

> I have to develop toolchains for various MIPS boards my company
> develops. All the boards consist of MIPS 4KC.
> 
> I would like to know from you what is the most popular board used by
> the community with this kind of processor. I know, its tough to get a
> clear answer.
> 
> But, my intention is to first port my toolchain/kernel for this
> popular board so that I can get your support, in case I encounter any
> problems. Having confirmed the working of the toolchain for this
> board, I would port it to my company's boards.
> 
> (The popular board in the community would be my reference board for
> development.)

The price tag is juicy but for serious development with a 4Kc I'd
recommend a MIPS Malta.  Forcing consumer hardware into submission may
be a fun project for a spare time hacker but in general isn't a very
productive process for somebody who needs to finish a job soon or needs
to additional hardware such as PCI cards, logic analyzer, additional
memory, other CPU types etc.

  Ralf
