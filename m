Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 20:15:29 +0100 (CET)
Received: from dns1.mips.com ([63.167.95.197]:48920 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492715Ab0BCTPR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 20:15:17 +0100
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id o13JF6cE009952;
        Wed, 3 Feb 2010 11:15:06 -0800
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Feb 2010 11:15:06 -0800
Message-ID: <4B69CB39.1090504@mips.com>
Date:   Wed, 03 Feb 2010 11:15:05 -0800
From:   Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Cached Base address difference.
References: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com> <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com> <20100203012934.GA20375@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404809DE0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100203123331.GB20375@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404809DEA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404809DEA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2010 19:15:06.0228 (UTC) FILETIME=[31CAE340:01CAA505]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Anoop P.A. wrote:
> Hi Ralf,
> 
> I am sorry if it is not clear from my last mail.
> 
> What I want to convey is, 
> 
> "See MIPS Run" explains "window on physical memory (cached)" will start
> @ 0x9000_0000_0000_0000.  
> 
> You can see "See MIPS Run" page under suspect from this link
> http://books.google.co.in/books?id=kk8G2gK4Tw8C&lpg=PP1&dq=see%20mips%20
> run&pg=PA51#v=onepage&q=&f=false
> 
> How ever as you mentioned Linux source defines CAC_BASE
> 0x98000000_00000000

The Linux header file is correct; the cached and uncached regions are 
swapped in the "See MIPS Run" diagram.

The full MIPS64 memory map is documented in Volume III of the 
architecture manual which you can download from 
http://www.mips.com/products/architectures/mips64/

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
