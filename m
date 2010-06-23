Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2010 13:26:02 +0200 (CEST)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:42517 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491201Ab0FWLZ4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jun 2010 13:25:56 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id AE0DA8E003B;
        Wed, 23 Jun 2010 04:25:40 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 671488E0039;
        Wed, 23 Jun 2010 04:25:40 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 23 Jun 2010 04:25:40 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: soft-float
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:   Wed, 23 Jun 2010 04:25:39 -0700
Message-ID: <BE430C874DBA6841A75E65151DCC6E1C04076696@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: soft-float
Thread-Index: AcsJk/HHfPUceqYDQ4aHLSSNICEpiQJMAixV
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca><AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com><4C126D2A.6040305@caviumnetworks.com><4C127358.3030905@paralogos.com> <AANLkTikIur8HkXppazHT7AT2oUkNz2Mf3qvDZiLR-r25@mail.gmail.com>
From:   "Jabir M" <Jabir_M@pmc-sierra.com>
To:     "Manuel Lauss" <manuel.lauss@googlemail.com>,
        "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "David Daney" <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
X-OriginalArrivalTime: 23 Jun 2010 11:25:40.0416 (UTC) FILETIME=[CF7E0C00:01CB12C6]
X-archive-position: 27244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jabir_M@pmc-sierra.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15946




 
On Fri, Jun 11, 2010 at 7:33 PM, Kevin D. Kissell <kevink@paralogos.com> wrote:
>> An optimized, assembly-language soft-float library implementation is *much*
>> faster than the kernel emulator, but I benchmarked it once upon a time
>> against a portable gnu soft-float library in C, and the difference wasn't
>> nearly as dramatic.

> The in-kernel emulator always works.  The float conformance test app Ralf
> pointed out a few weeks ago doesn't run correctly when built with a recent
> softfloat gcc with any optimization higher than O0 (tested with 4.4.4, 4.3.4).
> I'd take correctness over speed any day of the week...

Thank you all for your comments. I have compiled a new crosstoolchain( gcc 4.3.3 binutils 2.19.1 and glibc 2.9) and library with soft float enabled. I could see considerable performance improvement with my application.
Coming back to correctnes , I ran paranoia.c [1] for verification and I got following result

"No failures, defects nor flaws have been discovered.
Rounding appears to conform to the proposed IEEE standard P754.
The arithmetic diagnosed appears to be Excellent!"

Shall I beleive the results and go ahead with soft float ?. Is there any other test to verify reliability of soft float ?.

Thanks and Regards
Jabir

[1] http://www.netlib.org/paranoia/paranoia.c
