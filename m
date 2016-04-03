Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 20:39:25 +0200 (CEST)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34953 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007359AbcDCSjX5fgQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 20:39:23 +0200
Received: by mail-oi0-f41.google.com with SMTP id p188so140791704oih.2;
        Sun, 03 Apr 2016 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BoplsbIKuT4ppJL9u9LSbgX5GKG8SY2Xmmx/X7MwwgM=;
        b=rGTwTSD88t8zpP/Mxxbyq5cKul31YH0Zcme1dUXD0kxEVBimaGs4W+CjbcDfgVGxlQ
         vTUDAythyxrig4uqnWT4ZGjf3AwJYLYYfeFLm5Zg95N0kJKR1tDoLrGmBiTA7nZznpff
         U2iqasUDEuNANkIcCtGxU6dz+zooYP+1kTrMHmHldBDcxLictH2SJvccexQGFZGRKv90
         rUcFdetnS22eKmCv/Y7WZK/yioSOvBGj21dh0zlYpvli/p7sx9QoxuFsH7y8fVwL7vde
         Sd8YowoSib6HRI+XelZDGVHUItJUITNX4ZAniHjEKPuPluC+t/zb9UAKUkbapvyvqRTq
         wRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BoplsbIKuT4ppJL9u9LSbgX5GKG8SY2Xmmx/X7MwwgM=;
        b=ZOiFFFuh37rPIcMUQWwVVn1B6q8+3yiB2aot+LqXpPBk3pvafru6afH3zakchOAmOe
         ptZSk8tAxYpNmiydF5tkP1S3KvsRq79DmYH6kjlPCpUqTjH2hsDiqoA2gLuGSE7Gcm4L
         D4U8P12oqEMzaAg44JNZ/FNVKX4i5Tbq43cff3CivK+SpnMQxd6aw/+zMjHEs99iXg6Y
         CWwd7CYJMqrHfxwdeN4e5a39+KAE8Z3RE3dqlpC10yyLG2Vavu6csAELixxgy80BtytH
         UTpePilBjG4CQlP4wwjRnZ/DmPuazE9p1/G6t2S68KAuOVEFLG2RtKduVw1/TTSbmImW
         A2BQ==
X-Gm-Message-State: AD7BkJJvruJjc4o/ecN5cdCxgd67oiW6t1XkCrW9l+wFGfNd+KE4FK7AL8I2KpPm3Ycz0A==
X-Received: by 10.202.197.66 with SMTP id v63mr4152321oif.23.1459708758244;
        Sun, 03 Apr 2016 11:39:18 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:14c4:8f1:9484:755e? ([2001:470:d:73f:14c4:8f1:9484:755e])
        by smtp.googlemail.com with ESMTPSA id ji4sm7388557obc.6.2016.04.03.11.39.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 11:39:17 -0700 (PDT)
Subject: Re: [PATCH 0/6] MIPS: BMIPS: Random fixes for BMIPS5000/5200
To:     linux-mips@linux-mips.org
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
 <56F9DBF3.5060309@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57016353.7070500@gmail.com>
Date:   Sun, 3 Apr 2016 11:39:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F9DBF3.5060309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 28/03/2016 18:35, Florian Fainelli a écrit :
> Le 29/01/2016 21:17, Florian Fainelli a écrit :
>> Hi all,
>>
>> This patch series contains a bunch of fixes for the BMIPS5000 processor class.
>>
>> The first 4 patches are addressing some functional and cosmetic issues, while
>> the last 2 patches fix the existing code to support BMIPS5200 processors.
>>
>> Kevin, Jon, Jonas, please review!
>>
>> These were tested on BCM7425 and BCM7435.
>>
>> BMIPS5200 SMP patches will be submitted on top of this patch series
> 
> Ralf, can you queue these patches for 4.6? Thank you!

Ping? Any chance we can get these patches in 4.6?

> 
>>
>> Florian Fainelli (6):
>>   MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
>>   MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
>>   BMIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
>>   MIPS: BMIPS: Add cpu-feature-overrides.h
>>   MIPS: BMIPS: Pretty print BMIPS5200 processor name
>>   MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200
>>
>>  .../include/asm/mach-bmips/cpu-feature-overrides.h |   14 ++++++++++++++
>>  arch/mips/kernel/bmips_vec.S                       |    9 +++++++--
>>  arch/mips/kernel/cpu-probe.c                       |    5 ++++-
>>  arch/mips/mm/c-r4k.c                               |   13 +++++++++++--
>>  4 files changed, 36 insertions(+), 5 deletions(-)
>>  create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
>>
> 
> 


-- 
Florian
