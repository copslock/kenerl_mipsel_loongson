Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2005 16:24:30 +0000 (GMT)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:37256
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8229702AbVCZQYP>; Sat, 26 Mar 2005 16:24:15 +0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 26 Mar 2005 16:24:12 -0000
Message-ID: <42458CB1.9040009@embeddedalley.com>
Date:	Sat, 26 Mar 2005 08:24:17 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: board configuration and status registers (BCSR)
References: <200503261359.10332.eckhardt@satorlaser.com>
In-Reply-To: <200503261359.10332.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Hi!
> 
>>From what I could tell, all the Alchemy based boards have those BCSR, but I 
> wonder where I could find more info about those. The Au1100 programming 
> manual is totally silent on that matter but in the attached hardware itself I 
> couldn't find anything that corresponds to that - or am I just not looking 
> hard enough? Could anybody point me to some docs on that?

AMD ships a CD with all the docs, including the onboard cpld registers. They are 
described in a spreadsheet. I'm pretty sure they are also available on their web 
site, under the PCS division.

Pete
