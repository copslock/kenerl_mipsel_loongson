Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:31:43 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56823 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225247AbVAaVb1>; Mon, 31 Jan 2005 21:31:27 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 94656188B7; Mon, 31 Jan 2005 13:31:25 -0800 (PST)
Message-ID: <41FEA3AD.2060102@mvista.com>
Date:	Mon, 31 Jan 2005 13:31:25 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Brad Larson <Brad_Larson@pmc-sierra.com>
Cc:	"'bkalthouse@comcast.net'" <bkalthouse@comcast.net>,
	linux-mips@linux-mips.org
Subject: Re: Running RM9000 in SMP mode
References: <04781D450CFF604A9628C8107A62FCCF013DDC16@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDC16@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Brad,

Just out of curiosity, does the processor being used below: Rm9222 have 
the five state MOESI protocol support?

Thanks
Manish Lachwani


Brad Larson wrote:

>Bryan,
>
>The following are available at ftp.pmc-sierra.com
>
>cross tools: gcc-3.3+ with E9000 core compiler optimizations
> 
>userland: demo userland, monta-vista based, native compiler does not have E9000 optimizations
>
>kernel snapshots: Yosemite/RM92xx SMP capable for 2.4.21, 2.4.26, 2.6.10
>
>doc: pmon and linux readme and board docs.  www.pmon2000.com for online pmon2000 command reference.
>
>Of course linux-mips.org for kernel sources and status, cvs-web, other userland pointers, all the port bits eventually get there.  The E9000 optimizations were committed to gcc.org, available in gcc-3.4.
>
>Datasheets and docs requiring NDA contact support@pmc-sierra.com or your sales/FAE contact.
>
>--Brad 
>
>  
>
>>-----Original Message-----
>>From: linux-mips-bounce@linux-mips.org
>>[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of
>>bkalthouse@comcast.net
>>Sent: Monday, January 31, 2005 9:22 AM
>>To: thomas.petazzoni@enix.org; mlachwani@mvista.com
>>Cc: linux-mips@linux-mips.org
>>Subject: Re: Running RM9000 in SMP mode
>>
>>
>>Hi,
>>
>>I am starting a project using a PMC Sierra  RM9222 processor. 
>> Could anyone that has used the RM9200 family please 
>>recommend a distribution and tool-chain?  What has been your 
>>experience with Linux on this processor?  What secrets and 
>>limitations have you found along the way?  I am new to MIPS and SMP.
>>
>>Thanks,
>>Bryan Althouse 
>>    
>>
> 
>
>  
>
