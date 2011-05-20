Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 08:51:49 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:41205 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1ETGvo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2011 08:51:44 +0200
Received: by ywf9 with SMTP id 9so1420510ywf.36
        for <multiple recipients>; Thu, 19 May 2011 23:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gFoxWch6JtPpBAQXpVKbJG2z2vtbC2vFNRzqoi2X+os=;
        b=JoM0uwaEY6f4vFSaUx9MHdDbaahiflZFnZGCr8TAgwIyPUVyplZ5+G5GyniC/XXcRy
         lWeNImaUwVHee5tL/dpZDiYwXYCKkiHsF/ZW/7maWrvTab7q6wjoJ1YGvvlN1vmkgbvi
         F/tXlBDK+V7jWdmeqxY85Dv9qUEL6TSGzc0e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P7OFDCvXW5tK1pW2wzvTyc/CD952PXJVBWDcWdo1xUwKXubkppRCWxWHh50mjnto3W
         TkZNjqDWz/7uuE6uuUVfGyOJYx374ZAlH3euXCwDWxQxgph4j9zOZXhGuq/SpZIaahKs
         mj3y5Au6vqEb9mWEzHpjHnN4G/2/kBbHpdCiA=
MIME-Version: 1.0
Received: by 10.236.192.228 with SMTP id i64mr4720331yhn.111.1305874297495;
 Thu, 19 May 2011 23:51:37 -0700 (PDT)
Received: by 10.236.95.136 with HTTP; Thu, 19 May 2011 23:51:37 -0700 (PDT)
In-Reply-To: <s5hoc2x7tsr.wl%tiwai@suse.de>
References: <20110519231911.GB10628@linux-mips.org>
        <s5hoc2x7tsr.wl%tiwai@suse.de>
Date:   Fri, 20 May 2011 08:51:37 +0200
Message-ID: <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
Subject: Re: [RFC] Remove Alchemy OSS drivers?
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Namhyung Kim <namhyung@gmail.com>, lkml@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 20 May 2011 00:19:12 +0100,
> Ralf Baechle wrote:
>>
>> OSS has very little if any useful life in it left for MIPS, at least from
>> my perspective.  So I propose to remove the Au1550 driver - there is an
>> ALSA replacement for it available.
>
> Even two variants available: one in ASoC driver and one in old ALSA
> driver.

The current ASoC code can replace sound/oss/au1550_ac97.c,
but sound/mips/au1x00.c is for different (earlier) chips.  I wrote an ASoC
variant of this a long time ago, but I can't test it on real hardware.

Manuel
