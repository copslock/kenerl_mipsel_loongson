Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 12:38:06 +0100 (CET)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:54059 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492308Ab0BCLiC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 12:38:02 +0100
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id AB8168E00A8;
        Wed,  3 Feb 2010 03:37:49 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 9ED538E0090;
        Wed,  3 Feb 2010 03:37:49 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.158]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Feb 2010 03:38:55 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Cached Base address difference.
Date:   Wed, 3 Feb 2010 03:34:25 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404809DE0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100203012934.GA20375@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cached Base address difference.
Thread-Index: AcqkcGoVEhLVXra2RxuiaAF6KL+WnQAUuWPQ
References: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com> <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com> <20100203012934.GA20375@linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 03 Feb 2010 11:38:55.0499 (UTC) FILETIME=[779115B0:01CAA4C5]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Hi list,

I am seeing a address conflict in asm-generic/spaces.h  . in spaces.h (
64 bit)CAC_BASE has been defined as 0x9800000000000000 however see mips
run says it is 0x9000000000000000
http://books.google.co.in/books?id=kk8G2gK4Tw8C&lpg=PP1&dq=see%20mips%20
run&pg=PA51#v=onepage&q=&f=false

Is this intentional?

Thanks
Anoop
