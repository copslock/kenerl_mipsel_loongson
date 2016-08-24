Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 09:32:40 +0200 (CEST)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36054 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990864AbcHXHcdG07Rb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2016 09:32:33 +0200
Received: by mail-wm0-f44.google.com with SMTP id q128so189581677wma.1
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2016 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dm0Bi7PY4/A/t3hv0JjJA3iYhv0MuCI7c369OykdBFU=;
        b=O6UMeASrTEnc5ki7ivJiM6KUL0ju/3DYlCMqJJ7/JT+CduwbrnAT0TxlqHi/YAD7NH
         14sAEAYwcKbZfF08Q67JRPBPVAaACLobDMNlrOehqJDmKLutjbz7Jmll4AR2Uanog4hh
         qjC+osUqcYXMpTq44cPs/qpOYKI6tH5eFQDO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dm0Bi7PY4/A/t3hv0JjJA3iYhv0MuCI7c369OykdBFU=;
        b=e025UKCMne93zsLMVXw/B111S8PYMAvCukHo8mDceOGJ0h3rht/+VPz2wJ9Et8n45N
         UfTuHVyjpnXB3+DFeYnpKr8QUU3YYg9oaX71qZN8a/X48pk7BdkNbDScKHytXPbXU9L2
         9jWYINHIR6QveNIwVBInqftvB7Ho20MRVojHxp8egjUgoaGZlFG+tyrvcfcJA7/2ZAYB
         erBPUovqDoEn5y/hrs8CoDPllORV3w0KAZgIVWs17VoQw/I/Jx6dwDFvITX2p7+NWwFp
         J/+sTUl6C/cvSYKLxd6xpZNNolvrWhfEAgsDlpqaxPVLZ35FBBaCC0O4xE1e2LuLF1ER
         5Zwg==
X-Gm-Message-State: AE9vXwPuZvhpW4Zj76ehKyUAmlZws3vDJ4wNlJNfyhM1YHYGHc5gjqGHdo1CilDUYRWz7+/PS5wEBESteDKo1FbC
X-Received: by 10.28.9.210 with SMTP id 201mr1658831wmj.104.1472023947780;
 Wed, 24 Aug 2016 00:32:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.221.193 with HTTP; Wed, 24 Aug 2016 00:32:26 -0700 (PDT)
In-Reply-To: <57BCAB27.8060502@caviumnetworks.com>
References: <57853474.9050108@cavium.com> <CAPDyKFqaGLWxkG+CqViqDfPqeffKE5rutgR0gduuGs9F0DX+zg@mail.gmail.com>
 <57BC8ACA.1040506@caviumnetworks.com> <CAPDyKFp047jKEZngegTxk1grvwPivqj+tqAX1ekF82s1zDE53Q@mail.gmail.com>
 <57BCAB27.8060502@caviumnetworks.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Aug 2016 09:32:26 +0200
Message-ID: <CAPDyKFpT0YuuaS3cppp+Q+hPfzOLj6jYSO_KVimLOq_OvPaEzw@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 23 August 2016 at 21:59, David Daney <ddaney@caviumnetworks.com> wrote:
> On 08/23/2016 12:46 PM, Ulf Hansson wrote:
>>
>> On 23 August 2016 at 19:41, David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>> On 08/23/2016 07:53 AM, Ulf Hansson wrote:
>>>>
>>>>
>>>> On 12 July 2016 at 20:18, Steven J. Hill <steven.hill@cavium.com> wrote:
>>>
>>>
>>> [...]
>>>
>>>>> +#include <asm/byteorder.h>
>>>>> +#include <asm/octeon/octeon.h>
>>>>
>>>>
>>>>
>>>
>>> OK, we will duplicate any needed definitions from octeon.h into the
>>> driver
>>> source file.
>>
>>
>> Why can't you share it via a platfrom data header at
>> include/linux/platform_data/* ?
>>
>
> It isn't "platform_data", it is register layout definitions (thousands of
> lines of them), so I don't think it it appropriate to place in
> include/linux.
>
> I think the cleanest approach is to put the register definitions in the
> driver file, which is the only user, and delete the definition header files
> in arch/mips/include/...
>
> David.

I guess we are not looking at the same header file. :-)

arch/mips/include/asm/octeon/octeon.h contains declarations of
functions/structs and even globally exported variables.

At a closer look this header need a serious cleanup anyway...

* Some of the functions/structs are not used or even implemented.
** Some of the functions/structs is used only internally by the SoC
specific code, thus should be moved to a local header.
*** Some of the functions/structs/exported variables is being used by
several clients. The cavium mmc driver is only one of them.

Kind regards
Uffe
