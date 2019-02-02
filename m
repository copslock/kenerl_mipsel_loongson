Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB954C282DB
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A47A20869
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g4gGfHJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfBBR2O (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:28:14 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:25275 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBR2O (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 2 Feb 2019 12:28:14 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 12:28:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549128491;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rehcv0vygKeLFmcL2i9Y89DgKx6ZIYyYldtPdL8iBYk=;
        b=g4gGfHJbSmGdbqdcgAifY7Gfb/Irj+LmGG3TCFan0Eiak3OyXF7Rt44yyptm7Ruqg0
        vcie3PSobcgRXb56u6E73lZDGOkmlXdaOqVnNhuX/UGwn2HvUV7oI3KbRyRzuJ+lHLQG
        d1KfmPXHR2accCCc84dYkoQZRJwXeX1RS+nzgz5EYHEdxGKWcr4m7pWv6nU4dAS4K/Nz
        K9DxpQDuhEE/JXd8pbpAD2apZxG5WiXtZ5krmR51Kev8HmJpVgHp0VV5WXZppDqpdYHg
        TGgbwD4a3f5Kw5A9Dx2+doeEFt0hxDfeyy0KAIw4F4bbGiHBtPdNPqFg2tAnjDYQzqug
        o1ZQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T3lT8iOWw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id j01e49v12HFkpna
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 2 Feb 2019 18:15:46 +0100 (CET)
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
Date:   Sat, 2 Feb 2019 18:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202153454.7121-13-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

On 02.02.19 16:34, Deepa Dinamani wrote:
> Add new socket timeout options that are y2038 safe.
(..)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 9826d1db71d0..0d0fddb7e738 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -119,19 +119,25 @@
>   #define SO_TIMESTAMPNS_NEW      64
>   #define SO_TIMESTAMPING_NEW     65
>   
> -#if !defined(__KERNEL__)
> +#define SO_RCVTIMEO_NEW         66
> +#define SO_SNDTIMEO_NEW         67
>   
> -#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> -#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
> +#if !defined(__KERNEL__)
>   
>   #if __BITS_PER_LONG == 64
>   #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
>   #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
>   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> +
> +#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
> +#define SO_SNDTIMEO		SO_SNDTIMEO_OLD

Maybe I'm a bit late in this discussion as you are already in v5 ...

I can see patches making the transition in different steps where it 
might be helpful to name them *_OLD and *_NEW to understand the patches.

But in the end the naming stays in the kernel for a very long time and I 
remember myself (in early years) to name things 'new', 'new2', 'new3'.

In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and 
SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Especially as it tells you what is 'inside', the naming of these new 
introduced constants should be replaced with *32 and *64 names.

The documentation and the other comments still fit perfectly then.

Regards,
Oliver

