Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 20:24:38 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:60176 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225957AbVCDUYU>; Fri, 4 Mar 2005 20:24:20 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j24KNd1R014299;
	Fri, 4 Mar 2005 20:23:39 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j24KNcQn014298;
	Fri, 4 Mar 2005 20:23:38 GMT
Date:	Fri, 4 Mar 2005 20:23:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dan Malek <dan@embeddededge.com>
Cc:	JP Foster <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
Message-ID: <20050304202338.GA14128@linux-mips.org>
References: <1109157737.16445.6.camel@localhost.localdomain> <000301c5199d$3154ad40$0300a8c0@Exterity.local> <1109160313.16445.20.camel@localhost.localdomain> <cb80abe539fa80effd786cacc1340de7@embeddededge.com> <20050223150617.GA18290@linux-mips.org> <b230ff2324d488cc6e240cee05ca3af0@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b230ff2324d488cc6e240cee05ca3af0@embeddededge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2005 at 12:02:47PM -0500, Dan Malek wrote:

> >So I guess this would apply to all Alchemy-based platforms and thus I
> >should offer big endian on all of them again?
> 
> Yes, big endian should be an option.  If it doesn't work, it
> should get fixed :-)

Okay.  I don't know which of the Alchemy systems are capable of supporting
big endian at all - some might not due to unavailable firmware for example.
So I guess I'll leave cooking a patch to you or Pete.

  Ralf
