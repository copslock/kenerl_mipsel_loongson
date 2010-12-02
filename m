Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 05:55:08 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:47014 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab0LBEzE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 05:55:04 +0100
Received: by gyg4 with SMTP id 4so4193140gyg.36
        for <linux-mips@linux-mips.org>; Wed, 01 Dec 2010 20:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jXbYlbYdsjXFf07Jw9rsPjbCldq3duzKx+Bb4p0gXAc=;
        b=SOPILWpo4GDnoD6Yk/Ak5MXsFdkvIPfOl1mTlVcDbjBoBc9b4GjT3rVT6ITNgpyQqR
         hB4mdSZ4EWTk4SzrT3CVkTmUhDOTpZIf9UoQSkUZL+q4FVDzwgjNV9ktFgokhUYtC1AA
         +0dCxVyC7hF9jfJpxrw6Co9qPVMVzNdg9Wd4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iIE8jv276gjg4rqdrXDOjjNGXYgK72FcGdneiX8LUQLmHuCytwsi0KGz2iFhp85IR8
         Ppr38k1Lwthd/qy5ZfrnAtBNP9VYPksAd3iY9AYcsJVmgbyk6AHjM9ROJfdI+9smPJpt
         W6pqrsRXEj6wyMJWz+W4y3wxLYqi00X9E5JXw=
MIME-Version: 1.0
Received: by 10.42.169.2 with SMTP id z2mr2810725icy.296.1291265698270; Wed,
 01 Dec 2010 20:54:58 -0800 (PST)
Received: by 10.42.176.10 with HTTP; Wed, 1 Dec 2010 20:54:58 -0800 (PST)
In-Reply-To: <4CEB37F8.1050504@bitwagon.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
        <4CEB37F8.1050504@bitwagon.com>
Date:   Wed, 1 Dec 2010 23:54:58 -0500
Message-ID: <AANLkTikUZ=kQbWEtSNpw27pBPX-cSs2J+NaLODHG6T7O@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     John Reiser <jreiser@bitwagon.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Folks,

On Mon, Nov 22, 2010 at 10:41 PM, John Reiser <jreiser@bitwagon.com> wrote:
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
This patch does not seems to have made its way up to Linus tree, has
it been picked by anyone ?

Thanks,
 - Arnaud
