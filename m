Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 11:57:19 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5646 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226148AbVFCK5F>; Fri, 3 Jun 2005 11:57:05 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j53AtTks012693;
	Fri, 3 Jun 2005 11:55:29 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j53AtSn1012692;
	Fri, 3 Jun 2005 11:55:28 +0100
Date:	Fri, 3 Jun 2005 11:55:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050603105528.GA11061@linux-mips.org>
References: <20050603022113Z8226140-1340+8064@linux-mips.org> <20050603092205.GA4573@linux-mips.org> <20050603102140.GA1610@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603102140.GA1610@hattusa.textio>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 03, 2005 at 12:21:40PM +0200, Thiemo Seufer wrote:

> > I did previously object to a similar patch
> 
> I didn't know that, IIRC a similiar patch went in 2.6 before the synthesized
> TLB handlers were done.
> 
> > - why not fix tlbw_eret_hazard instead.
> 
> Like this?

Yes, that seems more like it.

  Ralf
