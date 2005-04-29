Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 17:08:58 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64502 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8226002AbVD2QIm>; Fri, 29 Apr 2005 17:08:42 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id A591418F3C; Fri, 29 Apr 2005 09:08:39 -0700 (PDT)
Message-ID: <42725C07.6050100@mvista.com>
Date:	Fri, 29 Apr 2005 09:08:39 -0700
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	'Ralf Baechle' <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: your mail (yosemite + 2.6.x issues)
References: <20050429135220Z8225807-1340+6357@linux-mips.org>
In-Reply-To: <20050429135220Z8225807-1340+6357@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Do you load the kernel first and then do a "go"? If you load the kernel 
first using the "load" command, then you should come back to the PMON 
prompt where you can type a "go". I was not clear about it from your 
email below.

Thanks
Manish Lachwani

Bryan Althouse wrote:

>Thanks Ralf, now I can compile the kernel.  But, I don't get any serial
>console output when I try to boot it.  Actually, I get a single line that
>looks like this:
>
>Loading file: tftp://192.168.2.39/vmlinux (elf)
>0x80100000/2288188 + 0x8032ea3c/111372(z) + 4125 syms|
>
>I have found PMC's "yosemite_defconfig" file and I am using it as the
>".config". I have tried using CONFIG_PMC_INTERNAL_UART=y and I have also
>tried commenting it out.  Either way, I get no console output.
>
>Thanks for the help!
>Bryan
>
>-----Original Message-----
>From: Ralf Baechle [mailto:ralf@linux-mips.org] 
>Sent: Friday, April 29, 2005 7:03 AM
>To: Bryan Althouse
>Cc: linux-mips@linux-mips.org; TheNop@gmx.net
>Subject: Re: your mail
>
>On Thu, Apr 28, 2005 at 03:15:49PM -0400, Bryan Althouse wrote:
>
>  
>
>>I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
>>Somehow, I am unable to compile the kernel.  I have tried the 2.6.10
>>    
>>
>kernel
>  
>
>>trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
>>linux-mips.  I am using the 3.3.x cross compile tools from
>>ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
>>
>>In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
>>       Make[3]: *** [drivers/char/agp/backend.o] Error 1
>>    
>>
>
>Configuring AGP support for a MIPS kernel is obviously nonsense.  Disable
>CONFIG_AGP.
>
>  
>
>>In the case of 2.6.12 from linux-mips, my error looks like:
>>	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
>>here (not in a function)
>>    
>>
>
>Whoops, a bug.  The function indeed doesn't exist even though it should,
>will fix that.  You will hit this bug only if compiling the titan driver
>as a module, so workaround set CONFIG_TITAN_GE=y.  Which for the typical
>titan-based device seems to be the preferable choice anyway.
>
>  Ralf
>
>
>
>  
>
