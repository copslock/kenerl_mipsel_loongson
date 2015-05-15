Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 22:17:07 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36219 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012645AbbEOURGGIPqI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 22:17:06 +0200
Received: by igbpi8 with SMTP id pi8so4563720igb.1;
        Fri, 15 May 2015 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h+4Ae+7BlVwE6WVv/Q5yaAmCOIsxa+4HzRyQx1EOufs=;
        b=I29R0RMSU6Qgh1UMmxWYGxDvakcOj7McuwjSnsnoR+mtyaiiG5mbBYIzu1937txbs+
         fBLw7qNdZ2Ly8XoZB/qHY5a5Be7l3aCIaQ6323IgoLxMN5Z0U/RorEWwu5V/cLafNia2
         HVAacYxgXSZ+qSapvurTosV8UhMH9+CbxeX2reAHjrMutHmJu8/8ScS8W9rVdLjEvGEM
         IYB/fBlBdU4H7Hc897nUv2QdPrYzvnydnrJMCrcflJqghzxBpYsbSsRiXoH9tBOS77Kh
         qQ9zHJa+Q1hhcrbJjku7pYwcnAJpwRq1U4BRX9uGF5T9VyK5XuAJ2X4hEvYga3OPrLiY
         A6rA==
X-Received: by 10.50.178.230 with SMTP id db6mr511642igc.26.1431721022621;
        Fri, 15 May 2015 13:17:02 -0700 (PDT)
Received: from [192.168.0.11] (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id j3sm2121215igx.21.2015.05.15.13.17.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 13:17:01 -0700 (PDT)
Message-ID: <5556543B.1010406@gmail.com>
Date:   Fri, 15 May 2015 16:16:59 -0400
From:   nick <xerofoify@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     akpm@linux-foundation.org, kumba@gentoo.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mips:Fix build error for ip32_defconfig configuration
References: <1431613217-2517-1-git-send-email-xerofoify@gmail.com> <20150515201044.GG2322@linux-mips.org>
In-Reply-To: <20150515201044.GG2322@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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



On 2015-05-15 04:10 PM, Ralf Baechle wrote:
> On Thu, May 14, 2015 at 10:20:17AM -0400, Nicholas Krause wrote:
> 
>> This fixes the make error when building the ip32_defconfig
>> configuration due to using sgio2_cmos_devinit rather then
>> the correct function,sgio2_rtc_devinit in a device_initcall
>> below this function's definition.
> 
> I've already applied Joshua Kinard's 
> https://patchwork.linux-mips.org/patch/9787/ with a minor cosmetic
> touchup.
> 
>   Ralf
> 
Ralf,
As you may already known my rep with the other kernel developers is pretty bad.
Based off this work can you try(time permitting) to put it a good word that I am
improving.
Thanks Nick
