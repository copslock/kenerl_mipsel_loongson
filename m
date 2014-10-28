Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 13:51:14 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45241 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011594AbaJ1MvNIRahy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 13:51:13 +0100
Received: by mail-ie0-f174.google.com with SMTP id x19so537486ier.33
        for <multiple recipients>; Tue, 28 Oct 2014 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/xqmLLLFiE+eDluyC0NpLyoY4QrQuth/T2YStufDioY=;
        b=p2QDY1DMDKQT4urEoVT+ybV6Szze6S28QEpRKIk5HeguSabk35QYNhaLvCJmZ4MSZw
         uaZEao/Y498mbtAjx0NzZM++upucgU1Wl22og4exvPAe9JerpYpGpU72u9hibdhG+j6x
         FAcCC5oqZjNJQxu3NObv2jjaZPuudRbR0eBayJv8Ft48VqztvYJB4TElED4KwzJhSyYj
         dZHRgUqTrq6uIkHbqFn1p3nLTS35IgBEwmDZk3VeIAW8bQbDy9JgZhQhIQ1wVAXgWOtT
         xkPElEf40EDtJJ3+wnHRXnJV6iUomi5fN6D5CdkelRfWszquRWaBk11M1VXeazAtACWl
         y2ww==
MIME-Version: 1.0
X-Received: by 10.50.43.130 with SMTP id w2mr4257477igl.21.1414500666779; Tue,
 28 Oct 2014 05:51:06 -0700 (PDT)
Received: by 10.107.154.15 with HTTP; Tue, 28 Oct 2014 05:51:06 -0700 (PDT)
In-Reply-To: <20141028124804.GC16320@linux-mips.org>
References: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
        <20141028124804.GC16320@linux-mips.org>
Date:   Tue, 28 Oct 2014 13:51:06 +0100
Message-ID: <CACna6rxSCZJ=oUNXVYEbkSZuiyUyy96amkMKbg7pdEXkVmtkZw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx
 polling it
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 28 October 2014 13:48, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Oct 28, 2014 at 01:30:23PM +0100, Rafał Miłecki wrote:
>
>> This drops ssb/bcma dependency and will allow us to make it a standalone
>> driver.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> This patch depends on
>> [PATCH V2] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx polling it
>
> You've even posted a V3 of that patch:
>
> V2: https://patchwork.linux-mips.org/patch/7609/
> V3: https://patchwork.linux-mips.org/patch/7612/
>
> I assume you meant V3?

You're right of course :)

-- 
Rafał
