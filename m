Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:58:23 +0200 (CEST)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:56665 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491861Ab0FBI6T convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 10:58:19 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id BB8728E00B6;
        Wed,  2 Jun 2010 01:58:08 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id AEFE48E00B2;
        Wed,  2 Jun 2010 01:58:08 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 2 Jun 2010 01:58:09 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: TITAN GE driver
Date:   Wed, 2 Jun 2010 01:58:06 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100602083255.GA23868@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TITAN GE driver
Thread-Index: AcsCLj5YbEJAOeB8Q5WudZ0mpgirdwAAiVHw
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100528162722.GB7148@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100602083255.GA23868@linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     "linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 02 Jun 2010 08:58:09.0133 (UTC) FILETIME=[B90AB1D0:01CB0231]
X-archive-position: 26996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1135

Ralf,

Thanks for the reply. 

> > allocated with same prefix. In another words all the buffers should
be
> > below < 0x1fff_ffff ( physical address) or between 0x2000_0000 and
> > 0x3fff_ffff like that.
> >
> > Is there any way to force kmalloc to allocate memory in certain
region
> > or below some region?
> 
> Nothing that would uniformly work for 32-bit and 64-bit kernels and
also
> Linux only has flags that allocate below certain addresses; nothing
that
> tells the allocator "give me something between 0x20000000 and
0x3fffffff".
> 
>   Ralf
[Anoop P.A.] You mean there are some flags available to force kmalloc to
allocate memory below some address? I couldn't find one in kmalloc man
pages.

BTW I am using 64 bit kernel.

Thanks
Anoop
