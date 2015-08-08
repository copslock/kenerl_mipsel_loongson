Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 02:28:45 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38011 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013431AbbHHA2n05HCk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 02:28:43 +0200
Received: by wibxm9 with SMTP id xm9so84409543wib.1
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 17:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cESPoi3SoSFGbiRXVWSGigGnMSuLYdrsruzevR8YLZo=;
        b=IC5H3Li7V5hQ6nhMMdh+994GVKhrVBEEmJjIeNJLtF1A5plpXXgGfuvWDl1sOLJss3
         PUXXD95lfudtzGgYxO/5I+fmCsJaLpwzFtcYWl3yd2WvvVxEYobD4PfNXO17M4myKGvi
         7CZhctDillV89aiR3F6cxJV4FAbJM7f3LdAfEhUQ466Q09gwVHEeUbli8XorYP5f0IM1
         VS29kS/M19riqU6q/cr0aZRBGA6SReuSIGFh+d2KXK12UmNDyL2VJwl6R8706OvZpY3T
         /l60OIPc9vninUgJChDtyzoeW9Fo2hfnWBwZlCGFVFxnbJwEZX5qF0bYEE/KvwlXrjSg
         q1BA==
MIME-Version: 1.0
X-Received: by 10.180.198.178 with SMTP id jd18mr1715336wic.14.1438993718235;
 Fri, 07 Aug 2015 17:28:38 -0700 (PDT)
Received: by 10.27.157.65 with HTTP; Fri, 7 Aug 2015 17:28:38 -0700 (PDT)
In-Reply-To: <55C5494D.5010903@caviumnetworks.com>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
        <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
        <20150807140106.GE7646@leverpostej>
        <55C4ECC6.7050908@caviumnetworks.com>
        <20150807175127.GB12013@leverpostej>
        <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>
        <55C5494D.5010903@caviumnetworks.com>
Date:   Sat, 8 Aug 2015 02:28:38 +0200
X-Google-Sender-Auth: jPP057RZ2qVOHTotMQF-Jtsrf18
Message-ID: <CAJZ5v0iNqRsrpwzWY5o97R1S+Dr-CzRPg3Cymt1q4v5gvABCQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
From:   "Rafael J. Wysocki" <rafael@kernel.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "rob.herring@linaro.org" <rob.herring@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Robert Richter <rrichter@cavium.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafael@kernel.org
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

Hi David,

On Sat, Aug 8, 2015 at 2:11 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 08/07/2015 05:05 PM, Rafael J. Wysocki wrote:

[cut]

>>
>> It is actually useful to people as far as I can say.
>>
>> Also, if somebody is going to use properties with ACPI, why whould
>> they use a different set of properties with DT?
>>
>> Wouldn't it be more reasonable to use the same set in both cases?
>
>
> Yes, but there is still quite a bit of leeway to screw things up.

That I have to agree with, unfortunately.

On the other hand, this is a fairly new concept and we need to gain
some experience with it to be able to come up with best practices and
so on.  Cases like yours are really helpful here.

> FWIW:  http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf
>
> This actually seems to have been adopted by the UEFI people as a
> "Standard", I am not sure where a record of this is kept though.

Work on this is in progress, but far from completion.  Essentially,
what's needed is more pressure from vendors who want to use properties
in their firmware.

> So, we are changing our firmware to use this standard (which is quite
> similar the the DT with respect to MAC addresses).

Cool. :-)

Thanks,
Rafael
