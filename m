Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 20:13:54 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:43889 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903706Ab2ENSNv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2012 20:13:51 +0200
Received: by dadm1 with SMTP id m1so7069033dad.36
        for <linux-mips@linux-mips.org>; Mon, 14 May 2012 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GdQxWKm3HNSg6EKWENzERg7uqLV+bRZ9J5iRQ9ogIVo=;
        b=eukSPCmWotOEny6efc6/1outLu7GwQGubs9BCTyPa4mERa9wpBGshZ/Emfv6tCiss/
         d+aHy39MYUsq2apnoquhnkN6dmy00M7eC1tvrFRNMnR/H7VJFLfghoqT+krCurwiKu3L
         Huz+fKGrVmrwIpW1s02oaSWFO89CK5pKV0ldhZ8vC3ADQr/uUUnCXpvqxKy1oShbRPET
         i2okxpvisO74G2eAp6TZJ5GKDTmfTHc7Ckm0yr8B++DG+jlLlVHUho3EfiDHHx/xJ+jy
         WAPL7l/BBb0bXyizlO8g+WcW4AfbpRKBGXedtt9QnSBOtaDfPt/vPXmyMWXeYWwSB5Jl
         mYpg==
Received: by 10.68.202.167 with SMTP id kj7mr20309301pbc.9.1337019224902;
        Mon, 14 May 2012 11:13:44 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jv6sm15246511pbc.40.2012.05.14.11.13.42
        (version=SSLv3 cipher=OTHER);
        Mon, 14 May 2012 11:13:43 -0700 (PDT)
Message-ID: <4FB14B55.4070604@gmail.com>
Date:   Mon, 14 May 2012 11:13:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>   <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
In-Reply-To: <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/13/2012 10:46 PM, Shubhrajyoti Datta wrote:
> Hi David,
> A few comments.
>
> On Sat, May 12, 2012 at 3:04 AM, David Daney<ddaney.cavm@gmail.com>  wrote:
[...]

>> +
>> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
> This could be given a miss. As it is less meaningful once accepted.


Well, this leads to the question, what is the purpose of the 
'MODULE_VERSION()' macro?  If I use that, I need to populate it with a 
value.

>
[...]
>> +static void octeon_spi_wait_ready(struct octeon_spi *p)
>> +{
>> +       union cvmx_mpi_sts mpi_sts;
>> +       unsigned int loops = 0;
>> +
>> +       do {
>> +               if (loops++)
>> +                       __delay(500);
> Could we allow  have a non-busy loop here?
>

We could, but I thought about it and chose not to.

The SPI hardware can queue a maximum of 9 bytes (72 bits) before 
software has to take action.  That works out to 3.6 uS at a 20MHz clock 
rate.  Sleeping, scheduling to a different task, taking an interrupt and 
then switching back to this task will likely not be faster than that.

At lower clock rates, it would make more sense, but it adds complexity 
to the driver.  We can always revisit this decision if it proves to be a 
problem.

David Daney
