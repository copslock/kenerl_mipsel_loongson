Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 14:53:47 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:57823 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021824AbXDRNxq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 14:53:46 +0100
Received: (qmail 9809 invoked by uid 507); 18 Apr 2007 21:56:03 +0800
Received: from unknown (HELO ?192.168.1.7?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 18 Apr 2007 21:56:03 +0800
Message-ID: <4626227E.4010703@ict.ac.cn>
Date:	Wed, 18 Apr 2007 21:51:58 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	tiansm@lemote.com, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 6/16] define Hit_Invalidate_I to Index_Invalidate_I for
 loongson2
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com> <20070418121139.GF3938@linux-mips.org>
In-Reply-To: <20070418121139.GF3938@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Yes, Loongson2 has no Hit_invalidate_I in fact. And although it has 
4-way icache, one Index_invalidate_I will invalidate all 4 ways of the 
same set.

The usermanual and datasheet can be downloaded from:

http://www.lemote.com/upfiles/godson2e-user-manual-V0.6.pdf


Ralf Baechle wrote:
> On Sun, Apr 15, 2007 at 11:25:55PM +0800, tiansm@lemote.com wrote:
>
>   
>> +#if defined(CONFIG_CPU_LOONGSON2)
>> +#define Hit_Invalidate_I    	0x00
>>     
>
> This #ifdef means Index_Invalidate_I and Hit_Invalidate_I will both be
> defined as zero, is that really correct?
>
> (This is the point where I would really like to have a CPU manual ...)
>
>   
>> +#else
>>  #define Hit_Invalidate_I	0x10
>> +#endif
>>     
>
>   Ralf
>
>
>
>
>   
