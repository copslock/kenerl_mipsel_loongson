Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 20:49:37 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:37971
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdJHStaILGwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 20:49:30 +0200
Received: by mail-pf0-x243.google.com with SMTP id a7so22501318pfj.5
        for <linux-mips@linux-mips.org>; Sun, 08 Oct 2017 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0dbKbbITTkOTPKloUHEG5A6WoUcPmUDyJaQBk0CNZ4=;
        b=htTyBDM4l9Oye/5ClIzVJjLCefpIY1PUndZ/6bLCRgCeoPCfI0+z6ao0XX7USh17M0
         euLPzv63VtSdb1+e2ziHsjaVhC+wOPgCeL2ek6kQq8Q2yaqFycPKfQXZMnPQRGnWp9+d
         zyIw/vv99IVVqIfGMZy0rvmw6tMoESFUc65fZAy8/Krmlo+MRIOnuttFuoUHgqu6vdZc
         thXGb24ZIWu1a8Rn/Qelz9GscP+1A7cTXfsUZCNpQWHlK8sf6oS6wC/711Z12OBfNgh3
         6NCLaXCDgBb/0tgekkuykIHFup34RrqeHTRlnn2luhwRZzpvUU8OgO0R9hQ4T4xBRZXK
         pPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0dbKbbITTkOTPKloUHEG5A6WoUcPmUDyJaQBk0CNZ4=;
        b=hK3OMXaX5Zl/NL7HHLz0pxCt215JAXLl4QKLEMpS8CHgDPlcImknYfTGkG0O0eS4rW
         95bQkqS82nQqkaEL05T2yKNVOE6vjs3MT4RofCHMuX0m3WSYZYDbLQKgz+9PTT/1tHne
         x+N7OW6RzO00jbprZ455Pbzi3DvM4KaCcyuCASq72GmlX/HX+c/OBFxyoUFQp5OZCnQQ
         v2rxrsj62GW4cq/lGJCNSM7Yd6CHQhhzFAnzN1p7R2+EXXQkvsoDhLc/RYTf2zyd/SeX
         jRvzGNIXjyrMYzOpmRDEzxxJD4NM5W8Iw5zT+tcXBm61ydz/09o+WMLm579W8HkuVsKj
         zi4A==
X-Gm-Message-State: AMCzsaVcxsXHEfHZGa5dwUSiCakCuqyRgSYJRr7mbjXJ+kyuounfjJjg
        XTYS3cEIn33kCfBo56f4CK8=
X-Google-Smtp-Source: AOwi7QALvJTlubocXAHoCUTC4m5ODb0opIfDqZ3/2kbObSpRq+OKmwZ2TWoEYF6sb36PtlyqRwHpEA==
X-Received: by 10.99.119.138 with SMTP id s132mr7229173pgc.399.1507488563303;
        Sun, 08 Oct 2017 11:49:23 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j12sm10865364pgc.6.2017.10.08.11.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Oct 2017 11:49:22 -0700 (PDT)
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
To:     Ben Hutchings <ben@decadent.org.uk>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <573936E3.3050003@roeck-us.net>
 <1507486329.2677.81.camel@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d7d60beb-4875-7cbf-0fd6-26317b97115d@roeck-us.net>
Date:   Sun, 8 Oct 2017 11:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1507486329.2677.81.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60322
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

On 10/08/2017 11:12 AM, Ben Hutchings wrote:
> On Sun, 2016-05-15 at 19:56 -0700, Guenter Roeck wrote:
> [...]
>> For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessary to
>> apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page' functions").
>> It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
>> make sense to apply this patch to both releases. Would this be possible ?
>> This way, we would have at least one toolchain which can build all 3.2+ kernels.
> 
> I'm finally queueing this up for 3.2.
> 
> Ben.
> 

mipsel images in 3.2.y-queue are now crashing for me. Should I have a look ?

Guenter
