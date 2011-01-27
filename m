Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 13:28:44 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:51507 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1A0M2l convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jan 2011 13:28:41 +0100
Received: by iyj21 with SMTP id 21so1467131iyj.36
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 04:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W0MzHKS86RW5/7SobPSGVt9y1cXpWuBq/WAWvR4o8uc=;
        b=vkIcZ957giJXkDOEEWIkUfFsIv+e044lKdgZEKot74qINaBROcaOPFEsvwpToKhmBu
         axK+omn7tEVZ2a3DO6OoouO8I7o3PLapn5wAgiOHtaQ5zWaSXYqEvQQHzVs07aCDuA5B
         J7ZJWJHZ6fq+X1bc6Xrh95/IPHT4frUkeWJzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fRRxNe7m9kYOO4P5+YDoTJkkKdC9ckS7FtNbsAz0FVsrTDDtmpPkm3IeZHpHD3geF5
         JP4tzL22z5GRfl7yvx8hiqZGPhCIsWndy24/nXCxzGi4myFHhCGFhAHKBwtAt7UowLe6
         wj0eNhV76LLIoxAtj2X2opXCePmIYP8rBCFQU=
MIME-Version: 1.0
Received: by 10.42.230.67 with SMTP id jl3mr2112069icb.30.1296131314943; Thu,
 27 Jan 2011 04:28:34 -0800 (PST)
Received: by 10.42.195.199 with HTTP; Thu, 27 Jan 2011 04:28:34 -0800 (PST)
In-Reply-To: <4D4156CF.1040909@mvista.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
        <AANLkTi=zfr5YuwBCcvH2Jas50UxnUtvzp_CDyN25sT5h@mail.gmail.com>
        <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com>
        <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>
        <4D4156CF.1040909@mvista.com>
Date:   Thu, 27 Jan 2011 20:28:34 +0800
Message-ID: <AANLkTimdXa9WS7WLuKgD4iOCXcwvi5gPf5fQ2_eMsiW_@mail.gmail.com>
Subject: Re: Fwd: about udelay in mips
From:   loody <miloody@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     gcc-help <gcc-help@gcc.gnu.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi:
>   Probably because in 2.6.30 you only cast the result of 32-bit multiplies
> to 64 bits. In the 2.6.33 kernel, the mutliplies are 64-bit as the
> 0x000010c7ull constant is 64-bit...

>> void __udelay(unsigned long us)
>> {
>>        unsigned int lpj = current_cpu_data.udelay_val;
>>
>>        __delay(((unsigned long long)(us * 0x000010c7 * HZ * lpj)) >> 32);
so that means (us * 0x000010c7 * HZ * lpj)  is calculated at 32-bits and finally
(unsigned long long) cast it as 64-bits?
if i remember correctly, "64bit cast to 32-bits" is possible get 0
value, since high bits cast out.
But how 34-bits cast to 64-bits will make the value as 0 if original
low 32-bits value is non-zero?
appreciate your reply,
miloody

>> 80306ed0:       00001821        move    v1,zero
>> 80306ed4:       00601021        move    v0,v1
>> #include<asm/compiler.h>
>> #include<asm/war.h>
>>
>> inline void __delay(unsigned int loops)
>> {
>>        __asm__ __volatile__ (
>> 80306ed8:       1440ffff        bnez    v0,80306ed8 <__udelay+0x8>
>> 80306edc:       2442ffff        addiu   v0,v0,-1
>> void __udelay(unsigned long us)
>
>> I have double checked the __delay source code of 2.6.33.4
>> and the dis-assemblies:
>
>> void __udelay(unsigned long us)
>> {
>>        unsigned int lpj = current_cpu_data.udelay_val;
>>
>>        __delay((us * 0x000010c7ull * HZ * lpj) >> 32);
>> 802f7310:       3c02804f        lui     v0,0x804f
>> 802f7314:       8c429360        lw      v0,-27808(v0)
>> 802f7318:       3c050010        lui     a1,0x10
>> 802f731c:       34a56256        ori     a1,a1,0x6256
>> 802f7320:       00450019        multu   v0,a1
>> 802f7324:       00002821        move    a1,zero
>> 802f7328:       00001012        mflo    v0
>> 802f732c:       00001810        mfhi    v1
>> 802f7330:       00a20018        mult    a1,v0
>> 802f7334:       70640000        madd    v1,a0
>> 802f7338:       00003012        mflo    a2
>> 802f733c:       00440019        multu   v0,a0
>> 802f7340:       00001810        mfhi    v1
>> 802f7344:       00c31021        addu    v0,a2,v1
>> #include<asm/compiler.h>
>> #include<asm/war.h>
>>
>> inline void __delay(unsigned int loops)
>> {
>>        __asm__ __volatile__ (
>> 802f7348:       1440ffff        bnez    v0,802f7348 <__udelay+0x38>
>> 802f734c:       2442ffff        addiu   v0,v0,-1
>> void __udelay(unsigned long us)
>> {
>>        unsigned int lpj = current_cpu_data.udelay_val;
>>
>>        __delay((us * 0x000010c7ull * HZ * lpj)>>  32);
>> }
>> 802f7350:       03e00008        jr      ra
>
> WBR, Sergei
>



-- 
Regards,
