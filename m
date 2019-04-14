Return-Path: <SRS0=Gg09=SQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30DC10F13
	for <linux-mips@archiver.kernel.org>; Sun, 14 Apr 2019 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAAF2084D
	for <linux-mips@archiver.kernel.org>; Sun, 14 Apr 2019 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fltrupee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDNUQP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:16:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36093 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDNUQP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 14 Apr 2019 16:16:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so19096969wrd.3
        for <linux-mips@vger.kernel.org>; Sun, 14 Apr 2019 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCAZ6Av6mNyTtjsExYvyRVW2UsXA9NqvqJ5nSAVHBrY=;
        b=fltrupeefy03xS5oLnvS45vloUG0hgj/LNN4Hzyf+xSEDtZwyHlzNmBDKgG/KQxDaB
         Wcb1/Ef+cufS+ptXpzrdPLIv1bNLXNEcHFdW8e/OtESdfxlkB0HczbuYyEPgJgVt14lx
         +4UM64oVKrOUdmB70qWa3vGv8lvf6uhD8ad1TyiURloyyKazvkyxf4ANLWR1zYrWxSJW
         Eb+hKIFY+gKprNpSzmB/RpC4T+koX2HWWPqFmKSZp/BG1VExmABd2L3ZqX7wBVye93rY
         U8mlEHmXzq6j5SDynuaYB5XbBoH0V81apQDnlLlbqnV5GAWqWqzAT/e5OMx+Ga7AET4i
         rfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nCAZ6Av6mNyTtjsExYvyRVW2UsXA9NqvqJ5nSAVHBrY=;
        b=FWpTBoGm//fBJjy95eH7XOS6KnEohN3Td6jrg34L6laks/lgiQaq2Gd2k/wNy3lXfY
         NbsBdssd1qHMErVkIBd2WCebdMJOuXpVkIAH3F9lUQuG3CaHkM9wE1B3KD6ArjqHSgvl
         q3mPZaOvJ4f8CrZN0LG20fmL7xHVF+aSLbNDrn/p2DB8EhrdatJti7d3NcFtF38uYbbM
         cL50HfT1FXDiYBptImorWqjy+PbkNqeCGbH965QqGoptYaXdibxWmBjM+kdMULlGY5+s
         dFU0TZ+HYYF0bzVeIzFVmo+v1dafsXEW99tKc4a+wBm9PAYyZXGLtyRihGb0ZTGgtzEC
         XRsA==
X-Gm-Message-State: APjAAAUA2MKivrki1beUXbbY12CnTrQJkkH4sZUrrEQl1OG5OoTkDd8x
        nJMynkoMBwxyhhPp1eCAOSEtBkFn
X-Google-Smtp-Source: APXvYqxA2JCiAv74TnA60U2XL521ttRowxbBpBfBcfxLzK+a84GNhAJWttUbB+wQ70SQ+fw4Ev/eEg==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr20620706wro.20.1555272973665;
        Sun, 14 Apr 2019 13:16:13 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net. [88.21.103.193])
        by smtp.gmail.com with ESMTPSA id 7sm163436768wrc.81.2019.04.14.13.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:16:12 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix access_ok() for the last byte of user space
To:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     Paul Burton <pburton@wavecomp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190209194718.1294-1-paul.burton@mips.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <63900602-56d5-72b7-fdcb-4558d1007401@amsat.org>
Date:   Sun, 14 Apr 2019 22:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190209194718.1294-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 2/9/19 8:47 PM, Paul Burton wrote:
> The MIPS implementation of access_ok() incorrectly reports that access
> to the final byte of user memory is not OK, much as the alpha & SH
> versions did prior to commit 94bd8a05cd4d ("Fix 'acccess_ok()' on alpha
> and SH").
> 
> For example on a MIPS64 system with __UA_LIMIT == 0xffff000000000000 we
> incorrectly fail in the following cases:
> 
>   access_ok(0xffffffffffff, 0x1) = 0
>   access_ok(0xfffffffffffe, 0x2) = 0
> 
> Fix MIPS in the same way as alpha & SH, by subtracting one from the addr
> + size condition when size is non-zero. With this the access_ok() calls
> above return 1 indicating that the access may be valid.
> 
> The cost of the improved check is pretty minimal - we gain 2410 bytes,
> or 0.03%, in kernel code size for a 64r6el_defconfig kernel built using
> GCC 8.1.0.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
>  arch/mips/include/asm/uaccess.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index d43c1dc6ef15..774c0f955ab0 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -128,7 +128,9 @@ static inline bool eva_kernel_access(void)
>  static inline int __access_ok(const void __user *p, unsigned long size)
>  {
>  	unsigned long addr = (unsigned long)p;
> -	return (get_fs().seg & (addr | (addr + size) | __ua_size(size))) == 0;
> +	unsigned long end = addr + size - !!size;
> +
> +	return (get_fs().seg & (addr | end | __ua_size(size))) == 0;
>  }
>  
>  #define access_ok(addr, size)					\
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
