Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 19:14:18 +0000 (GMT)
Received: from mail.lvl7.com ([IPv6:::ffff:66.21.69.202]:41645 "EHLO
	lvl7ser4.lvl7.com") by linux-mips.org with ESMTP
	id <S8225470AbUAOTOR>; Thu, 15 Jan 2004 19:14:17 +0000
Received: from savage.dyndns.pengo.lvl7.com (grantc-cd310vm [192.168.77.181]) by lvl7ser4.lvl7.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2655.55)
	id C7DFXPDC; Thu, 15 Jan 2004 14:17:25 -0500
Received: from lvl7.com (localhost.localdomain [127.0.0.1])
	by savage.dyndns.pengo.lvl7.com (8.11.6/8.11.6) with ESMTP id i0FJE9X17410;
	Thu, 15 Jan 2004 14:14:10 -0500
Message-ID: <4006E67F.7010906@lvl7.com>
Date: Thu, 15 Jan 2004 14:14:07 -0500
From: "John W. Linville" <linville@lvl7.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charlie Brady <charlieb-linux-mips@e-smith.com>
CC: linux-mips@linux-mips.org
Subject: Re: Broadcom 4702?
References: <Pine.LNX.4.44.0401151343460.17500-100000@allspice.nssg.mitel.com>
In-Reply-To: <Pine.LNX.4.44.0401151343460.17500-100000@allspice.nssg.mitel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linville@lvl7.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@lvl7.com
Precedence: bulk
X-list: linux-mips

Charlie Brady wrote:

>+ifdef CONFIG_BCM4710
>+GCCFLAGS       += -m4710a0kern
> endif
>
>I haven't tried building and running a kernel built without the gcc 
>workarounds, so I don't know whether they are only required for early 
>  
>
I don't know about the 4710 or 4702 (I haven't got around to that yet), 
but the 4704 doesn't seem to need any special flags for building the 
kernel (or anything else).

Of course, YMMV...

John

-- 
John W. Linville
LVL7 Systems, Inc.
