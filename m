Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 06:31:03 +0200 (CEST)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:38546 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491885Ab0EYEa6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 May 2010 06:30:58 +0200
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id E0CA8107009B;
        Mon, 24 May 2010 21:30:40 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id D29A61070082;
        Mon, 24 May 2010 21:30:40 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 May 2010 21:30:40 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel unaligned access
Date:   Mon, 24 May 2010 21:30:37 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404E2D356@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <alpine.LFD.2.00.1005250413430.4344@eddie.linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel unaligned access
Thread-Index: Acr7uJ2epEneMoLxQZmeHEZjnZbiKwACdbEg
References: <20100524173624.2d3ffc3d.yuasa@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2D299@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <alpine.LFD.2.00.1005250413430.4344@eddie.linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     "linux-mips" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
X-OriginalArrivalTime: 25 May 2010 04:30:40.0331 (UTC) FILETIME=[07E7D9B0:01CAFBC3]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Maciej,

Thanks for your reply but unfortunately we are not in a position to
upgrade the kernel. It will be great if you can give me some pointers to
debug the issue.

Thanks
Anoop

> -----Original Message-----
> From: Maciej W. Rozycki [mailto:macro@linux-mips.org]
> Sent: Tuesday, May 25, 2010 8:46 AM
> To: Anoop P.A.
> Cc: linux-mips; Ralf Baechle
> Subject: Re: Kernel unaligned access
> 
> On Mon, 24 May 2010, Anoop P.A. wrote:
> 
> > I am trying to run 32 bit RFS with a 64 bit kernel on a RM9000 based
> > processor board. The board is equipped with 2 GB DIMM.  When ever I
> > initiate ftp transfer of 1 GB file I am getting following unaligned
> > access error
> [...]
> > Kindly help me with your pointers to debug the issue. I am running
> > 2.6.18 kernel.
> 
>  Please try something less rotten.  That version is almost four years
old.
> Lots of issues have been fixed since then.  The current version is
2.6.34.
> 
>   Maciej
