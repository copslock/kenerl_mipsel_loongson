Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 12:29:31 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:49305 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1A0L31 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jan 2011 12:29:27 +0100
Received: by ewy20 with SMTP id 20so689493ewy.36
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 03:29:27 -0800 (PST)
Received: by 10.14.48.2 with SMTP id u2mr1935294eeb.30.1296127767149;
        Thu, 27 Jan 2011 03:29:27 -0800 (PST)
Received: from [192.168.2.2] ([91.79.86.100])
        by mx.google.com with ESMTPS id t50sm12841003eeh.12.2011.01.27.03.29.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Jan 2011 03:29:25 -0800 (PST)
Message-ID: <4D4156CF.1040909@mvista.com>
Date:   Thu, 27 Jan 2011 14:28:15 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     loody <miloody@gmail.com>
CC:     gcc-help <gcc-help@gcc.gnu.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Fwd: about udelay in mips
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>        <AANLkTi=zfr5YuwBCcvH2Jas50UxnUtvzp_CDyN25sT5h@mail.gmail.com>        <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com> <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>
In-Reply-To: <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 27-01-2011 12:20, loody wrote:

> hi all:
> I guess there seems be some differences about
> "unsigned long long" and "ull" so I forward the letter to gcc-help.
> If my guess is correct, what are the differences between them and why
> "unsigned long long" cannot let compiler compile the 64-bits
> operations as I want?

    Probably because in 2.6.30 you only cast the result of 32-bit multiplies 
to 64 bits. In the 2.6.33 kernel, the mutliplies are 64-bit as the 
0x000010c7ull constant is 64-bit...

> thanks a lot,
> miloody

> I found my kernel will compile udelay(xx) as zero no matter what xx I filled in.
> below are the dis-assemblies:
> (as you can see the v0 = v1 = zero.)
> My version is 2.6.30.9:
> void __udelay(unsigned long us)
> {
>         unsigned int lpj = current_cpu_data.udelay_val;
>
>         __delay(((unsigned long long)(us * 0x000010c7 * HZ * lpj)) >> 32);
> 80306ed0:       00001821        move    v1,zero
> 80306ed4:       00601021        move    v0,v1
> #include<asm/compiler.h>
> #include<asm/war.h>
>
> inline void __delay(unsigned int loops)
> {
>         __asm__ __volatile__ (
> 80306ed8:       1440ffff        bnez    v0,80306ed8 <__udelay+0x8>
> 80306edc:       2442ffff        addiu   v0,v0,-1
> void __udelay(unsigned long us)

> I have double checked the __delay source code of 2.6.33.4
> and the dis-assemblies:

> void __udelay(unsigned long us)
> {
>         unsigned int lpj = current_cpu_data.udelay_val;
>
>         __delay((us * 0x000010c7ull * HZ * lpj) >> 32);
> 802f7310:       3c02804f        lui     v0,0x804f
> 802f7314:       8c429360        lw      v0,-27808(v0)
> 802f7318:       3c050010        lui     a1,0x10
> 802f731c:       34a56256        ori     a1,a1,0x6256
> 802f7320:       00450019        multu   v0,a1
> 802f7324:       00002821        move    a1,zero
> 802f7328:       00001012        mflo    v0
> 802f732c:       00001810        mfhi    v1
> 802f7330:       00a20018        mult    a1,v0
> 802f7334:       70640000        madd    v1,a0
> 802f7338:       00003012        mflo    a2
> 802f733c:       00440019        multu   v0,a0
> 802f7340:       00001810        mfhi    v1
> 802f7344:       00c31021        addu    v0,a2,v1
> #include<asm/compiler.h>
> #include<asm/war.h>
>
> inline void __delay(unsigned int loops)
> {
>         __asm__ __volatile__ (
> 802f7348:       1440ffff        bnez    v0,802f7348 <__udelay+0x38>
> 802f734c:       2442ffff        addiu   v0,v0,-1
> void __udelay(unsigned long us)
> {
>         unsigned int lpj = current_cpu_data.udelay_val;
>
>         __delay((us * 0x000010c7ull * HZ * lpj)>>  32);
> }
> 802f7350:       03e00008        jr      ra

WBR, Sergei
