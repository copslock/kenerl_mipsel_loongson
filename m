Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 17:01:54 +0000 (GMT)
Received: from smtp006.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.83]:29827
	"HELO smtp006.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225243AbVA1RBi>; Fri, 28 Jan 2005 17:01:38 +0000
Received: from unknown (HELO ?10.2.2.60?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp006.bizmail.sc5.yahoo.com with SMTP; 28 Jan 2005 17:01:35 -0000
Message-ID: <41FA6FF0.4060302@embeddedalley.com>
Date:	Fri, 28 Jan 2005 09:01:36 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: bitrot in drivers/net/au1000_eth.c
References: <200501281501.19162.eckhardt@satorlaser.com>
In-Reply-To: <200501281501.19162.eckhardt@satorlaser.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Hi!
> 
> I've been debugging a problem in above mentioned file and found several cases 
> of redundant, unused or even buggy code in the handling of the MII there. 
> Also, there is a comment that suggests that I'm not the only one: 
>  * FIXME
>  * All of the PHY code really should be detached from the MAC
>  * code.

Yes, I put that in over four years ago. There was no mii code at 
all, that I could find, at that time. I wanted to separate the mii 
code out of the mac driver but it never happened.

> An important point there is that much of the code is in fact not even specific 
> to the au1x00 ethernet adapters. I found driver code for the MII I wanted to 
> drive in sis900.c, and it looked almost similar to the code in au1x00.c. 
> Simply adding the device/vendor IDs to a map and choosing the first of the 
> drivers there got my ethernet running.
> 
> Now, question is how to proceed. There are basically three ways I would go:
> 1. Leave it like it is, because someone else is working on it. I'd just post a 
> mini-patch that binds my device to an existing driver.

For 2.6, I was told someone is working on something ...

> 2. Remove the dead/unused parts from au1x00.c, try to restructure and document 
> the code so it is easier to maintain in the future.
> 3. Split off the MII handling code or, better, reuse the facility already 
> provided by drivers/net/mii.c. This would mean a significant rewrite of 
> au1x00.c, including probably breaking things on the way.

That's a possibility too but more code needs to be added to mii.c. I 
actually revisited the code yesterday and was trying to figure out 
how to clean it up. But someone told me that there is 2.6 work in 
progress to do this so I decided to just wait. Maybe someone knows 
more about it.

Pete
