Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 23:15:53 +0100 (BST)
Received: from 178.69-56-134.reverse.theplanet.com ([IPv6:::ffff:69.56.134.178]:33685
	"EHLO texas.onkelinx.com") by linux-mips.org with ESMTP
	id <S8225287AbUIXWPt>; Fri, 24 Sep 2004 23:15:49 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by texas.onkelinx.com (8.12.8/8.12.8) with ESMTP id i8OMFmtl030342;
	Fri, 24 Sep 2004 17:15:49 -0500
Message-ID: <41549C74.3090309@Linux4.Be>
Date: Sat, 25 Sep 2004 00:15:16 +0200
From: Filip Onkelinx <Filip@Linux4.Be>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: "Can't analyze prologue code ..." at boot time
References: <20040924085240.GP24730@enix.org> <20040924.190640.09669815.nemoto@toshiba-tops.co.jp> <20040924121107.GB24730@enix.org>
In-Reply-To: <20040924121107.GB24730@enix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Filip@Linux4.Be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Filip@Linux4.Be
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

I just applied your patch to our current 2.6.9-rc2 kernel for the BE300 
project (Casio BE300/BE500 PDA with NEC vr4131 rev1.2), and the
"Couldn't analyze prologue code .." message is gone as well.

Before, the kernel was very unreliable, but I also sync'ed with the 
latest from CVS and switched gcc version , so I'm not sure if it is your 
patch that's responsible for the stabiltity or one of the other changes.

thanks,

Filip.

 Thomas Petazzoni wrote:

>Hello,
>
>On Fri, Sep 24, 2004 at 07:06:40PM +0900, Atsushi Nemoto wrote :
>
>  
>
>>I rewrote get_wchan() to handle this problem.  Please try this patch.
>>    
>>
>
>This patch works for me. At least, the "Couldn't analyze prologue code
>at ..." message doesn't appear anymore.
>
>Thanks,
>
>Thomas
>  
>


-- 
----

Do not follow where the path may lead. Go instead where there is no path and leave a trail  - Ralph Waldo Emerson

----

Filip Onkelinx
Heidebloemstraat 20, B-3500 Hasselt, BELGIUM
fax: +32 11 65 65 97, mobile: +32 475 69 47 63
filip@onkelinx.com
