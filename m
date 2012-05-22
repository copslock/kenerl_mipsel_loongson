Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 22:10:24 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:32834 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903704Ab2EVUKR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2012 22:10:17 +0200
Received: by pbbrq13 with SMTP id rq13so10005394pbb.36
        for <linux-mips@linux-mips.org>; Tue, 22 May 2012 13:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=62sXvjcKt9ZIwtEIS3eJbam+MQ9dKaLDWyNs9iFjVUY=;
        b=DJqeBDjgeBtnAiEYZ6YOq00Wbb/ezZl9Y4xYyDqLRPl/MUa2iQ/88dEnR+6ZuApxar
         31HnEGhQqHyCKwPLHAebysACCie4Mw+3pIfRu1okCXLOkDtWztDf2rEeoWX5+WvLm3ng
         SFTZ6s5Dcmr/U0JFNPhZvdxY9Cz/1g9HKEf50SkF5im3YnpdiTEBst6Vi/R8OcIw/mwe
         QjIPB4kmwkjMcwDxgelGJjXzrzE/1B0BwHWsrkHrYWJa3CMX7TtmfKq5TMsWIb8k23sw
         YY3N9DdUTvv81I38+WWog6E3VCWJSibZjhs/IMVe3tzUbcicBm1NSC3H9oMd5pjUvo1F
         TwNA==
Received: by 10.68.197.231 with SMTP id ix7mr2024078pbc.103.1337717410948;
 Tue, 22 May 2012 13:10:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.142.238.9 with HTTP; Tue, 22 May 2012 13:09:50 -0700 (PDT)
In-Reply-To: <4FBBECC2.10503@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com> <20120520055436.13AF03E03B8@localhost>
 <20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Tue, 22 May 2012 14:09:50 -0600
X-Google-Sender-Auth: AeK5M32u5cJp1fo89-ZlN26c9Lc
Message-ID: <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "spi-devel-general@lists.sourceforge.net" 
        <spi-devel-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Liam Girdwood <lrg@ti.com>,
        Tabi Timur-B04825 <B04825@freescale.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQmB3DcmoJq23hPDi2X+H5pmE8w2kJR/tENfLN3TmIqGMu+4aORa8BzQ/oX3eEDRjkRhYWOm
X-archive-position: 33429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, May 22, 2012 at 1:45 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>
>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>> Likely<grant.likely@secretlab.ca>  wrote:
>>>
>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>
>>>  wrote:
>>>>
>>>> From: David Daney<david.daney@cavium.com>
>>>>
>>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>>> or "i2c:" to the front of the strings.  This allows the standard
>>>> modprobe to find the right driver when automatically populating bus
>>>> children from the device tree structure.
>>>>
>>>> Add a prefix parameter, and adjust callers.  For
>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>
>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>
>>>
>>> Applied, thanks.  Some notes below...
>>
>>
>> Wait... why is this necessary?
>
>
> Because in of_register_spi_devices() in of_spi.c, you do:
>
>        request_module(spi->modalias);
>
> The string passed to request_module() must have the "spi:" prefix.

How about modifying the call to request_module() to include the prefix
also?  I think that would be a simpler change overall.  Would that
work?

g.
