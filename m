Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 16:44:58 +0000 (GMT)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:25515
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226960AbVCVQom>; Tue, 22 Mar 2005 16:44:42 +0000
Received: from unknown (HELO ?127.0.0.1?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 22 Mar 2005 16:44:38 -0000
Message-ID: <42404B78.6090008@embeddedalley.com>
Date:	Tue, 22 Mar 2005 08:44:40 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: ohci-au1xxx.c breakage
References: <200503221638.46922.eckhardt@satorlaser.com>
In-Reply-To: <200503221638.46922.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:

>Greetings!
>
>There seem to have been some changes to the USB driver kernel API which the 
>Au1xxx driver wasn't adapted to. I just wanted to say that I'm working on it, 
>but without really knowing much about the framework so success is not 
>guaranteed... 
>
>If someone else wants to earn the fame I will happily step back. ;)
>  
>
I assume you're talking about 2.6?

If you can fix it correctly, go for it and send the patch. Otherwise 
we'll have to fix it, again, soon.

Pete
