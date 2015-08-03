Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 17:33:46 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:33928 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012101AbbHCPdop0lz4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 17:33:44 +0200
Received: by labow3 with SMTP id ow3so19408972lab.1
        for <linux-mips@linux-mips.org>; Mon, 03 Aug 2015 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bLc08vjL51kWYa1c41LsQ7bkd9JTlYCsigIY5Jnj5/Q=;
        b=moF6dzL4ZBBK0Ko688zWI5gvrzHx/kvP39FQmCcWUEyfGg9vyNonJ4OeUkDPOOLwfz
         mJjjPFIXlTLVyI8UD/mJqOjAI648+vG93KTCqxxV8UXmreJ/aBoDu8GPkBMTLcVtHQq0
         jG/IChFwivrJ3wFoHjh7+0ZH3Px+ImQ0V4wlMDxPLp5GeLYcK6zxUoBFqwuoDQqYKt2/
         whIMles/KVGwIL9tF0UjHIu2GcfH9l7tYgPIAJpd90XneNuGmqFp3yi7iQ/IKSR1b/j5
         vLysrfhvcUJt3ys7yZ/4OSZDbE630VNbv+gEjTgUItQERYragFI8sLVJ8fvNYwR8Jqd9
         WtiQ==
X-Gm-Message-State: ALoCoQk55z6uvYAhmn/IpKFAlli/jMT7Fi6VLu8/lQC/JpmpQJ40yODO7aH+blhFLEPjTKPCDbRe
X-Received: by 10.152.3.199 with SMTP id e7mr17087299lae.98.1438616018148;
        Mon, 03 Aug 2015 08:33:38 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp20-117.pppoe.mtu-net.ru. [81.195.20.117])
        by smtp.gmail.com with ESMTPSA id ei1sm358898lad.24.2015.08.03.08.33.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 08:33:37 -0700 (PDT)
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
To:     Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Markos Chandras <markos.chandras@imgtec.com>
References: <20150803150401.GD2843@linux-mips.org>
Cc:     linux-leds@vger.kernel.org, linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <55BF89D0.2080303@cogentembedded.com>
Date:   Mon, 3 Aug 2015 18:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150803150401.GD2843@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello.

On 08/03/2015 06:04 PM, Ralf Baechle wrote:

> Fixes the following randconfig problem

> leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mips@linux-mips.org

[...]

> diff --git a/arch/mips/mti-sead3/leds-sead3.c b/drivers/leds/leds-sead3.c
> similarity index 99%
> rename from arch/mips/mti-sead3/leds-sead3.c
> rename to drivers/leds/leds-sead3.c
> index c938cee..eb97a32 100644
> --- a/arch/mips/mti-sead3/leds-sead3.c
> +++ b/drivers/leds/leds-sead3.c

     Oh, so you started to use -M finally. :-)

> @@ -59,6 +59,7 @@ static int sead3_led_remove(struct platform_device *pdev)
>   {
>   	led_classdev_unregister(&sead3_pled);
>   	led_classdev_unregister(&sead3_fled);
> +

    Unrelated white space change?

>   	return 0;
>   }

MBR, Sergei
