Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 20:39:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61181 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224925AbVAWUjo>; Sun, 23 Jan 2005 20:39:44 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 96E75186C2; Sun, 23 Jan 2005 12:39:42 -0800 (PST)
Message-ID: <41F40B8E.2080003@mvista.com>
Date:	Sun, 23 Jan 2005 12:39:42 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
References: <20050123192318.GA22681@prometheus.mvista.com> <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de> <20050123195129.GA1806@linux-mips.org>
In-Reply-To: <20050123195129.GA1806@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Sun, Jan 23, 2005 at 08:41:40PM +0100, Thiemo Seufer wrote:
>
>  
>
>>>Based on the feedback from Toshiba, the TX4927 processor can support different 
>>>speeds. Attached patch takes care of that. If you find this approach reasonable, 
>>>can you please check it in
>>>      
>>>
>>Shoudn't this better be tunable via /proc?
>>    
>>
>
>By the time that interface becomes available interrupt timers would
>already have been missprogrammed.  Try to calibrate the CPU timer against
>some external timer such as the RTC instead.  It's already being done
>on the Indy.
>
>  Ralf
>
>  
>
Hi Ralf,

Why is this approach (in the patch) bad?

Thanks
Manish Lachwani
