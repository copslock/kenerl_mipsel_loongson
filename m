Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 08:31:54 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:52699 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1BQHbu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Feb 2011 08:31:50 +0100
Received: by wyf22 with SMTP id 22so2068881wyf.36
        for <linux-mips@linux-mips.org>; Wed, 16 Feb 2011 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H+OJCV+lx/859o0f9JiI/cJK5Ns6sSsh5n7l5s7+8fg=;
        b=mTGK8tJ/b4gsoY2ugeCqo0RsznqYTCldoHDBZf1G2glA4LiwR70h5q1mcqDBccmSuC
         O3MVul/HkEjEf2ui2etyiqmpw1l4GtLiacqM4brUDiJTwrN4JT4wrDHcoSr5Dd5BWF0K
         +Od/+M4lRfqJZ/Clu/jAyaqs58sS/ANnUMhXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Obs/IDRIQ2jJLiWMoof0JF4lYTUgT+iRPRUh4IeqZB9QbuDdDGP3R9p+lboByFKbHW
         5I6NQ2Ril1BtiaVoIXqD1TZAM+Mm3wI6Hckynud6f9AM2OA4uHNNHgIJnU87zsQoXOjI
         4YsNFam7eoBegQL/OLckUYi1AzV7y0wSkunMI=
MIME-Version: 1.0
Received: by 10.216.17.202 with SMTP id j52mr10884wej.36.1297927905259; Wed,
 16 Feb 2011 23:31:45 -0800 (PST)
Received: by 10.216.193.195 with HTTP; Wed, 16 Feb 2011 23:31:45 -0800 (PST)
In-Reply-To: <4D5CB5FB.20305@gentoo.org>
References: <4D5A65E3.1050707@gentoo.org>
        <4D5C5C66.6060205@metafoo.de>
        <4D5CB5FB.20305@gentoo.org>
Date:   Thu, 17 Feb 2011 08:31:45 +0100
Message-ID: <AANLkTimLjhY+sNuMh_gOXNuxZuFOvi25KMYFU4Xp1hbY@mail.gmail.com>
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Kumba <kumba@gentoo.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

> I have determined the following formula specific to the SGI O2 to read the
> RTC registers:
>
> readb(pdata->regs + RTC_<REGISTER> * 0x100);
>
> is equivalent to
>
> readb(pdata->regs.time.<REGISTER>);
>
> I'll assume writeb() changes are the same.  The question is, how do I wire
> in the 0x100 padding value in such a way that I keep the IP32-specific bits
> out of generic code?  Ralf mentioned using some field in platform_data, but
> I haven't quite learned the platform stuff (this is my first real attempt at
> a kernle driver).

Have a look at i2c-ocores.c:    Basically you use platform_data to specify
register spacing on the bus.

Manuel
