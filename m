Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 16:41:06 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1277 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491083Ab1CYPlD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Mar 2011 16:41:03 +0100
X-TM-IMSS-Message-ID: <53b7e7260002be99@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 53b7e7260002be99 ; Fri, 25 Mar 2011 08:40:55 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: XLR/XLS drivers?
Date:   Fri, 25 Mar 2011 08:41:37 -0700
Message-ID: <9F4F5E1D3FF7D94388F341BE8819BA3D88A83E@orion8.netlogicmicro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: XLR/XLS drivers?
Thread-Index: Acvq/TEk3r6/mMJiRK6/j+q1e2Os4AABIpUj
References: <20110325145745.GA8483@linux-mips.org>
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle [mailto:ralf@linux-mips.org] wrote:
 
> What are your plans for merging all the XLR and XLS specific drivers?

The immediate plan is to start with the fast messaging network, USB and then PCI.
The on chip network driver code needs major cleanup and that should be the next
in line.

I have been working on the XLP code meanwhile, and the first cut will be available
in a week or so.

JC.
