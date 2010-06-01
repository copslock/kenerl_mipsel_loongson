Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 08:23:35 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:55993 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492272Ab0FAGXa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 08:23:30 +0200
Received: by gyb11 with SMTP id 11so3401178gyb.36
        for <linux-mips@linux-mips.org>; Mon, 31 May 2010 23:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pYnWup1x8h9RmxGpohV8/ahMYJyWhK1vzu09B9nMgEs=;
        b=lyxqWtC3HFfywp8rM+KZT0olzjeMfrXrWLsyNXtHDFac6d4m0gFRX2E4U3K2+6Qp2G
         LNTESU8tJM0MEo+HMtfs0me3KzktlJvHfJOkYvnDpDf2wel/vsT+l/vK0Tc2kUP1N7TG
         bsLjBeQso9VrAKU+3mcZvvXGfx4aEa+Avr8gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uPc1Th2R7ZUAGJpfw2Ruo25p3OOTprYh5X4QYAssiLanQMHckbQRLwtJGDOqu0ZPsO
         ZHOpJYySOKowfHYVUmtj55+m7Q1GUOSNrKwPGnn1fg7zHI8gRSp/VQzY/zj1vsQ0weRY
         oAa52JlIFGgad21fXAlN6Q4RtpR518Gi8qUWo=
MIME-Version: 1.0
Received: by 10.231.148.143 with SMTP id p15mr7200232ibv.15.1275373401998; 
        Mon, 31 May 2010 23:23:21 -0700 (PDT)
Received: by 10.231.183.74 with HTTP; Mon, 31 May 2010 23:23:21 -0700 (PDT)
In-Reply-To: <20100531211842.GA795@merkur.ravnborg.org>
References: <1275332878-19762-1-git-send-email-manuel.lauss@googlemail.com>
        <20100531211842.GA795@merkur.ravnborg.org>
Date:   Tue, 1 Jun 2010 08:23:21 +0200
Message-ID: <AANLkTilUtwCpTjAdUxLJSjnwUe3i2aKlIrdnQ_ZBH6j5@mail.gmail.com>
Subject: Re: [PATCH -queue] MIPS: Move Alchemy Makefile parts to their own 
        Platform file.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 96

Hi Sam,
On Mon, May 31, 2010 at 11:18 PM, Sam Ravnborg <sam@ravnborg.org> wrote:

>> --- a/arch/mips/Kbuild.platforms
>> +++ b/arch/mips/Kbuild.platforms
>> @@ -1,6 +1,6 @@
>>  # All platforms listed in alphabetic order
>>
>> -platforms += ar7
>> +platforms += alchemy ar7
>
> One line per paltform is better.
> Then the risk for conflicts are less and merging in easier.
> Like this:
>
> platforms += ar7
> platforms += alchemy

Done,


>> diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
>> new file mode 100644
>> index 0000000..1994fdc
>> --- /dev/null
>> +++ b/arch/mips/alchemy/Platform
>> @@ -0,0 +1,103 @@
>> +#
>> +# Common Alchemy Au1x00 stuff
>> +#
>> +core-$(CONFIG_SOC_AU1X00)    += arch/mips/alchemy/common/
>
> The above is actually wrong - despite that it works.
> You are supposed to use:
>
> platform-$(CONFIG_SOC_AU1X00) += alchemy/common/
>
> Then arch/mips/Kbuild will pick it up.
> And then subdirs-ccflags-y := -Werror will also take effect.

Ah, interesting.  I shall look at the full commandline in the future.

I'll do a build of all alchemy boards and resend when there are
no breakages.

Thank you!
     Manuel Lauss
