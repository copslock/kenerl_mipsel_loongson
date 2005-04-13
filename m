Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 12:37:02 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:549 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225795AbVDMLgr>; Wed, 13 Apr 2005 12:36:47 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 13 Apr 2005 07:32:14 -0400
Message-ID: <425D0448.6010700@timesys.com>
Date:	Wed, 13 Apr 2005 07:36:40 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Stuart Longland <stuartl@longlandclan.hopto.org>
CC:	linux-mips@linux-mips.org
Subject: Re: BogoMIPS
References: <425BDCE4.6070708@timesys.com> <425C9DBF.6090807@longlandclan.hopto.org>
In-Reply-To: <425C9DBF.6090807@longlandclan.hopto.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2005 11:32:14.0656 (UTC) FILETIME=[70DA8C00:01C5401C]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Stuart Longland wrote:

>
> So honestly, I don't know what's happening with BogoMIPS. :-)  What I do
> know however, it isn't worth a cracker in terms of benchmarking value. 
> ;-)

I could care less about it as a benchmarking value, but it's used to do 
calibrated udelays.  If mips doesn't need it because it calibrates some 
other way then fine. I suspect not though and we're probably using an 
initial works everywhere value. I don't know though.

Greg Weeks
