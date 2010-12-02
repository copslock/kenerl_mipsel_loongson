Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 13:03:21 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:54632 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493203Ab0LBMDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Dec 2010 13:03:19 +0100
Received: by eyd9 with SMTP id 9so4156988eyd.36
        for <linux-mips@linux-mips.org>; Thu, 02 Dec 2010 04:03:18 -0800 (PST)
Received: by 10.213.32.9 with SMTP id a9mr2508593ebd.60.1291291398526;
        Thu, 02 Dec 2010 04:03:18 -0800 (PST)
Received: from [192.168.2.2] ([91.79.87.12])
        by mx.google.com with ESMTPS id v56sm414729eeh.2.2010.12.02.04.03.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 04:03:17 -0800 (PST)
Message-ID: <4CF78A96.8000109@mvista.com>
Date:   Thu, 02 Dec 2010 15:01:26 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Arnaud Lacombe <lacombar@gmail.com>
CC:     John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-mips@linux-mips.org, wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: Build failure triggered by recordmcount
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>        <4CEB37F8.1050504@bitwagon.com> <AANLkTikUZ=kQbWEtSNpw27pBPX-cSs2J+NaLODHG6T7O@mail.gmail.com>
In-Reply-To: <AANLkTikUZ=kQbWEtSNpw27pBPX-cSs2J+NaLODHG6T7O@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

On 02.12.2010 7:54, Arnaud Lacombe wrote:

>> It looks to me like the change which introduced "virtual functions"
>> forgot about cross-platform endianness.  Can anyone please test this patch?
>> Thank you to Arnaud for supplying before+after data files do_mounts*.o.


>> recordmcount: Honor endianness in fn_ELF_R_INFO

>> ---
>>   scripts/recordmcount.h |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)

>> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
>> index 58e933a..3966717 100644
>> --- a/scripts/recordmcount.h
>> +++ b/scripts/recordmcount.h
>> @@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
>>   static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
>>   {
>> -       rp->r_info = ELF_R_INFO(sym, type);
>> +       rp->r_info = _w(ELF_R_INFO(sym, type));
>>   }
>>   static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
>>   -- 1.7.3.2

> This patch does not seems to have made its way up to Linus tree, has
> it been picked by anyone ?

    It was not signed off, so couldn't be applied.

> Thanks,
>   - Arnaud

WBR, Sergei
