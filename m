Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 03:33:31 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60430 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494059AbZKDCdY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 03:33:24 +0100
Received: by pzk32 with SMTP id 32so4521247pzk.21
        for <multiple recipients>; Tue, 03 Nov 2009 18:33:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KnpxVd5lZ0/PuQEVz3+hYMUwMA6tpJVJgjIPqFklATM=;
        b=WNU2Hayju+wuES+ziRd7H2HFed8a9iZmYp8jPpz3jUKjWBR9oOHECwruT4kx4ORqEh
         8houHNBfzswqVNyFIWWozcvMkH7lH9xoTtITq3WUZoKGTTttXI9nSBnM9vKS9CaVBRf3
         MtjJTGNXZOw8r6rpkY7aM6uvbsDsbPvTy9Wz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i/CaQ44GAjaam7oQCP5BgywtEFvqeeEtKYm7wZRYC5u7fMRpj9jwy/qC3/0sNFZC3e
         0KemNWdVpn3p+BC0oNQBDoRFYV9cOv/JcZm5gzfES3eONtmrAgtBzFevHOR31srX6RwB
         yZhkhV/GoGv1Cdo74yeFL50RCa/RsJhbbye0s=
MIME-Version: 1.0
Received: by 10.142.151.5 with SMTP id y5mr83496wfd.329.1257301995103; Tue, 03 
	Nov 2009 18:33:15 -0800 (PST)
In-Reply-To: <20091102071724.GB13360@linux-mips.org>
References: <3a665c760911010618u7216cd68wfbd02610d2029862@mail.gmail.com>
	 <20091102071724.GB13360@linux-mips.org>
Date:	Wed, 4 Nov 2009 10:33:14 +0800
Message-ID: <3a665c760911031833s4b8dba82o67a8e7bcc225d28f@mail.gmail.com>
Subject: Re: why we use multu to implement udelay
From:	loody <miloody@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Hi:
thanks for your kind help :)

2009/11/2 Ralf Baechle <ralf@linux-mips.org>:
> On Sun, Nov 01, 2009 at 10:18:14PM +0800, loody wrote:
>
>> If I search the right place in mip kernel, I find the kernel implement
>> udelay by multu and bnez looping, in 32-bits mode.
>>       if (sizeof(long) == 4)
>>               __asm__("multu\t%2, %3"
>>               : "=h" (usecs), "=l" (lo)
>>               : "r" (usecs), "r" (lpj)
>>               : GCC_REG_ACCUM);
>>       else if (sizeof(long) == 8)
>>               __asm__("dmultu\t%2, %3"
>>               : "=h" (usecs), "=l" (lo)
>>               : "r" (usecs), "r" (lpj)
>>               : GCC_REG_ACCUM);
>>
>>       __delay(usecs);
>> why we doing so instead of using kernel timer function and the
>> precision will be incorrect if the cpu runs faster or slower, right?
>
> This is an old-fashioned implementation which will work even on systems
> where no CPU timer is available or its frequency is unknown or variable.
>
> A while ago patches were posted to use the cp0 counter instead but do
> to other necessary rewrites those patches went stale, so need to be
> reworked before they can be applied.  Either way, for above restrictions
> the delay by looping implementation will still be needed as the fallback
> implementation.
>
>  Ralf
I find in the __udelay we will first calculate out the value of
counter then sent to __delay for looping.

The formula of counter value is like below:
#if defined(CONFIG_64BIT) && (HZ == 128)
	usecs *= 0x0008637bd05af6c7UL;		/* 2**64 / (1000000 / HZ) */
#elif defined(CONFIG_64BIT)
	usecs *= (0x8000000000000000UL / (500000 / HZ));
#else /* 32-bit junk follows here */
	usecs *= (unsigned long) (((0x8000000000000000ULL / (500000 / HZ)) +
	                           0x80000000ULL) >> 32);
#endif

Is there any rule or principle that tells us how to get this value?
appreciate your help,
miloody
