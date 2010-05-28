Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 07:52:08 +0200 (CEST)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:42551 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab0E1FwE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 May 2010 07:52:04 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 29C6A8E00E5
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 22:51:49 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 20B088E00B3
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 22:51:49 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 May 2010 22:51:49 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: TITAN GE driver
Date:   Thu, 27 May 2010 22:51:47 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TITAN GE driver
Thread-Index: Acr+KdwpD+QJ3WZ3SL2QVABMpv3b+g==
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 28 May 2010 05:51:49.0186 (UTC) FILETIME=[DD356A20:01CAFE29]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

 

Any body used titan GE device with more than 512MB physical memory?   

 

If buffer is getting allocated above physical address 0x1fff_ffff ( ie.
30 bit buffer address) we may have to consider setting XDMA_BUFFADDRPRE
(0x5018 ) .This is not taken care in original driver.  Any body had luck
in enabling this prefix. I have tried enabling it and I could do flood
ping with out packet loss. However when I do mass data transfer kernel
getting panic. Further investigation showed kenel panics because DMA
copies data to wrong address (which is being used).

 

Any body had luck with this kindly share there experience?

 

Thanks

Anoop
