Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 18:25:49 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60665 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225417AbVDHRZe>; Fri, 8 Apr 2005 18:25:34 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 8B5F618C23; Fri,  8 Apr 2005 10:25:32 -0700 (PDT)
Message-ID: <4256BE8C.4060607@mvista.com>
Date:	Fri, 08 Apr 2005 10:25:32 -0700
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	sjhill@realitydiluted.com
Cc:	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org
Subject: Re: NPTL
References: <E1DJx9N-0000KA-M7@real.realitydiluted.com>
In-Reply-To: <E1DJx9N-0000KA-M7@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

sjhill@realitydiluted.com wrote:

>>I saw the kernel support patch (TLS) a while back and ment to ask what 
>>state the gcc/glibc patches were in. Has either been picked up into the 
>>gnu projects yet? If they're close I might try building a toolchain and 
>>root file system with NPTL to try our test suite on.
>>
>>    
>>
>The kernel patch has not gone in and probably will not until a lot more
>testing has been done. All of the changes to binutils, gcc and glibc
>have been checked in and are available from HEAD of cvs for respective
>repositories.
>
>-Steve
>
>  
>
Steve,

I thought the kernel patch was well tested by Daniel.

Thanks
Manish Lachwani
