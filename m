Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 01:02:21 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53836 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903714Ab2EVXCR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2012 01:02:17 +0200
Received: by pbbrq13 with SMTP id rq13so10182993pbb.36
        for <linux-mips@linux-mips.org>; Tue, 22 May 2012 16:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=LZ4pyIEkUPi0ji5/UL3hU+XCzFAS9114iJ3KNSYevjk=;
        b=iSrpPq2N16FUxQdvuuXUEWdvHf04oRYS2jZueE07QtJDBpH3MBaRRmyr4lzA4AET42
         e53wmfPaC9WHHB7clHyJZO7uAozWqfU1I38fDtB+5Zb9gQTuK/DOtDShzB8BJapeC7HX
         HyFROfbh/0d3XQbktVEals+tmUhkVjhFCDAP7D4Fo9tAifXrt7pL2swkATekmd+CAeH/
         7oosXz4uzKdw+d4yxkrGMKs0wEkpV7VKdxseeIj1ZeGwimK3lLHV/RCSen5SIYeXCovn
         ybRnyehQ0OHFhjw1A4HNoXwwxP7i9RqgCUqpWa0arJezeQL2z2m8UrG5FRj79FCX6va8
         pNWA==
Received: by 10.68.233.193 with SMTP id ty1mr3511183pbc.47.1337727731315; Tue,
 22 May 2012 16:02:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.142.238.9 with HTTP; Tue, 22 May 2012 16:01:51 -0700 (PDT)
In-Reply-To: <4FBC1807.4050402@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com> <20120520055436.13AF03E03B8@localhost>
 <20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com>
 <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com> <4FBC1807.4050402@gmail.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Tue, 22 May 2012 17:01:51 -0600
X-Google-Sender-Auth: VJ0DlmJCvobI3s5mjMIFbn7aKyk
Message-ID: <CACxGe6sY++3jreWbQ4jvmmkbeUitMgYYd-oa4x+_49OMyV7O+Q@mail.gmail.com>
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
X-Gm-Message-State: ALoCoQkarBhLXs8R4cSXKLGsqwFIx7gKrDOmtmRB1UHSHIUq7dPw1WMY7huunyiSdhNlvPaUfEOI
X-archive-position: 33432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Cool, thanks.

g.

On Tue, May 22, 2012 at 4:49 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 05/22/2012 01:09 PM, Grant Likely wrote:
>>
>> On Tue, May 22, 2012 at 1:45 PM, David Daney<ddaney.cavm@gmail.com>
>>  wrote:
>>>
>>> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>>>
>>>>
>>>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>>>> Likely<grant.likely@secretlab.ca>    wrote:
>>>>>
>>>>>
>>>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>
>>>>>  wrote:
>>>>>>
>>>>>>
>>>>>> From: David Daney<david.daney@cavium.com>
>>>>>>
>>>>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>>>>> or "i2c:" to the front of the strings.  This allows the standard
>>>>>> modprobe to find the right driver when automatically populating bus
>>>>>> children from the device tree structure.
>>>>>>
>>>>>> Add a prefix parameter, and adjust callers.  For
>>>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>>>
>>>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>>>
>>>>>
>>>>>
>>>>> Applied, thanks.  Some notes below...
>>>>
>>>>
>>>>
>>>> Wait... why is this necessary?
>>>
>>>
>>>
>>> Because in of_register_spi_devices() in of_spi.c, you do:
>>>
>>>        request_module(spi->modalias);
>>>
>>> The string passed to request_module() must have the "spi:" prefix.
>>
>>
>> How about modifying the call to request_module() to include the prefix
>> also?  I think that would be a simpler change overall.  Would that
>> work?
>
>
> It seems to.  I just sent such a patch in a new thread.
>
> David Daney



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
