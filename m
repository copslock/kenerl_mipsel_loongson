Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 21:14:05 +0200 (CEST)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:51083 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990598AbdINTN5I8OZ9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 21:13:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505416436; x=1536952436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K5zblusiODg7+UQWAgb8V+6j0kLsGASyVwOueLKYEpI=;
  b=l6WbebVYvdaW/u/gS3KAIHYlcNhCLKm+zks412d7BfewEbIidbo+otHN
   smaRC/7APqVvbPDZA5ocaAkkx6GLQBgWTPs6fSDTeqR4oc7P0fgo8lKjF
   k0xBnNWP5zhD46/6+zBmij6VOHxnGSk1pHWAP8MJE/bmS3BX0JKro0xUt
   U=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 14 Sep 2017 19:13:48 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 19:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505416304; x=1536952304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K5zblusiODg7+UQWAgb8V+6j0kLsGASyVwOueLKYEpI=;
  b=TRyNYjcqs6s0Js/L/KVG55qvOwBHUHJl+JHsCoaV+oH3zSQQ3a+wxPaG
   ZXmxY8X8RFBEGjc8zLnIgPjlE0k/KZgYwL1lSNLpBmhGlibYMRYJhJBSU
   hpqDY163eWbD3cI/3F4UeEeMhHuYS32sT860PsUjAckYleO6kk+9pIn8/
   Q=;
Received: from viking.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.26])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505416301; x=1536952301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K5zblusiODg7+UQWAgb8V+6j0kLsGASyVwOueLKYEpI=;
  b=EbprBtkvWIN0cQPChdaunNCHcI5reABcNh3WeKka7aluSBQKt+gCWxMd
   IO9p7oXEqeTzEfCWW/aztP5y/hH3CO5waY8jV3dD0mV7Jy9r1JtmXCkIY
   eE8jnRegh68OsUeQHgXfp6HuYJxqu+A+hz2cuMNVwSHA1SGfuNL+TQ/wQ
   s=;
X-Host: viking.odc.vzwcorp.com
Received: from casac1exh002.uswin.ad.vzwcorp.com ([10.11.218.44])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 19:11:39 +0000
Received: from scwexch15apd.uswin.ad.vzwcorp.com (153.114.130.34) by
 CASAC1EXH002.uswin.ad.vzwcorp.com (10.11.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 12:11:23 -0700
Received: from OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) by
 scwexch15apd.uswin.ad.vzwcorp.com (153.114.130.34) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 12:11:22 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 14:11:22 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 14:11:21 -0500
To:     Mathieu Malaterre <malat@debian.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
Thread-Topic: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
Thread-Index: AQHTLY1AJ3gFNMa2T0mnSLOLDKL4Hg==
Date:   Thu, 14 Sep 2017 19:11:21 +0000
Message-ID: <20170914191119.y554znlpcnsershp@sasha-lappy>
References: <20170914155051.8289-1-alexander.levin@verizon.com>
 <20170914155051.8289-11-alexander.levin@verizon.com>
 <CA+7wUszvyofkuLPb6K+E5ngJ7=e0CiCh1s+WQUBX0cG_MfnU7w@mail.gmail.com>
In-Reply-To: <CA+7wUszvyofkuLPb6K+E5ngJ7=e0CiCh1s+WQUBX0cG_MfnU7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A46EE134750CB948A818C653F8448450@vzwcorp.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@verizon.com
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

On Thu, Sep 14, 2017 at 08:59:05PM +0200, Mathieu Malaterre wrote:
>On Thu, Sep 14, 2017 at 5:51 PM, Levin, Alexander (Sasha Levin)
><alexander.levin@verizon.com> wrote:
>> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>>
>> [ Upstream commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 ]
>>
>> When a memory offset is specified through the commandline, add the
>> memory in range PHYS_OFFSET:Y as reserved memory area.
>> Otherwise the bootmem allocator is initialised with low page equal to
>> min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
>> starting from min_low_pfn instead of PFN(Y).
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> Cc: linux-mips@linux-mips.org
>> Patchwork: https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linux-2Dmips.org_patch_14613_&d=DwIBaQ&c=udBTRvFvXC5Dhqg7UHpJlPps3mZ3LRxpb6__0PomBTQ&r=bUtaaC9mlBij4OjEG_D-KPul_335azYzfC4Rjgomobo&m=6siOw0e29CYMhuJcboVwEeX-LcC1yJjtnGPVl_1tClQ&s=rP-QGn8HHjuow4b4qd6sfl_EEPoAKkxAffkh1zEq-kc&e=
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
>> ---
>>  arch/mips/kernel/setup.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index f66e5ce505b2..38697f25d168 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -589,6 +589,10 @@ static int __init early_parse_mem(char *p)
>>                 start = memparse(p + 1, &p);
>>
>>         add_memory_region(start, size, BOOT_MEM_RAM);
>> +
>> +       if (start && start > PHYS_OFFSET)
>> +               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>> +                               BOOT_MEM_RESERVED);
>>         return 0;
>>  }
>>  early_param("mem", early_parse_mem);
>
>Does not work on MIPS Creator CI20. See:

Hm, so upstream is actually broken right now?

-- 

