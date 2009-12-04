Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 19:12:30 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18728 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493676AbZLDSM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 19:12:27 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b19501e0001>; Fri, 04 Dec 2009 13:08:30 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 13:12:23 -0500
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 10:12:21 -0800
Message-ID: <4B195102.1020606@caviumnetworks.com>
Date:   Fri, 04 Dec 2009 10:12:18 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ed Okerson <ed.okerson@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: mmap KSEG1
References: <83f0348b0912040952h40d4d151n79ca5fc33a830ee2@mail.gmail.com>
In-Reply-To: <83f0348b0912040952h40d4d151n79ca5fc33a830ee2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2009 18:12:21.0366 (UTC) FILETIME=[528FC960:01CA750D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ed Okerson wrote:
> Is it possible to mmap an address in KSEG1 so a user space app can
> read/write to an IO device uncached?
> 

It depends on your definition of 'possible'.  The mips32/64 architecture 
specification has a 'C' field in the EntryLo register that controls 
cachability, so given an appropriate device driver it should be doable.

Calling  __ioremap() with the appropriate flags should allow you to set 
the 'C' bits.

Depending on your requirements, you might be able to get by using 
/dev/mem and some 'sync' instructions, instead of establishing an 
uncached mapping.


David Daney
