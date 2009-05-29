Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 20:52:06 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:41443 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024767AbZE2Tv7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 20:51:59 +0100
Received: by wa-out-1112.google.com with SMTP id n4so1041265wag.0
        for <linux-mips@linux-mips.org>; Fri, 29 May 2009 12:51:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=l42B9LqjlZJBkh6qQlG83RSpnuyE1mPt85NnEFxkNBg=;
        b=hP3jv5rPslNvHRiF0i6nqtSlVcqsU9HE1rB7kk2HeYpOzHHFbExlqc315KWmU3uiZ3
         tw5hFxTQqK5J9ItDAG+YKkF09TQ2SmnWbjw87VkY3wSGnVT/ZmpQN2+U0gguTyFYZNVW
         tuud24BMKhh4FqpW6nwlLz9hjoeInfQToSpHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=anGpooyAyBJ1MrOyL3f6YmmIxAuDHggHTrCnPDmNF+iQzp8mujO9QHW5045tC13K66
         xyCtVEI1cubFLOaxsmbbtwQUCLPccccx04/zii7FVVQsE5oTTqglaSKg/3Q9rZLmjx3A
         G8zVurIYPLSjEHOqNeQkf+5yx9p2GePot0pQE=
Received: by 10.115.92.8 with SMTP id u8mr4578923wal.152.1243626717594;
        Fri, 29 May 2009 12:51:57 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id m17sm2696847waf.68.2009.05.29.12.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 12:51:56 -0700 (PDT)
Subject: Re: [loongson-PATCH-v1 16/27] Add Siliconmotion 712 framebuffer
 driver
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Simon Braunschmidt <sb@emlix.com>, boyod.yang@siliconmotion.com.cn,
	gewang@siliconmotion.com
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <4A1FE338.5010802@emlix.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <ad533255eec0400e4fed72671c0865472dd68d02.1242855716.git.wuzhangjin@gmail.com>
	 <4A1FE338.5010802@emlix.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 30 May 2009 03:51:50 +0800
Message-Id: <1243626710.18071.78.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, 

On Fri, 2009-05-29 at 15:29 +0200, Simon Braunschmidt wrote:
> Hi Wu Zhangjin
> 
> I applied your patch cleanly and run it on a i486SX (little endian) 
> embedded computing board.

thanks very much for testing it in a non-mips platform!

> This provides a huge performance benefit compared to vesa framebuffer, 
> so thanks a lot for the contribution.
> 

the thanks should goes to the original authors from Silicon Motion
Technology Corp. including Ge Wang and Boyod.Yang. I just cleaned it up.

> I tested it in both the library-accelerated (cfb...) and hardware 
> accelerated codepaths, with no problems. Tested with qt-embedded 4.5.1.
> 
> As i have seen lots of functionality are guarded by
> #ifdef __BIG_ENDIAN
> 
> Is there a way to setup a different mode than 1024x600 on 
> kernel-commandline or from userspace, e.g. with fbset?
> 

seems we can change it in userspace, i have changed it to 800X480 in a
7inch yeeloong2f laptop in the "control center" of KDE desktop.

or perhaps you can configure it in the Xorg.conf directly.

> What I currently do is
> picking appropriate values form the table VGAMode in smtcfb.h and 
> hardcoding them.
> 
> I tried 800x600x16bit@60hz, which worked also, but 1024x768x24bit@60hz 
> left me with a corrupted display output (distored colors, missing 
> regions), i did not check further wheter it also crashed.
> 

I will try to check it, but in reality, I'm not familiar with it, so
maybe very hard and slow to check it. I will forward this E-mail to the
original authors, hope they can give some help.

> I dont know wheter i am subscribed and this will make it through to lkml 
> and linux-mips, feel free to cite me if you want.
> 
> Also if you want you may add my
> 
> Tested-by: Simon Braunschmidt <sbraun@emlix.com>
> 

added.

> 
> see also attached a patch for the debug messages
> 
> 

Applied.

thanks!
Wu Zhangjin
> 
>  From addec9a5a27512621c538a2f799e31e07720cb9c Mon Sep 17 00:00:00 2001
> From: Simon Braunschmidt <sbraun@emlix.com>
> Date: Fri, 29 May 2009 15:03:51 +0200
> Subject: [PATCH] [video] fix debug messages in smtcfb
> 
> when defining #DEBUG
> ---
>   drivers/video/smi/smtcfb.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/smi/smtcfb.c b/drivers/video/smi/smtcfb.c
> index 33ce878..ebc6371 100644
> --- a/drivers/video/smi/smtcfb.c
> +++ b/drivers/video/smi/smtcfb.c
> @@ -44,6 +44,8 @@
>   #include "smtcfb.h"
>   #include "smtc2d.h"
> 
> +#define DEBUG
> +
>   #ifdef DEBUG
>   #define smdbg(format, arg...)  printk(KERN_DEBUG format , ## arg)
>   #else
> @@ -1087,7 +1089,7 @@ static int __init sm712be_setup(char *options)
>          sm712be_flag = 0;
>          if (!options || !*options) {
>                  retval = 1;
> -               smdbg("\n No sm712be parameter\n", __LINE__);
> +               smdbg("\n No sm712be parameter\n");
>          }
>          if (!retval && strstr(options, "enable"))
>                  sm712be_flag = 1;
> @@ -1113,7 +1115,7 @@ static int __init sm712vga_setup(char *options)
> 
>          if (!options || !*options) {
>                  retval = 1;
> -               smdbg("\n No vga parameter\n", __LINE__);
> +               smdbg("\n No vga parameter\n");
>          }
> 
>          screen_info.lfb_width = 0;
> --
> 1.6.3.rc0.1.gf800
> 
> 
> 
