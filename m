Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2009 15:04:36 +0100 (CET)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:45628 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494137AbZLNOEc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Dec 2009 15:04:32 +0100
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id EEAF68E0053;
        Mon, 14 Dec 2009 05:34:13 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id E09018E004E;
        Mon, 14 Dec 2009 05:34:13 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 14 Dec 2009 05:35:18 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Help in enabling HIGHMEM support
Date:   Mon, 14 Dec 2009 05:34:13 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help in enabling HIGHMEM support
Thread-Index: Acp76Us9ZgTlFG+xR6iby0FPPn3JZAA10yWA
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     <linux-mips@linux-mips.org>
Cc:     <ralf@linux-mips.org>
X-OriginalArrivalTime: 14 Dec 2009 13:35:19.0084 (UTC) FILETIME=[470A56C0:01CA7CC2]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

We have a requirement to use a bigger RAM (1 GB / 2GB) with a RM9000
based SOC. I thought of going with HIGHMEM path rather than enabling
64bit support thinking it will be easier.

I have tried enabling HIGMEM in kernel. Board boots fine with a 512 MB
RAM plugged in. But if I connect a 1 GB RAM kernel will not boot. I am
not even getting single print from kernel. I am using linux-2.6.18
kernel.

It will be great if get any pointers suggestions in debugging this?

Thanks
Anoop 
