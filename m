Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 18:32:05 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:4310 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225362AbTJ1ScC>;
	Tue, 28 Oct 2003 18:32:02 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 28 Oct 2003 10:31:59 -0800
Message-ID: <3F9EB61F.8010906@avtrex.com>
Date: Tue, 28 Oct 2003 10:31:59 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: Unresolved symbols
References: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2003 18:31:59.0608 (UTC) FILETIME=[C6147F80:01C39D81]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Kesselring wrote:

>I've been unabled to track down these errors. I think it's because I don't
>understand how some of the linux h files are used by an independently
>compiled kernel module. Why is "extern __inline__" used in a file like
>atomic.h.
>If any of you have any pointers on the following errors, I'd appreciate
>your comments.
>/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol
>atomic_sub_return
>/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol __udelay
>/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_add
>/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol strcpy
>/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_sub
>  
>
Often if you don't compile with optimization turned on you get things 
like this.  You have to compile with optimization set high enough to get 
inlining enabled.

David Daney.