Thanks,
Sasha
From mathieu.malaterre@gmail.com Thu Sep 14 21:18:10 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 21:18:16 +0200 (CEST)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:35681
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994231AbdINTSJtSti9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 21:18:09 +0200
Received: by mail-ua0-x241.google.com with SMTP id g47so87893uad.2;
        Thu, 14 Sep 2017 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FEiY6ICQ99ZTVIBKLMra871P8RYcStvdADrR/bdKXm0=;
        b=eYY/6eFb4mLW12AHP1aeQYiUfuUJBJyT386AWfmqWIK5kWruq40ZO8tUeqChtaMIyw
         Bo3kAPtFsQ8tdfEhFnPionP5Uvu4Cg5gI9pg+POOHIuU4htYlSbZZYH9+VVxYOAAdwAs
         9nDUkBJNo8gZd0MK5HEaQZ+RYjn5xa69cKpTwSB2wwoOEve3tDg1AJH9elGbqHcsj4Yp
         hH3grpJNNvYgg3iCvzthGmOYU+LAWS8PlUW1HHcSjjXXjcRMpkatBD+s55Fni61Wh+ns
         doSsH0FOtFKrHj+kFaI8fg3VJ+B63A9B/3yRmgePlDyLkHyrPrrJcq4MMqgG7pgyBJCA
         ihRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FEiY6ICQ99ZTVIBKLMra871P8RYcStvdADrR/bdKXm0=;
        b=cTtTGD7uT5UEaqnUOQElKIWjtGrezvV12dF9Xc1U6SCm7EjdSLYRhmGeXxozYmEKxP
         jGi1RqoqhD7cQ0sowyu8jb8eGjPhZnT0Q0sdEeblrGs/64GQT5OuZzp85CM8oELDFXgD
         E2uvlFupTWF7jrOnSOapZVHZWW9kTTfDSo5bIG0G3j7GimVrUJ5LqiCBBgLvdeDoTi3t
         o+rupYB3Es6XgIM1Gf70eyGgjg5MhmGP1Tbw1ITGiROJfBfo0/HKChyEfvM5DTdvP+NA
         rgQx+co3zQxZo/oqqgtdIGvWviXu93E9zOVkRhHG1z3y+uZGZEtlK9NvwONiLRXkkMpI
         A/gA==
X-Gm-Message-State: AHPjjUivumeOPnny8frD7LmYfvSLoi3KoF83+KkKF5vHlfN99pE/JyZ6
        x3B1rPkfwiGBFDb2goqqtmLz0r5v807pZkv8SFc=
X-Google-Smtp-Source: ADKCNb6qpw7ofSxR4xOOVd0McbN6Y9f8Y4Ejja8bO8i//0jnC9uxEwEPp0AA+0xnf3YF1a/uBcwP52hPgALSJhYYP2Y=
X-Received: by 10.176.30.196 with SMTP id p4mr10449417uak.17.1505416683248;
 Thu, 14 Sep 2017 12:18:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.81 with HTTP; Thu, 14 Sep 2017 12:17:42 -0700 (PDT)
In-Reply-To: <20170914191119.y554znlpcnsershp@sasha-lappy>
References: <20170914155051.8289-1-alexander.levin@verizon.com>
 <20170914155051.8289-11-alexander.levin@verizon.com> <CA+7wUszvyofkuLPb6K+E5ngJ7=e0CiCh1s+WQUBX0cG_MfnU7w@mail.gmail.com>
 <20170914191119.y554znlpcnsershp@sasha-lappy>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 14 Sep 2017 21:17:42 +0200
X-Google-Sender-Auth: cLxkbG5WmcmXYKRn2G7RsWAGRfY
Message-ID: <CA+7wUsy7X_3ST0hgnyxWMiC45ZeM8A_oafzn9PuufETkcKN+Xw@mail.gmail.com>
Subject: Re: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
To:     "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Thu, Sep 14, 2017 at 9:11 PM, Levin, Alexander (Sasha Levin)
<alexander.levin@verizon.com> wrote:
> On Thu, Sep 14, 2017 at 08:59:05PM +0200, Mathieu Malaterre wrote:
>>On Thu, Sep 14, 2017 at 5:51 PM, Levin, Alexander (Sasha Levin)
>><alexander.levin@verizon.com> wrote:
>>> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>>>
>>> [ Upstream commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 ]
>>>
>>> When a memory offset is specified through the commandline, add the
>>> memory in range PHYS_OFFSET:Y as reserved memory area.
>>> Otherwise the bootmem allocator is initialised with low page equal to
>>> min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
>>> starting from min_low_pfn instead of PFN(Y).
>>>
>>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>>> Cc: linux-mips@linux-mips.org
>>> Patchwork: https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linux-2Dmips.org_patch_14613_&d=DwIBaQ&c=udBTRvFvXC5Dhqg7UHpJlPps3mZ3LRxpb6__0PomBTQ&r=bUtaaC9mlBij4OjEG_D-KPul_335azYzfC4Rjgomobo&m=6siOw0e29CYMhuJcboVwEeX-LcC1yJjtnGPVl_1tClQ&s=rP-QGn8HHjuow4b4qd6sfl_EEPoAKkxAffkh1zEq-kc&e=
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
>>> ---
>>>  arch/mips/kernel/setup.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index f66e5ce505b2..38697f25d168 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -589,6 +589,10 @@ static int __init early_parse_mem(char *p)
>>>                 start = memparse(p + 1, &p);
>>>
>>>         add_memory_region(start, size, BOOT_MEM_RAM);
>>> +
>>> +       if (start && start > PHYS_OFFSET)
>>> +               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>>> +                               BOOT_MEM_RESERVED);
>>>         return 0;
>>>  }
>>>  early_param("mem", early_parse_mem);
>>
>>Does not work on MIPS Creator CI20. See:
>
> Hm, so upstream is actually broken right now?

Yes, at least on Creator CI20. You need to clear out all your mem=X@Y
from your boot command line, or apply the new patch I mentionned
above, or revert 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411.
