Received:  by oss.sgi.com id <S553686AbRAHUAt>;
	Mon, 8 Jan 2001 12:00:49 -0800
Received: from mail.ivm.net ([62.204.1.4]:30564 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553669AbRAHUA2>;
	Mon, 8 Jan 2001 12:00:28 -0800
Received: from franz.no.dom (port91.duesseldorf.ivm.de [195.247.65.91])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id VAA29754;
	Mon, 8 Jan 2001 21:00:13 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.791030042838.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010108193010.B887@excalibur.cologne.de>
Date:   Tue, 30 Oct 1979 04:28:38 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Karsten Merker <karsten@excalibur.cologne.de>
Subject: Re: Current CVS kernel no-go on R4k Decstation
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 08-Jan-01 Karsten Merker wrote:
> On Mon, Jan 08, 2001 at 03:53:02PM +0100, Florian Lohoff wrote:
> 
>> Hi,
>> i am seeing this on my R4k Decstation (5000/150) 
>> 
>> This was the first try 
>> 
>> [...]
>> Freeing unused PROM memory: 124k freed
>> Freeing unused kernel memory: 60k freed
>> [init:1] Illegal instruction 0320f809 at 0fb651c4 ra=0fb651cc
>> [init:1] Illegal instruction 8f998018 at 0fb651c8 ra=0fb651cc
>> 
>> Second try doesnt give me any output at all after
>> the "Freeing unused kernel ..."
>> 
>> CVS Checkout @ 20010108 ~15:00 MESZ
>                                  ^^^^
> Is it still summer in Westfalen :-) ?
> 
> Similar effect for me (DS5000/150, Checkout @ Sat Jan 6 ~22:30 CET),
> except that I do not get the "illigal instruction" lines. Harald has the
> same problem on his /260. It looks like sometime in December 2000
> something has gone broken in the R4K-support, or are we perhaps
> triggering a compiler bug in egcs 1.1.2?

I don't think so. This hang appeared in the middle of December and may or may
not be related to the MIPS32 patches which were commited then. Unfortunately I
haven't had the time to track this down.

Anyway, is anybody else with a R4X00 machines seeing this?

-- 
Regards,
Harald
