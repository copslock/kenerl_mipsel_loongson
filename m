Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 21:28:46 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37359 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225397AbVAXV2b>; Mon, 24 Jan 2005 21:28:31 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 6FD14188BC; Mon, 24 Jan 2005 13:28:29 -0800 (PST)
Message-ID: <41F5687D.30802@mvista.com>
Date:	Mon, 24 Jan 2005 13:28:29 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
References: <20050123192318.GA22681@prometheus.mvista.com> <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de> <20050123195129.GA1806@linux-mips.org> <41F40B8E.2080003@mvista.com> <20050124202244.GB2376@linux-mips.org> <41F55F15.6050107@mvista.com> <Pine.LNX.4.61L.0501242107040.17587@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0501242107040.17587@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Mon, 24 Jan 2005, Manish Lachwani wrote:
>
>  
>
>>>>Why is this approach (in the patch) bad?
>>>>        
>>>>
>[...]
>  
>
>>>It's fragile because clock frequencies are changing faster in today's
>>>world of electronics than the weather in April.
>>>      
>>>
>[...]
>  
>
>>So? Can you be a little more clear?
>>    
>>
>
> Oh well, how can you assure a given binary will be booted on a CPU driven 
>by the right frequency?  Is the clock source inside the chip containing 
>the CPU at least?
>
>  Maciej
>
>  
>
Ok, that make things clear. Thanks Maciej,

Manish Lachwani
