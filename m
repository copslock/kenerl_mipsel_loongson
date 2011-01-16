Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2011 16:08:36 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56834 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493212Ab1APPId convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jan 2011 16:08:33 +0100
Received: by fxm19 with SMTP id 19so4865783fxm.36
        for <linux-mips@linux-mips.org>; Sun, 16 Jan 2011 07:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rxknwRIoTpx2m5JRZ8/fJfDmOzM1y5TylLEPP3Ux9Gw=;
        b=F91xGU2h8PQvFDdEs9sB/JF2tsUOS8n+dszuy3mIhBeFMUKBVjXzAeqLlHDW7WPix2
         Od2A0GE2q08fKuD3DoCyiTTtm91RNmkWcXXIIyxdHJj1MV9qvch8s4zAGUTKTdMvn6Hb
         ffP56ZKbgeyRG6rkK8oXp3yH7VuMzbebevXWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=X+VkY99kvlS805JvrKhO2R9pikQGWSilRVoa7Jd9vUTWQIAjp0sSzyTFmoNi0rnhSl
         28YAdQrHFq5Cn0g4zqbLnOBntmzdQZl39WArLDgip8yYwnhmYH5TrKo6gD4bAiOkqsAk
         4FG2pQCVHV7fxekBRblggQ2fDtsmDVG9FX8cs=
MIME-Version: 1.0
Received: by 10.223.85.203 with SMTP id p11mr3475944fal.108.1295190507464;
 Sun, 16 Jan 2011 07:08:27 -0800 (PST)
Received: by 10.223.75.194 with HTTP; Sun, 16 Jan 2011 07:08:27 -0800 (PST)
In-Reply-To: <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
Date:   Sun, 16 Jan 2011 16:08:27 +0100
X-Google-Sender-Auth: _72t3gozxfiIT2CDcjmeIxpUBlo
Message-ID: <AANLkTimiWdCcoVChD=N01JSyQ9dgz2tg+C_9Vj=c6+Xc@mail.gmail.com>
Subject: Re: about udelay in mips
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 16, 2011 at 15:38, loody <miloody@gmail.com> wrote:
> hi wu, winfred:
> Thanks for your reply ;)
> 2011/1/14 wu zhangjin <wuzhangjin@gmail.com>:
>> On Thu, Jan 13, 2011 at 6:02 PM, loody <miloody@gmail.com> wrote:
>>> hi all:
>>> If i trace source in the correct place, I found udelay(100) is
>>> implemented as a loop which decrease 1 per iteration until the count,
>>> 100, as 0.
>>> What makes me confused is since the speed of cpus are different and
>>> that will make udelay not precise on different platform, right?
>>
>> Yeah, it may be not precise, so, some processors, like Cavium octeon
>> have added their own timestamp register based delay functions, please
>> refer to:
>>
>> arch/mips/cavium-octeon/csrc-octeon.c
>>
>> The delay_tsc() for X86 defined in arch/x86/lib/delay.c is similar.
>>
>> But both of them are 64bit timestamp registers.
>>
>> We can also apply similar method to add the precise delays for the
>> other CPUs, but we may need to take extra notice:
>>
>> 1. If the CPU only provides 32bit timestamp registers(e.g R4K MIPS),
>> overflow should be considered.
>> 2. If the CPU support dynamic CPU frequency and the frequency of the
>> timestamp binds to the CPU's frequency, the scaled down timestamp
>> should be converted to the real timestamp.
> below is the formula about calculating the delay
> (us  *   0x000010c7   *   HZ   *   lpj   )) >> 32)
> I cannot figure out why we need to multiply 0x10c7, and what lpj mean?
> Does lpj mean if jiffies increase 1, how many "subu    %0, 1" may need?

Yep, lpj = loops per jiffy.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
