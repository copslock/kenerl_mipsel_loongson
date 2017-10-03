Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 19:01:17 +0200 (CEST)
Received: from mail-qk0-x229.google.com ([IPv6:2607:f8b0:400d:c09::229]:54021
        "EHLO mail-qk0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990429AbdJCRBHtjFit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 19:01:07 +0200
Received: by mail-qk0-x229.google.com with SMTP id w63so8899314qkd.10;
        Tue, 03 Oct 2017 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNTJJmA0P8ahL103LTAs7Vd8nK9p5cc2ncNOHh6nYQo=;
        b=aehfp9Q/VjFIqao8gV8ERPaDW1Ip2EDK72vIMjCc+m7qCPCPWIV+qjbCwdIZP+onpN
         ed+RJ4IUL7ueO6zNokDa8aVgMKayd3C7CpfxHiOpDnwa7nnkUpZm8diVXkaLM54XeiXQ
         jKOLPxf/rpM1A3idFsV+AQllybwyHhTsFUN+nLnqQxwRoQSmrcNhZ/Akw7T4Y67vqzmx
         Ro3NQVTAeyTAJV5znpXOTVjD/+Gxbeh0SHt2tuWi3saxlPoh1bBfFttyNumNHoFrO0Dc
         X93OvwFGLme66rX2POaqIf9Uyel8k2bNoAQkMaifE8lzTP5zi9bujg0f9BhSOUXS/0E8
         pTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNTJJmA0P8ahL103LTAs7Vd8nK9p5cc2ncNOHh6nYQo=;
        b=PCZb58A9Ai+O/QNrsbUlDCqbiO6Wh/D46641fW+AjWa+BqO4i9j5vmhWd/sy55cKBL
         Wt5K4T7ZROobZtU0dSuNRbv/SV6F9GqNNqToCIuRTwbcEuxzRG0lz/2iU/vwX7XeiTU4
         Fi0lsoOmY7um3SWDk7NkGh7pqDT4yjaJr5RBmfpi8JdsRjyIF4MSKjtNZiW5z+Nlk1RB
         AGadF0YTygfCXJ5R9ifDC8XAs9j67thPcvCRlI/FXzlNud7c1pzFJRynh9mPC+3tQ77I
         6xeM/S1qWtQfDm7dNGd8WTZkQLwf6OoVp+9NLHoV3fxFeoSDaYb6Di003ZMQPuKWZ8l0
         qHsw==
X-Gm-Message-State: AMCzsaX09ruf4lKQ8u9/b5i98Ib2vUMyUz5SMwaRnBkd2IxTxHOHPQ6D
        Ua18WAqm5XlG31R2VnF8G1yMEBJR
X-Google-Smtp-Source: AOwi7QDmiPipc3UVVSsyy73wJHro0yncaEhqWyhOtxqNnKiKQkIgC05ehGM8o2eCc+H+0/WjRPCiCw==
X-Received: by 10.55.82.194 with SMTP id g185mr12767038qkb.282.1507050061101;
        Tue, 03 Oct 2017 10:01:01 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id h4sm9025499qth.75.2017.10.03.10.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 10:01:00 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix sparse CPU id space build error.
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
References: <1506965989-5043-1-git-send-email-steven.hill@cavium.com>
 <5b5111e8-c6c5-0814-d109-b325969c27b5@gmail.com>
 <4bc7e31a-3db1-8254-9cb9-b794ebf0bf15@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cdb3aebd-b30a-eb55-3715-f0ece3fa1af5@gmail.com>
Date:   Tue, 3 Oct 2017 10:00:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4bc7e31a-3db1-8254-9cb9-b794ebf0bf15@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60240
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

On 10/03/2017 08:53 AM, Steven J. Hill wrote:
> On 10/02/2017 11:05 PM, Florian Fainelli wrote:
>>>
>>> Patch "MIPS: Allow __cpu_number_map to be larger than NR_CPUS" was
>>> incomplete, thus breaking all MIPS builds.
>>
>> Did not you submit a corrected version as part of [PATCH v2 00/12] Add
>> Octeon Hotplug CPU Support.? Was v1 already merged?
>>
> Yes, I did. However, Ralf had already pushed the broken v1 patch
> upstream. Timing jitter of patches.  ¯\_(ツ)_/¯

Ralf, did not you have a post-receive hook set-up that emails people
when you apply their patches at some point?
-- 
Florian
