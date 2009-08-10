Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 09:39:55 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:41843 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492376AbZHJHjt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 09:39:49 +0200
Received: by ewy12 with SMTP id 12so3404110ewy.0
        for <multiple recipients>; Mon, 10 Aug 2009 00:39:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZRhA308PCEXlzSRLd2Is1eX+eZas0IA7Yh2145x0/QE=;
        b=h0RlkxXX4pzE/+aeNFckQLB+W/wqu2fZ/sOOnA+J+d8xqwTxfkXbjtL5n+QbY9XcJa
         V6ek4qmCN//WD0cuKm4J78c0F5GZoVPxOXv6kq/hmA1G+mjQYMBPzq7B2XYb89UVHoF+
         p2sPsOHHIPwySNTHj+vwcri8MzAo8qaPMoAvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=weJE8uOw/Wh9TJfLfnJ0BQS0UKMY+NKg4C2iclJzHicZpFL9QlWdXRSnMSJK9jX0nn
         GAxCYxIscd1hjqClZnrDwByneSqEWgBvm7Co0534+4iWgd+XSQmvXNgOkk+1MLNOUchX
         QkZvlmHQ8YKs1pqYFuJjElbYfREmkYedmcTDk=
Received: by 10.210.131.6 with SMTP id e6mr4805219ebd.63.1249889983984;
        Mon, 10 Aug 2009 00:39:43 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm10445602eyh.16.2009.08.10.00.39.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 00:39:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] MIPS: AR7: fix wrong including path of rt7.h in ar7_wdt.c
Date:	Mon, 10 Aug 2009 09:39:39 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Nicolas Thill <nico@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>
References: <1249888074-20784-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1249888074-20784-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908100939.40963.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Wu,

Le Monday 10 August 2009 09:07:54 Wu Zhangjin, vous avez écrit :
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, but that was sent a while ago to Wim Van Sebroeck who is the watchdog 
subsystem maintainer.

> ---
>  drivers/watchdog/ar7_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
> index 3fe9742..ec48e12 100644
> --- a/drivers/watchdog/ar7_wdt.c
> +++ b/drivers/watchdog/ar7_wdt.c
> @@ -37,7 +37,7 @@
>  #include <linux/uaccess.h>
>
>  #include <asm/addrspace.h>
> -#include <asm/ar7/ar7.h>
> +#include <ar7.h>
>
>  #define DRVNAME "ar7_wdt"
>  #define LONGNAME "TI AR7 Watchdog Timer"



-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
