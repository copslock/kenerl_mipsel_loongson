Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 00:49:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56795 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903713Ab2EVWtw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 00:49:52 +0200
Received: by dadm1 with SMTP id m1so10057628dad.36
        for <linux-mips@linux-mips.org>; Tue, 22 May 2012 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=A9WQbWix97FdzmEUd7ROE/P+2Y1sLU9M1I7lvsGUhA4=;
        b=mvCJyuNw22RPUlo9Yk7eZo1R1Fn2YmAIj0zADqWJqTGNkLNFsPzpWoZYbGOHwwR/WM
         E6K43WQjVjgPfGlS/JOtUmekQQtIM0E1UyDcM++fYth/5jySg/g/EzaSe02zg1IDJefv
         ojTe9LnPXUwH+2x/fC+ONgWuv+sNQR7LhDFNcxdJ5hITwWB7CMmPNf05o0ETRxNjMqZ3
         V+0QxI+inIwPmqQx5IDHEAw6nTO5nwm55U0l5FbjuqUt4lRM45za/e0EIgaejsqf54Cp
         B4SCkgXcRrkqDGbxM1qBFSgei1RP0LqxMfQi6/F9ke0e2RH62KxeL/3ufkbHJ25wF80A
         6A5A==
Received: by 10.68.233.193 with SMTP id ty1mr3427721pbc.47.1337726985834;
        Tue, 22 May 2012 15:49:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i1sm28066081pbv.49.2012.05.22.15.49.44
        (version=SSLv3 cipher=OTHER);
        Tue, 22 May 2012 15:49:45 -0700 (PDT)
Message-ID: <4FBC1807.4050402@gmail.com>
Date:   Tue, 22 May 2012 15:49:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     "devicetree-discuss@lists.ozlabs.org" 
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
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com> <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com> <20120520055436.13AF03E03B8@localhost> <20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com> <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
In-Reply-To: <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/22/2012 01:09 PM, Grant Likely wrote:
> On Tue, May 22, 2012 at 1:45 PM, David Daney<ddaney.cavm@gmail.com>  wrote:
>> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>>
>>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>>> Likely<grant.likely@secretlab.ca>    wrote:
>>>>
>>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>
>>>>   wrote:
>>>>>
>>>>> From: David Daney<david.daney@cavium.com>
>>>>>
>>>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>>>> or "i2c:" to the front of the strings.  This allows the standard
>>>>> modprobe to find the right driver when automatically populating bus
>>>>> children from the device tree structure.
>>>>>
>>>>> Add a prefix parameter, and adjust callers.  For
>>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>>
>>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>>
>>>>
>>>> Applied, thanks.  Some notes below...
>>>
>>>
>>> Wait... why is this necessary?
>>
>>
>> Because in of_register_spi_devices() in of_spi.c, you do:
>>
>>         request_module(spi->modalias);
>>
>> The string passed to request_module() must have the "spi:" prefix.
>
> How about modifying the call to request_module() to include the prefix
> also?  I think that would be a simpler change overall.  Would that
> work?

It seems to.  I just sent such a patch in a new thread.

David Daney
