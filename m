Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 22:02:22 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:37219 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20148115AbYIPVCU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 22:02:20 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CF7593EC9; Tue, 16 Sep 2008 14:02:14 -0700 (PDT)
Message-ID: <48D01ED1.2010003@ru.mvista.com>
Date:	Wed, 17 Sep 2008 01:02:09 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48CC3516.9080404@ru.mvista.com>	<20080914.220512.126760706.anemo@mba.ocn.ne.jp>	<48CF8A87.6030908@ru.mvista.com> <20080917.002034.27955909.anemo@mba.ocn.ne.jp> <48CFDDAD.4050209@ru.mvista.com>
In-Reply-To: <48CFDDAD.4050209@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>>>   This doesn't look consistent (aside from the TX4939IDE_REG8/16 
>>>>> issue) -- mm_outsw_swap() calls cpu_to_le16() before writing 
>>>>> 16-bit data but this code doesn't. So, either one of those should 
>>>>> be wrong...
>>>>
>>>> Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
>>>> untested...
>>>
>>>   Hum, not necessarily...
>>>   If the data register is BE, this should work correctly, if I don't 
>>> mistake (once you fix the data register's address).
>
>> Hmm... or ide_tf_load()/ide_tf_read() is broken for big endian MIPS ?
>> (and possibly SPARC etc.)
>
>> __ide_mm_writesw(port, &data, 1) should be used instead of writew()
>> for IDE_TFLAG_OUT_DATA?
>
>    Probably the code there relies on the writew() doing the necessary 
> byte swapping -- the same as ata_{in|out}_data() must be reying on 
> ins[wl]() and outs[wl]() to do that, as well as on 
> __ide_mm_reads[wl]() and __ide_mm_writes[wl]() -- which boil down to 
> reads[wl]() and writes[wl]() on MIPS.
>    What's not clear to me is why in MIPS read[wlq]() vs reads[wlq](), 
> write[wlq]() vs writes[wl], in[wlq]() vs ins[wlq](), and out[wlq]() vs 
> outs[wlq]() are using the different byte swapping: the single form 
> uses ioswab[wlq]() while the sting form uses __mem_ioswab[wlq]() -- 
> and those are defined as one swapping bytes and the other not in 
> incluse/asm-mips/mach-generic/mangle-port.h. Cananybody shed some 
> light on this?

   Oh, I think I understand: the "single" versions take/return the value 
in host endian but the "string" version must treat the data as a stream 
of bytes.

MBR, Sergei
