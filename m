Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 20:23:12 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47098 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224937AbUKRUXI>; Thu, 18 Nov 2004 20:23:08 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 6214E18492; Thu, 18 Nov 2004 12:23:06 -0800 (PST)
Message-ID: <419D04AA.50508@mvista.com>
Date: Thu, 18 Nov 2004 12:23:06 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net>
In-Reply-To: <419D03DE.8090403@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

TheNop wrote:
> Hello,
> 
> using DHCP support on the yosemite target with the current sources did 
> not work anymore.
> The DHCP request timed out.
> Using the sources from cvs lable linux_2_6_8_1 for the titan ethernet 
> driver works around this problem.
> 
> Best regards
> TheNop
> 
> 
> 
Hello !

Can you send the diff between the titan_ge (both .c and .h files) driver 
version in linux_2_6_8_1 and the latest driver sources?

Thanks
Manish Lachwani
