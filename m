Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 13:15:03 +0000 (GMT)
Received: from webmail.ict.ac.cn ([IPv6:::ffff:159.226.39.7]:47833 "HELO
	ict.ac.cn") by linux-mips.org with SMTP id <S8225229AbULTNO6>;
	Mon, 20 Dec 2004 13:14:58 +0000
Received: (qmail 30447 invoked by uid 507); 20 Dec 2004 13:13:36 -0000
Received: from unknown (HELO ict.ac.cn) (fxzhang@159.226.40.187)
  by ict.ac.cn with SMTP; 20 Dec 2004 13:13:36 -0000
Message-ID: <41C6D028.5020004@ict.ac.cn>
Date: Mon, 20 Dec 2004 21:14:16 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: wuming <wuming@ict.ac.cn>
CC: linux-mips@linux-mips.org
Subject: Re: problem about dma
References: <001501c4e646$7f676c00$6f64a8c0@spark> <41C690CF.2010306@niisi.msk.ru> <002101c4e679$72938bc0$6f64a8c0@spark>
In-Reply-To: <002101c4e679$72938bc0$6f64a8c0@spark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

I think that speculative loads may be the answer.
wuming wrote:

>----- Original Message ----- 
>From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
>To: "wuming" <wuming@ict.ac.cn>
>Cc: <linux-mips@linux-mips.org>
>Sent: Monday, December 20, 2004 4:43 PM
>Subject: Re: problem about dma
>
>
>  
>
>>In 2.4, memcpy's prefetch may (and, in practice, do, no smiles, it cost 
>>me a lot of time to realize) access that memory. I though it has been 
>>fixed in 2.6 someday.
>>
>>Regards,
>>Gleb.
>>
>>    
>>
>Thank you! :)
>But I think it is not the only reason, because the CPU on my platform does not 
>support the "pref" instruction. So, memcpy's prefetch may have no effect on that 
>arrange of memory.
>
>  
>
