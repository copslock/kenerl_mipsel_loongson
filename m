Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 16:21:57 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51775 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903565Ab2C1OVk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 16:21:40 +0200
Received: by obbup16 with SMTP id up16so1720249obb.36
        for <multiple recipients>; Wed, 28 Mar 2012 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YZlfmsEm8zz+hQJmRZoFHXT+FFhNe8BIY7fLYzBMDhs=;
        b=a3cyhOfvezyUw/ixzbsKHi7BuM4D7+XKDDaptERESbW0pn2f7+iO6+wg9Y16y9niKU
         bKPezFpf5wBIaPlskuocv2HhRm2cEzD7mW+kG1VVUyddGNQEAjE8nxN/ICND6B3dBSza
         nyBymKt/6EBySvc+wZHhEA54tDsHjPe1MT78Y2N/P6TCdzEY63hU+e/UJvYz0t9wCCif
         o+we6NjiOJCx7ZqpHhvYHgDbWpXNQVgBMxlg9yLCKtvdp/zP2QRewkycCD23FAats4GS
         cYUtBDSGLNbGwhu6il8O9ZbutOHvsZtr3Nh6hNi6uvwzuj0J2mdnbmlg6zbs+RzAI98X
         0ucQ==
Received: by 10.182.16.1 with SMTP id b1mr24030665obd.31.1332944493021;
        Wed, 28 Mar 2012 07:21:33 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id t5sm2463015oef.10.2012.03.28.07.21.30
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 07:21:31 -0700 (PDT)
Message-ID: <4F731E69.8030907@gmail.com>
Date:   Wed, 28 Mar 2012 09:21:29 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com> <4F7239A4.7070905@gmail.com> <4F723FDD.4080708@cavium.com>
In-Reply-To: <4F723FDD.4080708@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/27/2012 05:31 PM, David Daney wrote:
> On 03/27/2012 03:05 PM, Rob Herring wrote:
>> On 03/27/2012 01:24 PM, David Daney wrote:
>>> On 03/26/2012 06:56 PM, Rob Herring wrote:
>>>> On 03/26/2012 02:31 PM, David Daney wrote:
>>>>> From: David Daney<david.daney@cavium.com>
>>> [...]
>>>>> +static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int
>>>>> bit)
>>>>> +{
>>>>> +    bool edge = false;
>>>>> +
>>>>> +    if (line == 0)
>>>>> +        switch (bit) {
>>>>> +        case 48 ... 49: /* GMX DRP */
>>>>> +        case 50: /* IPD_DRP */
>>>>> +        case 52 ... 55: /* Timers */
>>>>> +        case 58: /* MPI */
>>>>> +            edge = true;
>>>>> +            break;
>>>>> +        default:
>>>>> +            break;
>>>>> +        }
>>>>> +    else /* line == 1 */
>>>>> +        switch (bit) {
>>>>> +        case 47: /* PTP */
>>>>> +            edge = true;
>>>>> +            break;
>>>>> +        default:
>>>>> +            break;
>>>>> +        }
>>>>> +    return edge;
>>>>
>>>> Moving in the right direction, but I still don't get why this is not in
>>>> the CIU binding as a 3rd cell?
>>>
>>> There are a several reasons, in no particular order they are:
>>>
>>> o There is no 3rd cell.  The bindings were discussed with Grant here:
>>>    http://www.linux-mips.org/archives/linux-mips/2011-05/msg00355.html
>>>
>>
>> Then add one.
> 
> I can't.  The dtb is already programmed into the bootloader ROMs,
> changing the kernel code will not change that.  It is fait accompli.
> 
>>
>>> o The edge/level thing cannot be changed, and the irq lines don't leave
>>> the SOC, so hard coding it is possible.
>>
>> Right, but DT describes h/w connections and this is an aspect of the
>> connection. This may be fixed for the SOC, but it's not fixed for the
>> CIU (i.e. could change in future chips), right?
> 
> In theory yes.  However:
> 
> 1) The chip designers will not change it.
> 
> 2) There will likely be no more designs with either CIU or CIU2, so we
> know what all the different possibilities are today.
> 
> When CIU3 is deployed, we will use the lessons we have learned to do
> things the Right Way.
> 
>>
>> There's 2 reasons why you would not put this into DTS:
>>
>> - All irq lines' trigger type are the same, fixed and known.
>> - You can read a register to tell you the trigger type.
>>
>> Even if it's not going to change ever, it's still worth putting into the
>> DTS as it is well suited for holding that data and it is just data.
> 
> Agreed that it could be in the DTS, and retrospect it probably should
> have been put in the DTS, but it wasn't.  So I think what we have now is
> a workable solution, and has the added attraction of working with
> already deployed boards.

Aren't you building in the dtb to the kernel?

It could be argued it doesn't matter what you deployed without upstream
review. But as long as this contained then this one is fine with me.
However, this needs to be understood for each binding as I'm sure there
must be some blocks which will get reused.

Rob
