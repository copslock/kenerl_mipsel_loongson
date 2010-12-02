Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 15:38:49 +0100 (CET)
Received: from bitwagon.com ([74.82.39.175]:45462 "HELO bitwagon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1493234Ab0LBOim (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 15:38:42 +0100
Received: from f11-64.local ([67.171.188.169]) by bitwagon.com for <linux-mips@linux-mips.org>; Thu, 2 Dec 2010 06:38:31 -0800
Message-ID: <4CF7AF4D.1060207@bitwagon.com>
Date:   Thu, 02 Dec 2010 06:38:05 -0800
From:   John Reiser <jreiser@bitwagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Arnaud Lacombe <lacombar@gmail.com>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: Build failure triggered by recordmcount
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>        <4CEB37F8.1050504@bitwagon.com> <AANLkTikUZ=kQbWEtSNpw27pBPX-cSs2J+NaLODHG6T7O@mail.gmail.com> <4CF78A96.8000109@mvista.com>
In-Reply-To: <4CF78A96.8000109@mvista.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jreiser@bitwagon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jreiser@bitwagon.com
Precedence: bulk
X-list: linux-mips

On 12/02/2010 04:01 AM, Sergei Shtylyov wrote:
> On 02.12.2010 7:54, Arnaud Lacombe wrote:
> 
>>> It looks to me like the change which introduced "virtual functions"
>>> forgot about cross-platform endianness.  Can anyone please test this
>>> patch?
>>> Thank you to Arnaud for supplying before+after data files do_mounts*.o.
> 
> 
>>> recordmcount: Honor endianness in fn_ELF_R_INFO
> 
>>> ---
>>>   scripts/recordmcount.h |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
>>> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
>>> index 58e933a..3966717 100644
>>> --- a/scripts/recordmcount.h
>>> +++ b/scripts/recordmcount.h
>>> @@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) =
>>> fn_ELF_R_SYM;
>>>   static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned
>>> type)
>>>   {
>>> -       rp->r_info = ELF_R_INFO(sym, type);
>>> +       rp->r_info = _w(ELF_R_INFO(sym, type));
>>>   }
>>>   static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned
>>> type) = fn_ELF_R_INFO;
>>>   -- 1.7.3.2
> 
>> This patch does not seems to have made its way up to Linus tree, has
>> it been picked by anyone ?
> 
>    It was not signed off, so couldn't be applied.
> 

Signed-off-by: John Reiser <jreiser@BitWagon.com>

-- 
