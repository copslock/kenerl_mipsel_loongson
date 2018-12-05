Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB2C04EB9
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AABE2084C
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PiXUmuGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AABE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeLELHn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:07:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37028 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLELHn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 5 Dec 2018 06:07:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so12383027wmd.2
        for <linux-mips@vger.kernel.org>; Wed, 05 Dec 2018 03:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A++0V7UA0QaWe5cbXmctgYgohP9k0b3S/uW5so7fpyw=;
        b=PiXUmuGkV4NoeHWqkzGmFxQUD9ul5DunnOV8VHz2o3S2ueAjK4+ktDKDwG5DKBpNut
         pJiQR2nHQuxKPXYNWC2ufAxrsld4OlIgHh795X2OhH7eqabG4MnYiztcSx7LwUr5SRTX
         8ovQNGR3nDy/9WbJebFyupbjJx2OTDzvMFRUcPnYFE92yegIDfOTsJxujkFSl9j6aUaK
         cadT8cjCU/TJux1T6EiLgFW/q7ZLyndFTg+71hWtIuMjQtqcgpuz6EDdbtwdH6mfQXfz
         33Xk2w67NmAgZQVdOgP/nImwGJ1gD4fDL7PuQUX+5JEw/TxDqgTIjY1/pvJyWjqcmSaV
         MFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A++0V7UA0QaWe5cbXmctgYgohP9k0b3S/uW5so7fpyw=;
        b=gs8eTjYen9ioLWCqcfORgGBVXn2ZkS4O0Xa9cbmMKaDPXRQjTSn5+17Nykoe2OgpDX
         7k9s+aJvhL4eUrIr7SuACrwizYoSo+n6AZ454JbO8CprBLnXXK3nPMXpCbw8EszHUvbf
         aO7r8ZIlLjp57GlyOgejN7AT97IZyG+hFK5C4uKhMDDWRLFTpPHlFn6nwHqgIi9zdYt6
         Tk33oLBeKY6YaKuDiIa3DwEc1TwQQxOxsxcegzDrM3SdSIO4qQVKZbScyEtRH5RZhQ7Z
         jiuUMD0jV/zOCTeahHD5MpxzMN/sua4oQOTPlYX0BjW5DlK+Z799hyeTVvkhw91VRMmO
         HxrQ==
X-Gm-Message-State: AA+aEWZuEEluctgCrPLzsAFKxojVLjp/ESoaED9SWsQHDuJY8DP4KqXw
        65NufvTmlEOyuJJHXmgO0ewtdpBrtVM=
X-Google-Smtp-Source: AFSGD/Um3BGCggPjPMgtpERGOwdvFsswWEFgqdPZ4cQr2aT2MeVjO7jCqRV5m8fGBDRGCPTDVZ/4gg==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr15122131wmh.77.1544008061076;
        Wed, 05 Dec 2018 03:07:41 -0800 (PST)
Received: from [172.20.1.221] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t6sm19300994wru.11.2018.12.05.03.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 03:07:40 -0800 (PST)
Subject: Re: [PATCH bpf-next 1/7] mips: bpf: implement jitting of BPF_ALU |
 BPF_ARSH | BPF_X
To:     Paul Burton <paul.burton@mips.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <1543956922-8620-1-git-send-email-jiong.wang@netronome.com>
 <1543956922-8620-2-git-send-email-jiong.wang@netronome.com>
 <20181205000250.mc6aw6odykynadkg@pburton-laptop>
From:   Jiong Wang <jiong.wang@netronome.com>
Message-ID: <8802b738-c0f3-1806-4c27-998b1a440df5@netronome.com>
Date:   Wed, 5 Dec 2018 11:07:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205000250.mc6aw6odykynadkg@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 05/12/2018 00:02, Paul Burton wrote:
> Hi Jiong,
>
> On Tue, Dec 04, 2018 at 03:55:16PM -0500, Jiong Wang wrote:
>> Jitting of BPF_K is supported already, but not BPF_X. This patch complete
>> the support for the latter on both MIPS and microMIPS.
>>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Cc: linux-mips@vger.kernel.org
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>>   arch/mips/include/asm/uasm.h      | 1 +
>>   arch/mips/include/uapi/asm/inst.h | 1 +
>>   arch/mips/mm/uasm-micromips.c     | 1 +
>>   arch/mips/mm/uasm-mips.c          | 1 +
>>   arch/mips/mm/uasm.c               | 9 +++++----
>>   arch/mips/net/ebpf_jit.c          | 4 ++++
>>   6 files changed, 13 insertions(+), 4 deletions(-)
> I don't seem to have been copied on the rest of the series, but this
> patch standalone looks good from a MIPS standpoint. If the series is
> going through the net tree (and again, I can't see whether that seems
> likely because I don't have the rest of the series) then:
>
>      Acked-by: Paul Burton <paul.burton@mips.com>
>
> If you want me to take this patch through the MIPS tree instead then let
> me know.

Hi Paul,

Thanks very much for the review. I'd like this set to go through net tree
that this feature could be enabled as a whole for all affected arches.

For the Cc, I was thinking the practice is to Cc people on patches of their
subsystems, but guess a better practice might be also Cc on the cover letter
so the background and affected code scope will be more clear.

I will do this in v2.

Regards,
Jiong

