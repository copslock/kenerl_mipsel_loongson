Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 18:51:51 +0000 (GMT)
Received: from mxout1.netvision.net.il ([IPv6:::ffff:194.90.9.20]:40778 "EHLO
	mxout1.netvision.net.il") by linux-mips.org with ESMTP
	id <S8227126AbVCVSvg>; Tue, 22 Mar 2005 18:51:36 +0000
Received: from [192.168.1.199] ([212.143.245.6]) by mxout1.netvision.net.il
 (Sun Java System Messaging Server 6.1 HotFix 0.09 (built Dec 14 2004))
 with ESMTP id <0IDR008Z2ODUYAH0@mxout1.netvision.net.il> for
 linux-mips@linux-mips.org; Tue, 22 Mar 2005 20:51:30 +0200 (IST)
Date:	Tue, 22 Mar 2005 20:51:42 +0200
From:	Gilad Rom <gilad@romat.com>
Subject: Re: Au1500 and 1Gbps
In-reply-to: <42406826.2040302@embeddedalley.com>
To:	ppopov@embeddedalley.com
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Message-id: <4240693E.3060207@romat.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <42406706.90409@romat.com> <42406826.2040302@embeddedalley.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

>>
>> Any insight? can the Au1500 even try to handle 1000Mbps?
> 
> 
> Should be easy to get up and running the benchmarked. The Intel 1G 
> driver (e100?) should run fine on mips with, hopefully, little or no 
> modifications.
> 
> Pete

Do you see any theoretical limitation on the Au1500 which
would prevent it from utilizing the full 1000Mbps bandwidth?

Gilad.
