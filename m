Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 10:26:25 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43552 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491165Ab0KXJ0R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Nov 2010 10:26:17 +0100
Received: by wyf22 with SMTP id 22so489308wyf.36
        for <linux-mips@linux-mips.org>; Wed, 24 Nov 2010 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zc3zaNXM4hAdvjd/gvpCuZd07zoWdd1E5g76HUP5LbI=;
        b=F/9fWJaS2CJEuUfxgHDrImIF0lBVyGDeDKPDWmqun2pcABZoKOWbHw4n/fT/vd5WH6
         Ur+IvQAsPjJrFveA1fQMODb1lDDpES9LuuytXqHgq29JNX5FcxGVaQ4eV4XynzhTl8MY
         nX0ki6hlA06cgrOWkTpMHvAl+NG0w15g8N3NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YPD5ydUbBPHS0YyFHMHH2dohG+I2+dpva9+S3y48LxxNztrTAVpOO8nPGW7E1WhfTk
         FcoAo6mu/XCfhQjl+4mu47J32mfEz6T1LLGUIoCwD+GjY2/0Usiwc5wov8oTJXOkX/0H
         hsIkfFsET1i4AXZBshM9P0xLJCwkPjxDvRDFU=
MIME-Version: 1.0
Received: by 10.216.30.65 with SMTP id j43mr7836332wea.20.1290590771484; Wed,
 24 Nov 2010 01:26:11 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Wed, 24 Nov 2010 01:26:11 -0800 (PST)
In-Reply-To: <1290532165.30543.374.camel@gandalf.stny.rr.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
        <4CEB37F8.1050504@bitwagon.com>
        <1290532165.30543.374.camel@gandalf.stny.rr.com>
Date:   Wed, 24 Nov 2010 17:26:11 +0800
Message-ID: <AANLkTinkxprgKVMOpYbUkxe0xou8183SD1=_DOdsTF4M@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Reiser <jreiser@bitwagon.com>,
        Arnaud Lacombe <lacombar@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 24, 2010 at 1:09 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2010-11-22 at 19:41 -0800, John Reiser wrote:
>> It looks to me like the change which introduced "virtual functions"
>> forgot about cross-platform endianness.  Can anyone please test this patch?
>> Thank you to Arnaud for supplying before+after data files do_mounts*.o.
>>
>>
>> recordmcount: Honor endianness in fn_ELF_R_INFO
>
> Arnaud, can I get a "Tested-by" from you.
>
> Wu, can you give me your Acked-by:

Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks & Regards,
Wu Zhangjin

>
> Thanks,
>
> -- Steve
>
>>
>> ---
>>  scripts/recordmcount.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
>> index 58e933a..3966717 100644
>> --- a/scripts/recordmcount.h
>> +++ b/scripts/recordmcount.h
>> @@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
>>   static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
>>  {
>> -     rp->r_info = ELF_R_INFO(sym, type);
>> +     rp->r_info = _w(ELF_R_INFO(sym, type));
>>  }
>>  static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
>>  -- 1.7.3.2
>>
>>
>
>
>
