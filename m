Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 09:39:46 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:65150 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1BQIjn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Feb 2011 09:39:43 +0100
Received: by wwi17 with SMTP id 17so2161611wwi.24
        for <linux-mips@linux-mips.org>; Thu, 17 Feb 2011 00:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uBGbesRT3AmxjIYyfe4f/CxTtpcN2dL5g8qt3RbudQM=;
        b=AYbTuwuFgtVXkDvV3ygAv2N9B/+aNrg5+nKklt0oVpK4JfhAicXEBbF8yekIy13JEy
         bcEr38uN/SRREP5ba8m/tsMpigba2VJlrMnne06AwwqIl5dgeDoJdNxTSuzoIOwrLDt3
         7i8G10lhkLSC2+n/EjhYgcI50uF5+HR+AGx3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UfNthOvxuwZt0J2UeBeXeucz2Q4YRNrM56IMkdXCNF68XoxrQruEWlUT/h81FYlHB4
         p0ALoY49dRWgTUMOBoyKIZ+fr4Vttn1cCLv4Bo2VAg9MGiojrVRNQMqP3qrQ4I7TgMIJ
         6z6qY7fDM+Ku5on16SCzaVN/GRQTYKGbb2eK0=
MIME-Version: 1.0
Received: by 10.216.17.202 with SMTP id j52mr67452wej.36.1297931977850; Thu,
 17 Feb 2011 00:39:37 -0800 (PST)
Received: by 10.216.193.195 with HTTP; Thu, 17 Feb 2011 00:39:37 -0800 (PST)
In-Reply-To: <4D5CD99E.6030300@gentoo.org>
References: <4D5A65E3.1050707@gentoo.org>
        <4D5C5C66.6060205@metafoo.de>
        <4D5CB5FB.20305@gentoo.org>
        <AANLkTimLjhY+sNuMh_gOXNuxZuFOvi25KMYFU4Xp1hbY@mail.gmail.com>
        <4D5CD99E.6030300@gentoo.org>
Date:   Thu, 17 Feb 2011 09:39:37 +0100
Message-ID: <AANLkTinwhfZ1Vv=gVa2pgqd4FEcTpQtTzVFE5HX6sCcG@mail.gmail.com>
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
X-archive-position: 29199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 17, 2011 at 9:17 AM, Kumba <kumba@gentoo.org> wrote:
> On 02/17/2011 02:31, Manuel Lauss wrote:
>>
>> Have a look at i2c-ocores.c:    Basically you use platform_data to specify
>> register spacing on the bus.
>>
>> Manuel
>
> I think I get most of it here.  i2c-ocores.c defines `struct ocores_i2c`,
> which has regstep in it.  I assume the equivalent to this in the RTC driver
> is going to be ds1685_priv.  But in i2c_ocores.h, `struct
> ocores_i2c_platform_data` is defined, which also carries a regstep.  In
> i2c-ocores.c, this struct becomes *pdata while ocores_i2c becomes *i2c, and
> *i2c is used to access the registers.
>
> I don't think I have an equivalent to either of these two with the way the
> driver was originally written and how I modified it.  The ds1685_priv kinda
> does both right now.  I assume platform_data is not really defined...I have
> to implement one specific to this RTC driver, giving it specific variables
> that need to be customizable at the platform level, and then set those in
> the machine-specific areas, i.e., somewhere in IP32's platform file.
>
> Sound correct?

Yep.

Manuel
