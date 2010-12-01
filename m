Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 16:54:35 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:62734 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493013Ab0LAPyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 16:54:31 +0100
Received: by yxm34 with SMTP id 34so3760750yxm.36
        for <multiple recipients>; Wed, 01 Dec 2010 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=rb32R6kPzmkl7XoC233HzMmkJvuDgUwfVOJ9g3ASc+c=;
        b=cfpoJwbpXfwoLkgDf174Keqf7s6cSzPwB7aOXVyHXhAhdj+AFn1BkkKrbcro2TqEZt
         9FXoMQR8OyqhAfBADy2MzPKvy8tYbu8S6EZwPgAgStnRK+t2nzSWYksZFnhAR004nQaP
         SNnwTazI+4Zn/h5Do88s2ygw3XrD57T4Xnwbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=dH+LlP3GKlSSVZwuNV1+gjH7HclQM2YRVBwZZz9Q8CxaANG8hPcRGJm4XZ9Dso6nbG
         Dm9bzHi9nizY4hsddl0yPfEYjsdj+pklc8sfIBGdKkUMjey9n+bq9Z8GjaIJoGgcdGYi
         7yEMy5dpMX4CAsqPlYNqcQjgFthStN5Dc/jWQ=
Received: by 10.91.67.10 with SMTP id u10mr183945agk.187.1291218863612;
        Wed, 01 Dec 2010 07:54:23 -0800 (PST)
Received: from [192.168.10.102] ([211.201.183.198])
        by mx.google.com with ESMTPS id 31sm67747yhl.30.2010.12.01.07.54.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 07:54:22 -0800 (PST)
Subject: Re: [PATCH RESEND] MIPS: Define dummy MAX_DMA_CHANNELS to fix
 build failure
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <1289918840-13434-1-git-send-email-namhyung@gmail.com>
References: <1289918840-13434-1-git-send-email-namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 02 Dec 2010 00:54:13 +0900
Message-ID: <1291218853.1684.35.camel@leonhard>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 8bit
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

2010-11-16 (화), 23:47 +0900, Namhyung Kim:
> allmodconfig build failes like following:
> 
>   CC [M]  sound/oss/soundcard.o
> sound/oss/soundcard.c:68: error: 'MAX_DMA_CHANNELS' undeclared here (not in a function)
> make[3]: *** [sound/oss/soundcard.o] Error 1
> make[2]: *** [sound/oss] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
>  arch/mips/include/asm/dma.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
> index 2d47da6..c601cff 100644
> --- a/arch/mips/include/asm/dma.h
> +++ b/arch/mips/include/asm/dma.h
> @@ -74,7 +74,9 @@
>   *
>   */
>  
> -#ifndef CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN
> +#ifdef CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN
> +#define MAX_DMA_CHANNELS	0
> +#else
>  #define MAX_DMA_CHANNELS	8
>  #endif
>  

Ping. Any comments?


-- 
Regards,
Namhyung Kim
