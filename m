Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 18:09:40 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36929 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492090Ab0KWRJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 18:09:33 +0100
X-Authority-Analysis: v=1.1 cv=+c36koQ5Dcj/1qolKHjtkYAGXvrVJRRiKMp+84F5sLg= c=1 sm=0 a=ClBoAdZ3F6cA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=Dgq5Ti-FtMxgDvvqsXQA:9 a=DbpSK5KL0a4fbQDPLC0A:7 a=31ebPECljZMgOMw7qc9MWHxb7JgA:4 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:55548] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 59/A1-24070-545FBEC4; Tue, 23 Nov 2010 17:09:26 +0000
Subject: Re: Build failure triggered by recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Reiser <jreiser@bitwagon.com>
Cc:     Arnaud Lacombe <lacombar@gmail.com>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
In-Reply-To: <4CEB37F8.1050504@bitwagon.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
         <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
         <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
         <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
         <4CEB37F8.1050504@bitwagon.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 23 Nov 2010 12:09:25 -0500
Message-ID: <1290532165.30543.374.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2010-11-22 at 19:41 -0800, John Reiser wrote:
> It looks to me like the change which introduced "virtual functions"
> forgot about cross-platform endianness.  Can anyone please test this patch?
> Thank you to Arnaud for supplying before+after data files do_mounts*.o.
> 
> 
> recordmcount: Honor endianness in fn_ELF_R_INFO

Arnaud, can I get a "Tested-by" from you.

Wu, can you give me your Acked-by:

Thanks,

-- Steve

> 
> ---
>  scripts/recordmcount.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index 58e933a..3966717 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
>   static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
>  {
> -	rp->r_info = ELF_R_INFO(sym, type);
> +	rp->r_info = _w(ELF_R_INFO(sym, type));
>  }
>  static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
>  -- 1.7.3.2
> 
> 
