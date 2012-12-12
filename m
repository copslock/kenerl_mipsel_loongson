Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 18:05:28 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:33041 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823128Ab2LLRF0wcno1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 18:05:26 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so510621bkc.36
        for <linux-mips@linux-mips.org>; Wed, 12 Dec 2012 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hF//RoxMDe9Bi4Ock0FHe2sWkSIdkQMHSJJbGxnsm30=;
        b=rkbTcAqFelQyewGTgFZ077NWM9PDiYY3QTvPUdPwE2pabIef+JT/ehI9WoJARfep3G
         jbm4oHd9nk7gBJ1sePFQQofp2M4Gy4Sw8Eyy5UXRa0gtN/MuoX6EJ/JTjkhf3GK7ItjV
         yrBOYjwD7kQz5nthzW4CNsL1ee2W94bcYY1gtU3Xi6V4P95KAniML5zh/PPNsssZ4p2D
         G3ZGDXi+6K1gqmWXs9qXnB5IGmPGOJc5ID5z/SV76r4l0Lb+D+XAAzvqEDKK7YBDAflT
         850UJik4ToOhLrsX8M/gF9M515qWI+jlMbYYHGMuJWVmbWKQL4JGLZiuomgzGupfKm75
         mNgA==
Received: by 10.204.8.136 with SMTP id h8mr876497bkh.62.1355331921406;
        Wed, 12 Dec 2012 09:05:21 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id o9sm21070412bko.15.2012.12.12.09.05.20
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 09:05:20 -0800 (PST)
Message-ID: <50C8B8D4.6070305@openwrt.org>
Date:   Wed, 12 Dec 2012 18:03:16 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>,<50C89870.5000704@metafoo.de> <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Le 12/12/12 17:44, Hill, Steven a écrit :
> Lars,
>
> This patch was requested by our DSP/Codec group to help with selecting the best user-space codecs at runtime. Simply reading /proc/cpuinfo was insufficient. I posted this patch more for feedback and interest with minimal expectations that it would make it upstream. This patch will always be in our supported branches, but I will defer to everyone else on its worth for upstream.

How do they actually make their choices? Is it just about advertising 
dsp vs. dspr2 to user-space?

Have you looked into modifying the ELF platform via set_elf_platform() 
to help these binaries with identify the underlying platform/kernel?
--
Florian
