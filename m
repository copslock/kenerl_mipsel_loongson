Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 22:23:12 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37104 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225007AbUKRWXH>; Thu, 18 Nov 2004 22:23:07 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 11154184F5; Thu, 18 Nov 2004 14:23:06 -0800 (PST)
Message-ID: <419D20C9.10909@mvista.com>
Date: Thu, 18 Nov 2004 14:23:05 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net> <419D1F76.6010603@gmx.net>
In-Reply-To: <419D1F76.6010603@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

Thanks for sending this. I have one question regarding the Yosemite 
board that you have. What is the version of the Titan chip on the board? 
Is it 1.0, 1.1 or 1.2?

This is because 1.0 and 1.1 have a problem where the IP header is not 
aligned on the Rx side. As a result, there was an extra copy involved in 
the driver, i.e. titan_ge_slowpath. The latest version of the driver 
only support Titan chip revision 1.2 in which this problem is fixed

Thanks
Manish Lachwani
