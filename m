Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 04:57:46 +0100 (BST)
Received: from smtp008.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.74]:11909
	"HELO smtp008.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225537AbVD1D5b>; Thu, 28 Apr 2005 04:57:31 +0100
Received: from unknown (HELO ?127.0.0.1?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp008.bizmail.sc5.yahoo.com with SMTP; 28 Apr 2005 03:57:28 -0000
Message-ID: <42705F23.3000402@embeddedalley.com>
Date:	Wed, 27 Apr 2005 20:57:23 -0700
From:	ppopov@embeddedalley.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Prashant Viswanathan <vprashant@echelon.com>
CC:	'Manish Lachwani' <mlachwani@mvista.com>, linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
References: <5375D9FB1CC3994D9DCBC47C344EEB590165465B@miles.echelon.echcorp.com>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB590165465B@miles.echelon.echcorp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Prashant Viswanathan wrote:

>>Prashant Viswanathan wrote:
>>
>>    
>>
>>>Is there a reason why the default configuration file doesn't support Big
>>>Endian for the dbAu1550?
>>>
>>>Even if I edit .config to set the endianness to "BIG" it seems to change
>>>      
>>>
>>to
>>    
>>
>>>"Little Endian" every time a make is run.
>>>
>>>Thanks
>>>Prashant
>>>
>>>
>>>
>>>
>>>      
>>>
>>In arch/mips/Kconfig,
>>
>>config CPU_LITTLE_ENDIAN
>>        bool "Generate little endian code"
>>        default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 ||
>>DDB5477 || MACH_DECSTATION
>>|| IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR ||
>>SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI ||
>>VICTOR_MPC30X || ZAO_CAPCELLA
>>        default n if MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT ||
>>MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
>>        help
>>          Some MIPS machines can be configured for either little or big
>>endian
>>          byte order. These modes require different kernels. Say Y if your
>>          machine is little endian, N if it's a big endian machine.
>>
>>So, it appears that if you have SOC_AU1X00 set, it will always be
>>configured little endian.
>>    
>>
>
>Is there a reason for this? 
>  
>
It's the more common configuration.

>Many months ago I was able to build a big-endian image and load it on my
>dbAu1550 (also configured to be BE). I just decided to update and now I find
>that it is almost as if it is not meant to be built BE.
>  
>
BE should be fine too.  We should fix this in Kconfig.

Pete
