Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 08:02:33 +0000 (GMT)
Received: from smtp008.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.74]:60854
	"HELO smtp008.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225248AbVCPICR>; Wed, 16 Mar 2005 08:02:17 +0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp008.bizmail.sc5.yahoo.com with SMTP; 16 Mar 2005 08:02:14 -0000
Message-ID: <4237E80F.90305@embeddedalley.com>
Date:	Wed, 16 Mar 2005 00:02:23 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
References: <200503151245.15920.eckhardt@satorlaser.com> <200503160651.42705.eckhardt@satorlaser.com> <4237CCDC.1030104@embeddedalley.com> <200503160816.52467.eckhardt@satorlaser.com>
In-Reply-To: <200503160816.52467.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


>>Or, you use the ide mode/feature of CF and get it to work that way, but
>>I've never had to do that myself. Then the card looks like an ide device.
>>That's something one of our guys at Embedded Alley has done in the past.
>>Don't know how easy it is; I'll ping him.
> 
> 
> Sounds like another way to go, in particular since I don't need hotplugging 
> and other PCMCIA features (and their overhead).

Right. And it shouldn't be that hard, but the support just isn't there so some 
work is involved. Finding an example would be the way to go.

> Pete, I owe you a beer. I can see a few things much, much clearer now, thanks!

So open source is indeed about free beer :)

Pete
