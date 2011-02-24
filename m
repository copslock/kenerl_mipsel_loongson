Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 09:27:38 +0100 (CET)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:44870 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1BXI1f convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Feb 2011 09:27:35 +0100
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id D13038E00EB
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2011 00:27:23 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (bby1exg02 [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id C49A68E00DD
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2011 00:27:23 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Feb 2011 00:27:23 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: "make C=1" for mips target seems to broken
Date:   Thu, 24 Feb 2011 00:27:22 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201405C10AE0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "make C=1" for mips target seems to broken
Thread-Index: AcvT+5l19iylSWISRFGzww+qVi/XrQ==
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "linux-mips @ linux-mips . org" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 24 Feb 2011 08:27:23.0665 (UTC) FILETIME=[A959E010:01CBD3FC]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

Sparse check for mips targets seems to be broken . I think issue lies in
CHECKFLAGS . ( Probably 'sed' expression of arch/mips/Makefile ) . 

Test Environment

Host: Ubuntu 10.04
cross-gcc: gcc-4.5.1

Thanks
Anoop
