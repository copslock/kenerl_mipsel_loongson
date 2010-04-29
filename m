Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 13:56:50 +0200 (CEST)
Received: from mail-yw0-f187.google.com ([209.85.211.187]:52715 "EHLO
        mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492653Ab0D2L4q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 13:56:46 +0200
Received: by ywh17 with SMTP id 17so642608ywh.22
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=cRjlfHseE4Krv82WBHLCnjw+qPRoBHJ3axjpqRwV2bY=;
        b=PpyqDbnVyC6QB3kHnnjhLn2uXJ1gF1XZDuwqcmWgHeSRxsDyHUnC9O96KnGcg/2dgp
         6dPrQxLyTM3P1JrTR++iuDz6Qb1QoMeP/0/gU5QY2Mf2IreStbO95wpeuTeMWnrhP3TI
         I+ZmMh+5X3ehZ9Qhes+m9/0n60z5LRoxIaHOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=a51tN13gzAbbS1FRU09sWB4L2IXpaHVcL+gNFgSEbSHxPt96QnzFbmrn1VOnnxBsQ1
         lB1PHDb2poSe5apVwGUUdJuDXwLLaABZp+avlTJehsuHcxn99q8gE8JloCFS/5kf/Szh
         Ifss4kByfhn72bWoYI7o5NSNH6/HccpA8dsRE=
Received: by 10.101.202.17 with SMTP id e17mr4259768anq.175.1272542196300;
        Thu, 29 Apr 2010 04:56:36 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm738821iwn.12.2010.04.29.04.56.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Apr 2010 04:56:34 -0700 (PDT)
Subject: Re: [PATCH] arch/mips/loongson/common/machtype.c: Fix typo
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <m3y6g6wpex.fsf@anduin.mandriva.com>
References: <m3y6g6wpex.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 29 Apr 2010 19:56:29 +0800
Message-ID: <1272542189.30655.131.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-04-29 at 11:58 +0200, Arnaud Patard wrote:
> The gdium name string contains an obvious typo. It's not "gidum" but
> "gdium".
> 

Thanks, will apply this patch and the others into the rt4ls[1] and
linux-loongson-community[2] repositories.

Regards,
	Wu Zhangjin

[1] http://dev.lemote.com/code/rt4ls
[2] http://dev.lemote.com/code/linux-loongson-community

> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> ---
> differences between files attachment (gdium_fix_name.patch)
> Index: linux-2.6/arch/mips/loongson/common/machtype.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/loongson/common/machtype.c
> +++ linux-2.6/arch/mips/loongson/common/machtype.c
> @@ -24,7 +24,7 @@ static const char *system_types[] = {
>  	[MACH_LEMOTE_FL2F]              "lemote-fuloong-2f-box",
>  	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
>  	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
> -	[MACH_DEXXON_GDIUM2F10]         "dexxon-gidum-2f-10inches",
> +	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
>  	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
>  	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
>  	[MACH_LOONGSON_END]             NULL,
