Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 16:03:16 +0200 (CEST)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:46691 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491828Ab0FBODI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 16:03:08 +0200
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 66FF3107008B;
        Wed,  2 Jun 2010 07:02:57 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id 56FAE107006A;
        Wed,  2 Jun 2010 07:02:57 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 2 Jun 2010 07:02:57 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: TITAN GE driver
Date:   Wed, 2 Jun 2010 07:02:55 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404E2DCC1@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100602134810.GC4388@ericsson.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TITAN GE driver
Thread-Index: AcsCWkmg+revDixXR1q+Obj5SiPzWwAAJCSw
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100528162722.GB7148@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100602083255.GA23868@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100602134810.GC4388@ericsson.com>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Guenter Roeck" <guenter.roeck@ericsson.com>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 02 Jun 2010 14:02:57.0621 (UTC) FILETIME=[4DD48050:01CB025C]
X-archive-position: 27002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1373

> > > Linux only has flags that allocate below certain addresses;

I am probably confused by this line ( BTW I know there is a flag
GFP_DMA32 which will force kmalloc to allocate below 4GB) I was just
wondering if there is a flag to allocate memory below 512MB . 

> >
> Ralf said "nothing". My reading is that such a flag is _not_
available.
> 
> Guenter
