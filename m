Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:48:47 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:8202 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465573AbVI3Kmg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLum005536;
	Fri, 30 Sep 2005 11:42:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8TNoPB4004496;
	Fri, 30 Sep 2005 00:50:25 +0100
Date:	Fri, 30 Sep 2005 00:50:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: DISCONTIGMEM suuport on 32 bits MIPS
Message-ID: <20050929235025.GC3983@linux-mips.org>
References: <cda58cb80509260216591eb96b@mail.gmail.com> <20050926122114.GC3175@linux-mips.org> <cda58cb80509260546a6f4118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80509260546a6f4118@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 02:46:02PM +0200, Franck wrote:

> > IP27 currently the only system that absolutely needs discontiguous
> > memory in order to work at all.  A few other systems could make use of
> > discontiguous memory to reduce the waste of memory - the family of
> > Broadcom SB1 based systems comes to mind.
> 
> Isn't discontiguous memory common for embedded system as well ? I
> thought so...Anyways can we make discontiguous memory thing move into
> generic MIPS code so every future needs for that will profit ? I
> looked at other arch, and they seem to implement it that way (in
> arch/xxx/mm/discontig.c).

Yes, that would be a good thing.  There are several platforms that could
make good use of discontiguous memory support such as Broadcom's Sibyte
SoCs with their insanely large hole in the memory map but also others.

  Ralf
