Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 09:18:26 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:44559 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1ETHSU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2011 09:18:20 +0200
Received: by gwb1 with SMTP id 1so1423316gwb.36
        for <multiple recipients>; Fri, 20 May 2011 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GgRIUWzhwYeV+3CfVnU/vGiqPr92jO2/YFouYXi8dlE=;
        b=ozwujM7gkUOWwdjaXq4X/4WRl1G35Kk3fkGVxrwRfdrkrPp6X7RQCkIblq0QETvtYg
         5L00CtwahZUgKvL/OHoW8xECD7xYSUhdFvnbBhh01zB0aaP9dqaAzFsuynlFk80CXJB/
         M9uif5iIJYH5KqQRjPUHlEihmww3nfUSejsXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kAo3jAB8IqjcDUsib2XFP4TuLd6A6gvjfvBDRPJY18ZoEpOBn/41trvyhpZNHE04kX
         S/cnvuCsIIn36MHk9eKxm6uiY0W+NPQ5MiZdPAZRXjBRaI/INC0fyxOUOiR7xQbyX0ZW
         8QEVb9O/2mpJvMwSZxACqIQSQ3nckQ9Ej9txA=
MIME-Version: 1.0
Received: by 10.236.191.164 with SMTP id g24mr4531500yhn.513.1305875894410;
 Fri, 20 May 2011 00:18:14 -0700 (PDT)
Received: by 10.236.95.136 with HTTP; Fri, 20 May 2011 00:18:14 -0700 (PDT)
In-Reply-To: <20110520071256.GA23902@linux-mips.org>
References: <20110519231911.GB10628@linux-mips.org>
        <s5hoc2x7tsr.wl%tiwai@suse.de>
        <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
        <20110520071256.GA23902@linux-mips.org>
Date:   Fri, 20 May 2011 09:18:14 +0200
Message-ID: <BANLkTinp4wY3ZNxAc1PvCz1ujHQrG1wE2w@mail.gmail.com>
Subject: Re: [RFC] Remove Alchemy OSS drivers?
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-mips@linux-mips.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 9:12 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, May 20, 2011 at 08:51:37AM +0200, Manuel Lauss wrote:
>
>> On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Fri, 20 May 2011 00:19:12 +0100,
>> > Ralf Baechle wrote:
>> >>
>> >> OSS has very little if any useful life in it left for MIPS, at least from
>> >> my perspective.  So I propose to remove the Au1550 driver - there is an
>> >> ALSA replacement for it available.
>> >
>> > Even two variants available: one in ASoC driver and one in old ALSA
>> > driver.
>>
>> The current ASoC code can replace sound/oss/au1550_ac97.c,
>> but sound/mips/au1x00.c is for different (earlier) chips.  I wrote an ASoC
>> variant of this a long time ago, but I can't test it on real hardware.
>
> My immediate interest is to kill off sounds/oss/ on MIPS because
> sound/oss/soundcard.c is fairly ISA centric and does not build for some
> some MIPS systems with only half-arsed ISA support, that is no DMA support.
>
> Manuel, I got a DBAu1250 board here and maybe I can find a DBAu1500
> Zinfandel board under some dusty hardware pile; would that be suitable for
> testing your work?

Yes, the db1500 would be perfect.

Manuel
