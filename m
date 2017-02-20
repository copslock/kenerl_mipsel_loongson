Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 05:10:28 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:35838
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdBTEKTTN-uS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 05:10:19 +0100
Received: by mail-qt0-x244.google.com with SMTP id b16so9245615qte.2
        for <linux-mips@linux-mips.org>; Sun, 19 Feb 2017 20:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mmayer-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AFZi/2W8mw/qInMrbegwg27WOjJpg+3H+sGlEM4UhHs=;
        b=NST1WvdhfUt5Q76BYgykJfJYaIGWETQ6Xzd7ELw6olSKIek0XRWbUuajjs4QoBNMe9
         uyqXEKvveYng9qCNk0h4BzoD97rRXhBy3et1v/v3AE4hq+5q1LUCnRFigGyMRLgW1xcW
         oFa6ntro0Lr51yBgX9UI9GicTmbk1IL9Aj6HNlRZTbrnuOiz2H+vg7M6Gr1XUZjgjhVS
         VpQ6z597JnCTsT+cP3wyaKyqGSYdGdt/nBdX5gf46kqhof83pmLFCCI2wJt9VNpSEX6w
         do7erM1SHACAokhvvHo/CcbndrGNusu7o9lEw20Y119x/gAo7mrH3KJlRfcqeTty13m8
         1wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AFZi/2W8mw/qInMrbegwg27WOjJpg+3H+sGlEM4UhHs=;
        b=j5HDGRG0yQZDVD/wwgMMnanMV/HdmmOUTPujxEl+1ycdQ7sBxmwqOzP/Edl7s6Eldn
         ARaMit0Mtv9ndkBfCoGDPK4a4qbokgxktBQqmh6BrLzmhxbVmGkXEIz5MtB+BjXJaNz/
         1Bq5Fg2jdnBAA96JS/I1qMCWpqvx+lqTbGqH9Mi71BrkGlzHVVjO4r8JMZ5x393N0WSp
         wijUWrQGbH9RiCK4zNfaGhrJDNS623xErDhhLTX5+pSzKozE0Vey+N/v8ceaDxVP+Cbd
         oi4HAMYcgeuwcryhhsacGY+XJMwRWOzJjG8gHmsSplP2kml03p7Ky4dGhXz4SeqG3lP8
         yn1A==
X-Gm-Message-State: AMke39lp90OZAr4bnTMBJv5lm+f2qt8FiHolWZiVWV1IGUzg0wufgn7EqvSTStF2vHCFsyfE0mEk4f8BJanjNQ==
X-Received: by 10.200.36.75 with SMTP id d11mr17563002qtd.268.1487563813473;
 Sun, 19 Feb 2017 20:10:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.152.150 with HTTP; Sun, 19 Feb 2017 20:10:12 -0800 (PST)
In-Reply-To: <20170220032911.GM21911@vireshk-i7>
References: <20170217202704.33596-1-code@mmayer.net> <20170220032911.GM21911@vireshk-i7>
From:   Markus Mayer <code@mmayer.net>
Date:   Sun, 19 Feb 2017 20:10:12 -0800
X-Google-Sender-Auth: 7L19PaF2AHji5dFEWtVPegFz8rM
Message-ID: <CANEuBv43mVEHrYUWBO4f2aHp4HyssHHbkYzo_Tvx4rm6Qt_9ow@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

On 19 February 2017 at 19:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-02-17, 12:27, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Add maintainer information for bmips-cpufreq.c.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>
>> This is based on PM's linux-next from today (February 17).
>>
>> This patch could be squashed into patch 3/4 of the original series if that
>> is acceptable (see [1]) or it can remain separate.
>>
>> [1] https://lkml.org/lkml/2017/2/7/775
>>
>> Changes in v2:
>>   - added bcm-kernel-feedback-list@broadcom.com
>>
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 107c10e..d4ac248 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2692,6 +2692,13 @@ F:     drivers/irqchip/irq-brcmstb*
>>  F:   include/linux/bcm963xx_nvram.h
>>  F:   include/linux/bcm963xx_tag.h
>>
>> +BROADCOM BMIPS CPUFREQ DRIVER
>> +M:   Markus Mayer <mmayer@broadcom.com>
>> +M:   bcm-kernel-feedback-list@broadcom.com
>
> Isn't this a list as well? Shouldn't this be L: ?

We used to do that, but then there was a discussion at some point in
the past (I don't have the link handy for it at this point), where it
was suggested that we use M: for the Broadcom list, because it is a
private, closed list (i.e. you can't just go and subscribe). It does
reach a bunch of folks at Broadcom, however, who work on upstreaming.
Therefore, the reasoning was that it fits the "maintainer" category
better than the "list" category (where people might expect to be able
to subscribe or find a public archive).

>> +L:   linux-pm@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/cpufreq/bmips-cpufreq.c
>> +
>>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>>  M:   Siva Reddy Kallam <siva.kallam@broadcom.com>
>>  M:   Prashant Sreedharan <prashant@broadcom.com>
>
> --
> viresh
