Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 05:56:20 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43193 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491064Ab0KWE4R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 05:56:17 +0100
Received: by wyf22 with SMTP id 22so8026746wyf.36
        for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 20:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FtHr4avgQlvEjwV6TUvb9s/69vjFRdAw0yCRzKo99GE=;
        b=R4eGOd+Rb0HAdtiv/MSlIHfv1wVg67hrn7ciotpHua8j4tHSh2q1BikdZpoocxhwnY
         yeHNNiJtz/KBQs0s78aFgU+wA5wKLJXkqbl0UoXgxG+R8xJIxOy1HZe8h7xtZCWdDQ3K
         4+EAfgSyC8oHCPvD+o3ndLSbUrrVgFAq9H/Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BsXd6SNUPOsimpcCjpj5DPRlAMw9ZVrHKrTZbXWIZ4ogJGKAT22Rxdc8P/kprS/MLy
         iellVIgtdVvRP4KD5sOj19E1+gYT5xJIY8Xo7oLlVbPBBncdh60JAaUvEnpF27ZntKRV
         MQlTFp7LZGYyAIcSaST8u5BBNcMTvSmiPbXqg=
MIME-Version: 1.0
Received: by 10.216.142.131 with SMTP id i3mr495752wej.5.1290488171743; Mon,
 22 Nov 2010 20:56:11 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Mon, 22 Nov 2010 20:56:11 -0800 (PST)
In-Reply-To: <4CEB37F8.1050504@bitwagon.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
        <4CEB37F8.1050504@bitwagon.com>
Date:   Tue, 23 Nov 2010 12:56:11 +0800
Message-ID: <AANLkTi=dWNVzNOFBex+oQ0OnC1okEc+LQgmYxx6J_KEW@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     John Reiser <jreiser@bitwagon.com>
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This does solve the problem, now we get the right result:

$ readelf -a init/do_mounts.o

Relocation section '.rel__mcount_loc' at offset 0x2f60 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000202 R_MIPS_32         00000000   .text
00000004  00000202 R_MIPS_32         00000000   .text


On Tue, Nov 23, 2010 at 11:41 AM, John Reiser <jreiser@bitwagon.com> wrote:
> It looks to me like the change which introduced "virtual functions"
> forgot about cross-platform endianness.  Can anyone please test this patch?
> Thank you to Arnaud for supplying before+after data files do_mounts*.o.
>
>
> recordmcount: Honor endianness in fn_ELF_R_INFO
>
> ---
>  scripts/recordmcount.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index 58e933a..3966717 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
>  static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
>  {
> -       rp->r_info = ELF_R_INFO(sym, type);
> +       rp->r_info = _w(ELF_R_INFO(sym, type));
>  }
>  static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
>  -- 1.7.3.2
>
>
> --
>
