Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 21:01:19 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34322
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992310AbdJHTBMrzoar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 21:01:12 +0200
Received: by mail-pf0-x241.google.com with SMTP id b85so2181245pfj.1
        for <linux-mips@linux-mips.org>; Sun, 08 Oct 2017 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOoNMV9zFnn16ezN2uT0y5n1aGas8drKWdF48EsDxx4=;
        b=HzANwv6HIs3Li56FuNa18giTLx0uy4ti0yBtTmlRKWW9kdaKpH/0a/kZDq/n3CGC+3
         6TfKhr7DWzTnpk2D8aXM0yzrOPGDrRXuBFFNu/7ENQuAkofZaZwcTUe4JDJ5P8p4ZgAv
         zCZEcuZXj2nVmpeElMETWsDCbsqd6ylCle/JlcUPMPL4vC9vahBjz5DeRZw5MgDQNKqS
         xb9xztuMlQbIgt50HsBofd4q1ZuSVT2hgjNF5uCix8jxQ696Sl3WEQaAJnlV/phaprhi
         r8suBxTcwlb8NW3BXhb0Bin7kXfb/tcyOeAGHTbl1lJkD5QGilFYO08tiw9SaItpB0xL
         23Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOoNMV9zFnn16ezN2uT0y5n1aGas8drKWdF48EsDxx4=;
        b=G6MOGTQ8ZPXfS6lYSH1XIrHiFKpShxS3YH0l7Zj2WrlVjj1UJ7LVIobrKUV6JzMFuS
         tdvGWR/DVM7UnIXcymm6+FJSMBgbN+aXLRmkx+o+w+s8GDwXRNeYClXzNG1lG9OW3grC
         5X/KzvR2Wc6XNq3mpd4wV8Ga8uMeJh7MvJWiehKKWb50AC/nDfeUqqfGUgc1B7quqfZ2
         Wtd/Ng+E5URyLj+X/3gIBgVvwabKArTTc68WDpIIezWiRBSAKT9JPkOEWJbHckyQGbQW
         2IugtBb9u6Z01KYVjuEFYMw/EUyYeZktUiulLUwhLf8BOu5ip7z+596/Lt0Iwf4fSPe0
         PFNQ==
X-Gm-Message-State: AMCzsaVVBLXD1U5AMoF1SZQNXEgIZCCcigku7BvEuuZGzS4kPYycPoOl
        edWvGBE7IGdU27P3BlIftZPFbg==
X-Google-Smtp-Source: AOwi7QDV+pDWFtmZ3cXdR5z5ywUxl/IOu7cookimfRat5yJnET+gDNQpzBjF394E+/4njAka8g8Aew==
X-Received: by 10.98.223.137 with SMTP id d9mr3558640pfl.98.1507489266317;
        Sun, 08 Oct 2017 12:01:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t2sm12682843pfk.90.2017.10.08.12.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Oct 2017 12:01:05 -0700 (PDT)
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <573936E3.3050003@roeck-us.net>
 <1507486329.2677.81.camel@decadent.org.uk>
 <d7d60beb-4875-7cbf-0fd6-26317b97115d@roeck-us.net>
Message-ID: <05e37183-f6a6-d141-5dad-9d4b161953b1@roeck-us.net>
Date:   Sun, 8 Oct 2017 12:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <d7d60beb-4875-7cbf-0fd6-26317b97115d@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 10/08/2017 11:49 AM, Guenter Roeck wrote:
> On 10/08/2017 11:12 AM, Ben Hutchings wrote:
>> On Sun, 2016-05-15 at 19:56 -0700, Guenter Roeck wrote:
>> [...]
>>> For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessary to
>>> apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page' functions").
>>> It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
>>> make sense to apply this patch to both releases. Would this be possible ?
>>> This way, we would have at least one toolchain which can build all 3.2+ kernels.
>>
>> I'm finally queueing this up for 3.2.
>>
>> Ben.
>>
> 
> mipsel images in 3.2.y-queue are now crashing for me. Should I have a look ?
> 
Turns out the culprit is qemu. I had switched from qemu 2.9 to qemu 2.10.
Something has changed in qemu that causes a qemu boot failure with 3.2 mipsel
(but not in more recent kernels). I'll switch back to qemu 2.9 for the affected
builds.

Guenter
